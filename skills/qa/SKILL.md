# QA - Quality Assurance & Testing

## Description
Stratégies de test pour applications métier. Couvre tests unitaires, intégration, E2E, performance, et UAT. Intègre des agents autonomes pour exécuter les tests, générer des rapports et lancer des cycles d'amélioration automatisés. Vise un taux de couverture fonctionnelle ≥90%.

## Quand utiliser
- Avant mise en production
- Validation d'une user story
- Regression testing après mises à jour
- Pilote avant rollout massif
- Post-deployment validation
- Cycle d'amélioration continue (CI/CD)

---

## Pyramide de Tests

```
         +----------+
         |   UAT    |  (5% - Manuel + semi-auto)
         +----------+
        +-----------+
        |    E2E    |  (10% - Playwright automatisé)
        +-----------+
       +-------------+
       | Integration |  (20% - Testcontainers + API)
       +-------------+
      +---------------+
      |  Unit / API   |  (65% - Pytest / Vitest automatisé)
      +---------------+
```

**Règle :** Plus le test est haut dans la pyramide, plus il est lent et coûteux. Investir dans les couches basses.

---

## Types de Tests

### 1. Tests Unitaires (Backend - Pytest)
**Pour :** Fonctions, services, validation, logique métier

```python
# tests/unit/test_document_service.py
import pytest
from app.services.document_service import DocumentService
from app.schemas.document import DocumentCreate
from unittest.mock import AsyncMock, MagicMock

@pytest.fixture
def mock_repo():
    return AsyncMock()

@pytest.fixture
def service(mock_repo):
    return DocumentService(repository=mock_repo)

@pytest.mark.asyncio
async def test_create_document_success(service, mock_repo):
    """Document créé avec les bonnes données."""
    data = DocumentCreate(title="Test Doc", project_id="proj-123")
    mock_repo.create.return_value = MagicMock(id="doc-1", title="Test Doc")

    result = await service.create(data, user_id="user-1")

    assert result.title == "Test Doc"
    mock_repo.create.assert_called_once()

@pytest.mark.asyncio
async def test_create_document_empty_title_raises(service):
    """Titre vide doit lever une erreur de validation."""
    with pytest.raises(ValueError, match="Title cannot be empty"):
        await service.create(DocumentCreate(title="", project_id="proj-1"),
                             user_id="user-1")
```

### 2. Tests Unitaires (Frontend - Vitest)
**Pour :** Composants React, hooks, utilitaires

```tsx
// src/components/DocumentCard/DocumentCard.test.tsx
import { render, screen, fireEvent } from '@testing-library/react'
import { DocumentCard } from './DocumentCard'

describe('DocumentCard', () => {
  const baseProps = {
    title: 'Rapport 2024',
    status: 'approved',
    owner: { name: 'Marie Dupont' },
  }

  it('affiche le titre et le statut', () => {
    render(<DocumentCard {...baseProps} />)
    expect(screen.getByText('Rapport 2024')).toBeInTheDocument()
    expect(screen.getByText('approved')).toBeInTheDocument()
  })

  it('appelle onDelete au clic sur supprimer', () => {
    const onDelete = vi.fn()
    render(<DocumentCard {...baseProps} onDelete={onDelete} />)
    fireEvent.click(screen.getByRole('button', { name: /supprimer/i }))
    expect(onDelete).toHaveBeenCalledOnce()
  })

  it('affiche le skeleton en mode loading', () => {
    render(<DocumentCard isLoading />)
    expect(screen.getByTestId('skeleton')).toBeInTheDocument()
    expect(screen.queryByText('Rapport 2024')).not.toBeInTheDocument()
  })
})
```

### 3. Tests d'Intégration (Testcontainers - vraie DB)
**Pour :** Repositories, migrations, requêtes complexes

