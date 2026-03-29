# BMAD Skills pour Claude Code

Bibliothèque de skills professionnels pour Claude Code implémentant la méthodologie **BMAD (Breakthrough Method for Agile AI-Driven Development)**.

Cette version se concentre sur des **technologies open-source, auto-hébergées, sans dépendance à des logiciels propriétaires**.

## Skills Disponibles

| Skill | Commande | Description |
|-------|----------|-------------|
| Business Analysis | `/ba` | Discovery, brainstorming, business case, feasibility |
| Product Requirements | `/prd` | PRD, user stories, personas, success metrics |
| Architecture | `/architecture` | Conception technique, stack open-source, ADRs, sécurité |
| Database Admin | `/dba` | Meilleures pratiques PostgreSQL, schéma, migrations, backup |
| UI/UX Design | `/uiux` | Design system, accessibilité (WCAG 2.1), composants, doc user |
| Epics & Stories | `/stories` | Décomposition stories, sprint planning, alignement documentation |
| Quality Assurance | `/qa` | Stratégie tests, agents autonomes QA, CI/CD, rapports |

## Stack Technologique

Tous les skills sont conçus autour d'un **stack moderne, open-source et auto-hébergé** :

**Frontend :** React 18 + TypeScript + Tailwind CSS + shadcn/ui + Vite + Storybook

**Backend :** FastAPI (Python 3.11+) + PostgreSQL 16 + Redis + Celery

**Auth :** Authentik (SSO/OIDC/2FA auto-hébergé)

**Infrastructure :** Docker + Docker Compose + Traefik v3 (SSL auto Let's Encrypt)

**Tests :** Pytest + Testcontainers + Playwright + k6

**Monitoring :** Prometheus + Grafana + Loki + Uptime Kuma

**Documentation :** MkDocs Material (IT) + Storybook (composants) + OpenAPI (API auto-générée)

## Workflow BMAD

```
1. /ba          → Discovery, business case, feasibility
        ↓
2. /prd         → Exigences, user stories, personas
   ↓       ↓
  /dba    /uiux  ← Consulter tôt (schéma DB, design system)
        ↓
3. /architecture → ADRs, conception système, sécurité
        ↓
4. /stories      → Epics, sprint planning, alignement doc
        ↓
5. /qa           → Stratégie tests, CI/CD, UAT, rapports
```

## Niveaux de Complexité

- **Quick Flow** (<5 min) : Bug fix, scope clair, petite feature
- **BMad Method** (<15 min) : Nouveau produit, scope modéré
- **Enterprise** (<30 min) : Multi-stakeholders, conformité, haute criticité

## Installation

### Option 1 : Script automatique

**Linux/macOS :**
```bash
chmod +x install-bmad-skills.sh
./install-bmad-skills.sh
```

**Windows :**
```powershell
.\Install-BMADSkills.ps1
```

### Option 2 : Git Submodule (par projet)
```bash
git submodule add https://github.com/YOUR_ORG/bmad-skills.git .claude/skills
```

### Option 3 : Copie manuelle
```bash
cp -r skills/* ~/.claude/skills/
```

## Collaboration entre Agents

Les agents peuvent s'interroger mutuellement :

```
/architecture → "Consulter /dba pour conventions schéma"
/prd          → "Consulter /uiux pour exigences interface"
/stories      → "Consulter /dba si schéma DB modifié"
/qa           → "Consulter /dba pour optimisation requêtes lentes"
```

### Exemple de flux d'interrogation

```
PRD demande au DBA :
"Cette fonctionnalité génère des notifications. Quelle table recommandes-tu ?"

DBA répond :
"Utiliser une table 'notifications' avec UUID, user_id FK, type TEXT, read_at TIMESTAMPTZ.
Index sur (user_id, created_at DESC) WHERE read_at IS NULL."

Architecture utilise la réponse DBA pour ADR-005.
```

## Philosophie Documentation

Chaque user story livrée doit inclure :
- **Documentation technique IT** : Docs API (Swagger auto), ADRs, runbooks (MkDocs Material)
- **Documentation utilisateur** : Guides avec captures annotées, cas d'utilisation, FAQ

## Agent QA Autonome

Le skill QA intègre un agent autonome capable de :
1. Exécuter les suites de tests (CI/CD automatisé)
2. Générer un rapport structuré (résultats, couverture, performance)
3. Identifier les axes d'amélioration (tests manquants, régressions perf)
4. Proposer des actions prioritaires pour le prochain sprint
5. Bloquer le déploiement si critères non atteints

**Objectif : couverture fonctionnelle ≥90%**

## Principes Fondamentaux

1. **Open-Source First :** Aucune dépendance à des logiciels propriétaires
2. **Auto-hébergé :** Contrôle total, pas de vendor lock-in, GDPR-friendly
3. **Docker First :** Tout service = container, déploiement reproductible
4. **Documentation synchronisée :** Doc livrée avec le code, jamais après
5. **Tests automatisés :** Pipeline CI/CD bloquant, pas optionnel
6. **Security by Design :** OWASP Top 10, 2FA, secrets management dès le départ

## Licence

MIT License — Voir fichier LICENSE.