```python
# tests/integration/test_document_repository.py
import pytest
import asyncpg
from testcontainers.postgres import PostgresContainer
from app.repositories.document_repository import DocumentRepository
from app.database import get_db_pool

@pytest.fixture(scope="module")
def postgres():
    with PostgresContainer("postgres:16-alpine") as pg:
        yield pg

@pytest.fixture(scope="module")
async def db_pool(postgres):
    """Pool de connexion vers PostgreSQL de test (vraie DB, pas de mock)."""
    pool = await asyncpg.create_pool(postgres.get_connection_url())
    # Appliquer les migrations
    await apply_migrations(pool)
    yield pool
    await pool.close()

@pytest.mark.asyncio
async def test_create_and_retrieve_document(db_pool):
    repo = DocumentRepository(db_pool)

    doc_id = await repo.create({
        "title": "Test Integration",
        "project_id": "proj-test",
        "owner_id": "user-test",
        "status": "draft"
    })

    retrieved = await repo.get_by_id(doc_id)
    assert retrieved["title"] == "Test Integration"
    assert retrieved["status"] == "draft"

@pytest.mark.asyncio
async def test_soft_delete(db_pool):
    repo = DocumentRepository(db_pool)
    doc_id = await repo.create({"title": "To Delete", "project_id": "p1",
                                 "owner_id": "u1", "status": "draft"})

    await repo.soft_delete(doc_id)
    retrieved = await repo.get_by_id(doc_id)

    assert retrieved is None  # Soft-deleted, invisible pour l'app
    # Mais toujours en DB pour audit
    raw = await db_pool.fetchrow(
        "SELECT deleted_at FROM documents WHERE id = $1", doc_id)
    assert raw["deleted_at"] is not None
```

### 4. Tests E2E (Playwright)
**Pour :** Parcours utilisateur complets, cross-browser

```typescript
// tests/e2e/document-workflow.spec.ts
import { test, expect } from '@playwright/test'
import { loginAs } from './helpers/auth'

test.describe('Workflow approbation document', () => {
  test('manager peut approuver un document en attente', async ({ page }) => {
    await loginAs(page, 'manager@test.com', 'password')

    await page.goto('/documents?status=pending')
    await expect(page.locator('[data-testid="document-list"]')).toBeVisible()

    // Ouvrir premier document en attente
    await page.locator('[data-testid="document-row"]').first().click()
    await expect(page.locator('h1')).toContainText('Rapport')

    // Approuver
    await page.click('[data-testid="btn-approve"]')
    await page.fill('[data-testid="approval-comment"]', 'Approuvé pour déploiement')
    await page.click('[data-testid="btn-confirm-approve"]')

    // Vérifier statut mis à jour
    await expect(page.locator('[data-testid="status-badge"]')).toHaveText('approved')
    await expect(page.locator('[role="alert"]')).toContainText('Document approuvé')
  })

  test('utilisateur sans droit ne peut pas approuver', async ({ page }) => {
    await loginAs(page, 'user@test.com', 'password')
    await page.goto('/documents/doc-pending-123')

    // Bouton approuver absent
    await expect(page.locator('[data-testid="btn-approve"]')).not.toBeVisible()
  })
})
```

**Configuration Playwright :**
```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './tests/e2e',
  use: {
    baseURL: process.env.E2E_BASE_URL || 'http://localhost:3000',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
    trace: 'on-first-retry',
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'mobile-safari', use: { ...devices['iPhone 13'] } },
  ],
})
```

### 5. Tests de Performance (k6)
**Pour :** Valider les SLA avant mise en production

```javascript
// tests/performance/load-test.js
import http from 'k6/http'
import { check, sleep } from 'k6'
import { Rate } from 'k6/metrics'

const errorRate = new Rate('errors')

export const options = {
  stages: [
    { duration: '2m', target: 10 },   // Montée progressive
    { duration: '5m', target: 50 },   // Charge nominale
    { duration: '2m', target: 100 },  // Pic charge
    { duration: '2m', target: 0 },    // Descente
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],  // 95% des requêtes < 500ms
    http_req_failed: ['rate<0.01'],    // Moins de 1% d'erreurs
    errors: ['rate<0.01'],
  },
}

export default function () {
  // Login
  const loginRes = http.post(`${__ENV.BASE_URL}/api/auth/login`, JSON.stringify({
    email: 'perf-test@test.com',
    password: 'test-password'
  }), { headers: { 'Content-Type': 'application/json' } })

  check(loginRes, { 'login 200': (r) => r.status === 200 })
  const token = loginRes.json('access_token')
  errorRate.add(loginRes.status !== 200)

  // Liste documents
  const listRes = http.get(`${__ENV.BASE_URL}/api/documents`, {
    headers: { Authorization: `Bearer ${token}` }
  })
  check(listRes, {
    'list 200': (r) => r.status === 200,
    'list <500ms': (r) => r.timings.duration < 500,
  })
  errorRate.add(listRes.status !== 200)

  sleep(1)
}
```

---

## Test Plan Template

```markdown
# Test Plan: [Projet / Sprint]

**Version:** 1.0 | **Owner:** [Nom] | **Sprint:** [Numéro]

## 1. Scope
**In Scope:**
- User stories: [US-001, US-002, ...]
- Features: [Liste fonctionnalités testées]
- Couches: Unit, Integration, E2E, Performance

**Out of Scope:**
- [Feature hors sprint]
- [Systèmes non modifiés]

## 2. Approche de Test

| Type | Couverture | Outil | Automatisé | Responsable |
|------|-----------|-------|-----------|-------------|
| Unit | Services, validators | Pytest / Vitest | Oui (CI) | Dev |
| Integration | DB, API contracts | Testcontainers / Bruno | Oui (CI) | Dev |
| E2E | Parcours critiques | Playwright | Oui (staging) | QA |
| Performance | SLA API + DB | k6 | Oui (avant prod) | QA |
| UAT | Scénarios métier | Manuel avec guide | Non | Users pilotes |

## 3. Cas de Tests Prioritaires

### Critiques (bloquants avant déploiement)
- [ ] TC-001: [Titre] → US-001
- [ ] TC-002: [Titre] → US-002

### Importants (bloquants avant rollout)
- [ ] TC-003: [Titre]

### Régression (à chaque déploiement)
- [ ] Authentification (login/logout/2FA)
- [ ] CRUD sur entités principales
- [ ] Workflow principal (happy path)

## 4. Données de Test
- **Comptes :** admin@test.com, manager@test.com, user@test.com (dans fixtures)
- **Données :** Fixtures JSON + factory functions
- **Environnement :** Staging isolé (jamais de test sur prod)

## 5. Entry/Exit Criteria

**Entry (avant de commencer):**
- [ ] US codées et déployées en staging
- [ ] Environnement staging opérationnel
- [ ] Données de test préparées (fixtures)

**Exit (avant de livrer):**
- [ ] 100% tests critiques passés
- [ ] 0 bug critique ouvert
- [ ] Couverture tests unitaires ≥80%
- [ ] Performance SLA validés
- [ ] UAT sign-off ≥3/5 pilotes

## 6. Schedule
- Tests unitaires: En continu (CI sur chaque PR)
- Tests intégration: Staging (daily build)
- Tests E2E: Staging (nightly build)
- Tests performance: Sprint J-3 avant déploiement
- UAT: Sprint J-7 à J-5

## 7. Risques
| Risque | Mitigation |
|--------|------------|
| Staging instable | Notifications alerte staging + backup env |
| Users UAT indisponibles | Planifier 2 semaines à l'avance |
| Performances dégradées | Profiling DB + indexes (consulter /dba) |
```

---

## Agent Autonome QA

> Le QA Agent peut exécuter des cycles de test autonomes, générer des rapports et proposer des améliorations.

### Cycle Autonome (CI/CD)

```yaml
# .github/workflows/qa-pipeline.yml
name: QA Pipeline

on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run unit tests + coverage
        run: |
          pytest tests/unit/ \
            --cov=app \
            --cov-report=xml \
            --cov-report=term-missing \
            --cov-fail-under=80 \
            -v
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
    steps:
      - uses: actions/checkout@v4
      - name: Run integration tests
        run: pytest tests/integration/ -v

  e2e-tests:
    runs-on: ubuntu-latest
    needs: [unit-tests, integration-tests]
    steps:
      - uses: actions/checkout@v4
      - name: Start stack
        run: docker-compose -f docker-compose.staging.yml up -d
      - name: Run Playwright
        run: npx playwright test --reporter=html
      - name: Upload report
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/

  performance-tests:
    runs-on: ubuntu-latest
    needs: e2e-tests
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Run k6 load test
        uses: grafana/k6-action@v0.3.1
        with:
          filename: tests/performance/load-test.js
          flags: --env BASE_URL=${{ vars.STAGING_URL }}
```

### Rapport de Tests Automatisé

```markdown
# QA Report: [Projet] - Sprint [N]

**Généré le:** YYYY-MM-DD HH:MM
**Pipeline:** [Lien CI/CD]
**Environnement:** Staging v[X.Y.Z]

## Résumé

| Couche | Total | Passés | Échoués | Skippés | Durée |
|--------|-------|--------|---------|---------|-------|
| Unit | 142 | 140 | 2 | 0 | 45s |
| Integration | 38 | 38 | 0 | 0 | 1m 20s |
| E2E | 24 | 22 | 2 | 0 | 4m 10s |
| Performance | - | OK | - | - | 10m |

**Couverture code:** 84% (cible: ≥80%)
**Statut global:** PARTIEL - 4 tests en échec

## Tests en Échec

### FAIL: test_create_document_empty_title_raises
**Fichier:** tests/unit/test_document_service.py:45
**Erreur:** AssertionError: Expected ValueError, got ValidationError
**Impact:** US-003 - Validation formulaire création
**Priorité:** High (bloquant déploiement)
**Recommandation:** Vérifier mapping exception Pydantic → ValueError dans service

### FAIL: E2E - manager peut approuver un document
**Fichier:** tests/e2e/document-workflow.spec.ts:23
**Erreur:** TimeoutError: btn-approve not visible after 5000ms
**Impact:** Workflow approbation (parcours critique)
**Priorité:** Critical (bloquant)
**Recommandation:** Vérifier sélecteur data-testid="btn-approve" dans DocumentDetail

## Performance SLA

| Endpoint | p50 | p95 | p99 | Erreurs | Statut |
|----------|-----|-----|-----|---------|--------|
| GET /api/documents | 45ms | 180ms | 320ms | 0% | OK |
| POST /api/documents | 120ms | 450ms | 890ms | 0.2% | WARNING |
| GET /api/search | 95ms | 520ms | 1100ms | 0% | WARNING |

**Observations:**
- POST /documents approche la limite de 500ms en p95
- Recommandation: Analyser avec EXPLAIN ANALYZE (consulter /dba)
- GET /search dépasse 500ms en p99 → Index full-text à vérifier

## Améliorations Recommandées

### Priorité Haute
1. Corriger les 2 tests en échec avant déploiement
2. Optimiser POST /documents (profiler le service)

### Priorité Moyenne
3. Ajouter tests pour edge cases US-004 (couverture actuellement 67%)
4. Snapshot tests Storybook pour composants DocumentCard

### Priorité Basse
5. Améliorer messages d'erreur dans les tests (plus descriptifs)
6. Ajouter test performance pour endpoint /api/export

## Décision Go/No-Go

**Statut:** NO-GO - Corriger les 2 tests critiques avant déploiement

**Conditions pour GO:**
- [ ] FAIL unit test corrigé (PR #45)
- [ ] FAIL E2E corrigé (PR #46)
- [ ] Re-run pipeline complet
```

### Script d'amélioration automatique

```python
# scripts/qa_improvement_cycle.py
"""
Script lancé automatiquement après chaque rapport QA.
Analyse les résultats et crée des issues/suggestions d'amélioration.
"""

import json
import subprocess
from pathlib import Path

def analyze_coverage_gaps(coverage_report: dict) -> list[str]:
    """Identifie les fichiers sous le seuil de couverture."""
    suggestions = []
    for file, data in coverage_report["files"].items():
        if data["summary"]["percent_covered"] < 80:
            suggestions.append(
                f"- {file}: {data['summary']['percent_covered']:.0f}% "
                f"(manque {data['summary']['missing_lines']} lignes)"
            )
    return suggestions

def analyze_performance_degradation(current: dict, baseline: dict) -> list[str]:
    """Compare performance avec le baseline et signale les régressions."""
    warnings = []
    for endpoint, metrics in current.items():
        if endpoint in baseline:
            degradation = (metrics["p95"] - baseline[endpoint]["p95"]) / baseline[endpoint]["p95"]
            if degradation > 0.1:  # >10% dégradation
                warnings.append(
                    f"- {endpoint}: p95 dégradé de {degradation:.0%} "
                    f"({baseline[endpoint]['p95']}ms -> {metrics['p95']}ms)"
                )
    return warnings

def generate_improvement_report(test_results: dict) -> str:
    """Génère un rapport d'amélioration avec actions prioritaires."""
    report = ["# Rapport d'Amélioration QA", ""]

    # Tests en échec
    if test_results["failed"] > 0:
        report.append("## Actions Immédiates (Bloquant)")
        for failure in test_results["failures"]:
            report.append(f"- Corriger: `{failure['test']}` → {failure['recommendation']}")

    # Couverture
    coverage_gaps = analyze_coverage_gaps(test_results["coverage"])
    if coverage_gaps:
        report.append("\n## Couverture Insuffisante (<80%)")
        report.extend(coverage_gaps)

    # Performance
    perf_warnings = analyze_performance_degradation(
        test_results["performance"]["current"],
        test_results["performance"]["baseline"]
    )
    if perf_warnings:
        report.append("\n## Régressions Performance")
        report.extend(perf_warnings)
        report.append("\nAction: Consulter skill /dba pour analyse index")

    return "\n".join(report)
```

---

## UAT (User Acceptance Testing)

```markdown
## UAT Session: [Projet] - [Feature]

**Date:** YYYY-MM-DD | **Testeurs:** [5 users pilotes]
**Durée:** 1 semaine d'usage réel

### Scénario 1: [Parcours utilisateur principal]
**Contexte:** [Situation réaliste]

- [ ] Étape 1: [Action]
- [ ] Étape 2: [Action]
- [ ] Étape 3: [Action]
**Critère de succès:** [Résultat attendu mesurable]

### Scénario 2: [Parcours alternatif]
...

### Collecte de Feedback
**Méthode:** Survey + entretien court (15min) post-session

**Questions:**
1. Niveau de facilité d'utilisation (1-5) : [Note]
2. Qu'est-ce qui a bien fonctionné ? [Texte libre]
3. Qu'est-ce qui était difficile/frustrant ? [Texte libre]
4. Suggestions d'amélioration : [Texte libre]

**Décision:** Go-Live / Fix Issues / Abort
```

---

## Regression Suite (Exécutée à chaque déploiement)

```markdown
### Tests Critiques - Chemin Principal

#### Authentification
- [ ] Login avec credentials valides (2FA si activé)
- [ ] Logout propre (session révoquée)
- [ ] Accès refusé sans token valide
- [ ] Accès refusé avec rôle insuffisant

#### CRUD Principal
- [ ] Créer entité principale (happy path)
- [ ] Lire liste avec pagination
- [ ] Modifier (mise à jour partielle)
- [ ] Supprimer (soft delete si applicable)

#### Workflow Métier
- [ ] Workflow complet happy path (état initial → état final)
- [ ] Transition d'état invalide bloquée
- [ ] Notification envoyée sur événement critique

#### Sécurité
- [ ] Pas de données d'un autre tenant visibles (si multi-tenant)
- [ ] Injection SQL bloquée (test paramétrisé)
- [ ] Token expiré → 401 retourné

**Fréquence:** Avant chaque déploiement staging + prod
**Outil:** Playwright (automatisé) + checklist manuelle (UAT)
```

---

## Bug Template

```markdown
## BUG-[ID]: [Titre Court]

**Sévérité:** Critical / High / Medium / Low
**Priorité:** P0 (hotfix) / P1 (ce sprint) / P2 (prochain sprint) / P3 (backlog)
**Statut:** Open / In Progress / Fixed / Verified / Closed

**Environnement:**
- URL: [staging.app.com ou prod]
- Browser/OS: [Chrome 120 / macOS 14]
- User rôle: [manager]

**Reproduction:**
1. Aller à [URL]
2. Cliquer sur [X]
3. Observer [Y]

**Comportement attendu:** [Ce qui devrait se passer]
**Comportement actuel:** [Ce qui se passe]

**Screenshots / Logs:** [Joindre]

**Impact:**
- Users affectés: [Nombre ou %]
- Workaround: Oui/Non - [Description si Oui]
- Impact métier: [Description]

**Root Cause (après analyse):** [Explication technique]
**Fix:** [Solution implémentée]
**Vérification:** [Comment le fix a été testé]
```

### Définitions Sévérité
| Sévérité | Définition | Exemple | SLA |
|----------|-----------|---------|-----|
| Critical | Système inaccessible, perte de données | Login impossible pour tous | 4h |
| High | Fonctionnalité principale cassée | Workflow approbation bloqué | 1 jour |
| Medium | Fonctionnalité secondaire défaillante | Filtre de recherche incorrect | 1 semaine |
| Low | Cosmétique, typo, comportement mineur | Libellé bouton incorrect | Backlog |

---

## Métriques Qualité

```markdown
### KPIs QA à suivre par sprint

| Métrique | Cible | Critique |
|----------|-------|---------|
| Couverture tests unitaires | ≥80% | <60% |
| E2E parcours critiques | 100% passés | <90% |
| Bugs critiques en prod | 0 | >0 |
| Escaped defects (bugs trouvés en prod) | <5% | >10% |
| Satisfaction UAT | >80% positif | <60% |
| Performance SLA (p95) | <500ms | >1s |

### Dashboard métriques (Grafana)
- Évolution couverture code par sprint
- Tendance bugs par sévérité
- Temps de build et test pipeline
- Flakiness rate (tests instables)
```

---

## Checklist Definition of Done (DoD)

### Code Quality
- [ ] Tests unitaires passent (CI vert)
- [ ] Couverture ≥80% sur nouveaux fichiers
- [ ] Pas de warnings Ruff/ESLint
- [ ] Review de code effectuée

### Fonctionnel
- [ ] Tous les acceptance criteria de la US validés
- [ ] Tests fonctionnels E2E passent
- [ ] Tests d'intégration passent

### Sécurité
- [ ] Pas de credential en dur (git secrets scan)
- [ ] RBAC vérifié (endpoints avec rôle requis testés)
- [ ] Inputs validés côté backend

### UAT
- [ ] 3/5 users pilotes valident le scénario
- [ ] 0 bug critique ouvert
- [ ] Documentation utilisateur à jour

### Déploiement
- [ ] Staging validé (même image que prod)
- [ ] Migration DB testée (upgrade + downgrade)
- [ ] Rollback plan documenté
- [ ] Monitoring + alertes configurés

---

## Bonnes Pratiques

1. **Test Early, Test Often :** Tests unitaires écrits en même temps que le code
2. **Testcontainers pour l'intégration :** Vraie DB, pas de mocks (évite les faux positifs)
3. **Playwright pour E2E :** data-testid attributs stables (pas de sélecteurs CSS fragiles)
4. **Pilote avant rollout :** TOUJOURS tester avec 5 users réels avant déploiement massif
5. **Pipeline comme porte :** Déploiement bloqué si pipeline en échec (pas d'override)
6. **Rapport d'amélioration :** Chaque sprint, analyser les tendances et agir

## Anti-Patterns

- "Works on my machine" sans staging test
- Skip pilote pour gagner du temps (risque catastrophique)
- Mocks de base de données (tests qui passent mais intégration cassée)
- Tests E2E avec sélecteurs CSS (fragiles, cassent au moindre redesign)
- Bug sans sévérité/priorité (confusion, priorisation impossible)
- Tester en production directement
- Pipeline QA optionnel (skip possible)

## Outils

**Backend :**
- Pytest (tests Python)
- Testcontainers (vraie DB en test)
- pytest-asyncio (tests async)
- pytest-cov (couverture)

**Frontend :**
- Vitest + Testing Library (unit)
- Playwright (E2E, cross-browser)
- Storybook + Chromatic (tests visuels)

**API & Performance :**
- Bruno (open-source, tests API)
- k6 (performance et charge)
- Grafana k6 Cloud (si besoin dashboard)

**CI/CD :**
- GitHub Actions / GitLab CI
- Codecov (rapport couverture)

## Workflow Recommandé

1. Dev complete -> Tests unitaires (CI automatique)
2. PR ouverte -> Code review + tests intégration (CI)
3. Merge main -> Tests E2E staging (CI nightly)
4. Pre-release -> Tests performance k6
5. UAT (sprint J-7) -> 1 semaine usage réel, feedback
6. UAT Review -> Analyse feedback, corrections bugs
7. Go/No-Go -> PM + QA décision basée sur rapport
8. Déploiement phasé -> Monitoring logs, support users
9. Post-déploiement -> Regression suite + métriques tracking
10. Rapport amélioration -> Agent autonome analyse, suggestions prochain sprint
