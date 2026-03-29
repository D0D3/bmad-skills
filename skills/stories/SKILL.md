# Stories - Epics & User Stories

## Description
Décomposition de projets en Epics et User Stories agiles. Inclut les exigences de documentation technique (IT) et utilisateur (end-user). Garantit l'alignement parfait entre les stories livrées et leur documentation associée.

## Quand utiliser
- Après Architecture validée
- Sprint planning
- Backlog refinement
- Priorisation features
- Estimation efforts

## Hiérarchie

```
Initiative (6-12 mois)
    |
Epic (2-4 sprints)
    |
User Story (1-5 jours) -> inclut exigences documentation
    |
Task (2-8 heures) -> dont tasks de documentation
```

---

## Format User Story

### Template Complet

```markdown
## US-[ID]: [Titre Court]

**En tant que** [persona]
**Je veux** [action/fonctionnalité]
**Afin de** [bénéfice métier]

**Priorité:** Must / Should / Could / Won't (MoSCoW)
**Effort:** [Story Points: 1,2,3,5,8,13]
**Sprint:** [Numéro ou "Backlog"]

---

### Acceptance Criteria (AC)
- [ ] AC1: [Critère vérifiable - comportement observable]
- [ ] AC2: [Critère vérifiable]
- [ ] AC3: [Critère vérifiable]

### Definition of Done (DoD)
- [ ] Code écrit, testé (unit + intégration)
- [ ] Tests E2E pour ce parcours (si UI)
- [ ] Review de code effectuée
- [ ] Déployé en staging et validé
- [ ] UAT passé (si applicable)
- [ ] **Documentation technique IT mise à jour**
- [ ] **Documentation utilisateur mise à jour (si impact UI)**

### Documentation Requise

#### Documentation Technique IT
- [ ] `docs/api/` : Endpoint(s) documenté(s) (Swagger auto-généré)
- [ ] `docs/architecture/` : ADR créé/mis à jour si décision technique
- [ ] `docs/operations/runbooks/` : Runbook si impact opérationnel
- [ ] Migration DB documentée si schéma modifié (consulter /dba)

#### Documentation Utilisateur
- [ ] `docs-utilisateur/` : Guide ou section mis à jour
- [ ] Captures d'écran ajoutées/mises à jour (si écran modifié)
- [ ] Cas d'utilisation documenté (si nouveau flow)
- [ ] FAQ mise à jour (si nouvelle question anticipée)

### Technical Notes
- **Dependencies:** [Autres stories/services requis]
- **Risks:** [Technique, délai, impact]
- **Architecture Ref:** [ADR concerné, ou /architecture]
- **DBA Ref:** [Si schéma DB modifié, consulter /dba]
- **UI/UX Ref:** [Composant Storybook concerné, ou /uiux]

### Tasks
- [ ] TASK-001: [Backend] [Description] (Xh)
- [ ] TASK-002: [Frontend] [Description] (Xh)
- [ ] TASK-003: [Tests] Écrire tests unitaires + intégration (Xh)
- [ ] TASK-004: [Tests] Tests E2E Playwright (Xh)
- [ ] TASK-005: [Doc IT] Mettre à jour docs/... (1h)
- [ ] TASK-006: [Doc User] Captures + guide utilisateur (1h)

**Total Estimé:** [Somme heures]
```

---

## Exemples

### Epic Example

```markdown
# EPIC-001: Gestion de Documents

**Goal:** Permettre aux utilisateurs de créer, organiser, approuver et archiver des documents dans l'application

**Timeline:** 2 sprints (4 semaines)
**Owner:** [PM]

### User Stories
- US-001: Upload document (5 pts) [Must]
- US-002: Workflow approbation (8 pts) [Must]
- US-003: Recherche full-text (5 pts) [Should]
- US-004: Export PDF (3 pts) [Could]
- US-005: Documentation et formation (2 pts) [Must]

**Total:** 23 Story Points (~2 sprints)

### Success Metrics
- 100% des documents upload en <10sec (50MB)
- Workflow approbation : délai moyen <24h
- Satisfaction users : >4/5 post-UAT

### Risks
| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| Performance upload | Medium | High | Tests perf dès sprint 1 |
| Adoption faible | Low | Medium | Formation + champions |
```

### User Story Example

```markdown
## US-002: Workflow Approbation Document

**En tant que** manager
**Je veux** approuver ou rejeter les documents soumis depuis l'interface
**Afin de** valider le contenu avant diffusion sans processus email manuel

**Priorité:** Must Have
**Effort:** 8 Story Points
**Sprint:** Sprint 2

---

### Acceptance Criteria
- [ ] AC1: Manager voit la liste des documents en attente d'approbation
- [ ] AC2: Manager peut approuver avec commentaire obligatoire
- [ ] AC3: Manager peut rejeter avec raison obligatoire
- [ ] AC4: L'auteur reçoit une notification (email + in-app) dans <5min
- [ ] AC5: L'historique des décisions est conservé (audit trail)
- [ ] AC6: Un utilisateur sans rôle manager ne voit pas les boutons d'action

### Definition of Done
- [ ] API endpoints /approve et /reject créés et testés
- [ ] Interface manager implémentée (composant ApprovalPanel)
- [ ] Notifications email + in-app fonctionnelles
- [ ] Tests unitaires service (approve/reject avec cas limites)
- [ ] Tests intégration DB (statut mis à jour, audit trail)
- [ ] Tests E2E Playwright (parcours manager complet + test RBAC)
- [ ] Storybook story ApprovalPanel (états: pending, approved, rejected)
- [ ] **Documentation technique IT mise à jour**
- [ ] **Guide utilisateur manager créé**

### Documentation Requise

#### Documentation Technique IT
- [ ] `docs/api/documents.md` : Documenter endpoints PATCH /documents/{id}/approve et /reject
- [ ] `docs/architecture/decisions/ADR-004-notification-system.md` : Décision système notifications
- [ ] Schéma DB : Table audit_log utilisation documentée (voir /dba)

#### Documentation Utilisateur
- [ ] `docs-utilisateur/guides/approbation-documents.md` : Guide complet manager
  - Captures d'écran : liste documents en attente, formulaire approbation, notification
  - Cas d'utilisation : approbation simple, rejet avec commentaire
  - FAQ : "Je ne vois pas les boutons d'action" → vérifier rôle manager
- [ ] `docs-utilisateur/demarrage-rapide/` : Mention du workflow d'approbation

### Technical Notes
- **Dependencies:** US-001 (upload doit être fait en premier)
- **Risks:** Notifications email peuvent échouer (SMTP) → Fallback in-app obligatoire
- **Architecture Ref:** ADR-003 (auth RBAC), ADR-004 (notifications)
- **DBA Ref:** Utiliser table audit_log existante, index sur document_id + action
- **UI/UX Ref:** Composant Badge statut + AlertDialog confirmation (shadcn/ui)

### Tasks
- [ ] TASK-001: [Backend] Endpoint PATCH /documents/{id}/approve (3h)
- [ ] TASK-002: [Backend] Endpoint PATCH /documents/{id}/reject (2h)
- [ ] TASK-003: [Backend] Service notifications email + in-app (3h)
- [ ] TASK-004: [Frontend] Composant ApprovalPanel (3h)
- [ ] TASK-005: [Frontend] Badge statut document (1h)
- [ ] TASK-006: [Tests] Unit tests service approbation (2h)
- [ ] TASK-007: [Tests] Tests intégration DB (1h)
- [ ] TASK-008: [Tests] Tests E2E Playwright (2h)
- [ ] TASK-009: [Storybook] Story ApprovalPanel (1h)
- [ ] TASK-010: [Doc IT] ADR-004 + docs API (1h)
- [ ] TASK-011: [Doc User] Guide + captures écran (1.5h)

**Total Estimé:** 20.5h
```

---

## Documentation Alignment Framework

> Règle fondamentale : **Chaque US touchant l'UI ou une API doit inclure des tasks de documentation.**

### Matrice Documentation par Type de Changement

| Type de changement | Doc IT requise | Doc User requise |
|-------------------|----------------|-----------------|
| Nouvelle API endpoint | Swagger (auto) + exemples | Non (sauf si UI liée) |
| Nouveau composant UI | Storybook story | Guide utilisateur + captures |
| Nouveau workflow métier | ADR (si décision archi) | Guide complet + cas d'utilisation |
| Migration DB | Runbook backup/restore | Non |
| Changement de comportement | Changelog technique | Mise à jour guide existant |
| Nouvelle intégration | Docs intégration | Non (sauf si impact user) |
| Fix de bug | Aucune (sauf si comportement change) | FAQ si question fréquente |

### Template Documentation Technique IT

```markdown
# [Fonctionnalité] - Documentation Technique

**Version:** [Liée à la release]
**Modifié:** YYYY-MM-DD
**US Ref:** US-[ID]

## Vue d'Ensemble
[1-2 paragraphes : ce que fait la fonctionnalité techniquement]

## API

### POST /api/documents/{id}/approve
**Authentification :** Bearer JWT requis
**Rôle requis :** manager, admin

**Request Body :**
```json
{
  "comment": "Approuvé après vérification juridique"
}
```

**Response 200 :**
```json
{
  "id": "uuid",
  "status": "approved",
  "approved_by": "user-uuid",
  "approved_at": "2024-01-15T10:30:00Z",
  "comment": "Approuvé après vérification juridique"
}
```

**Erreurs possibles :**
| Code | Cas |
|------|-----|
| 401 | Token manquant ou expiré |
| 403 | Rôle insuffisant |
| 404 | Document non trouvé |
| 409 | Document déjà approuvé |

## Base de Données
**Tables modifiées :** documents (status, approved_by, approved_at), audit_log
**Index utilisés :** idx_documents_status, idx_audit_log_document_id

## Configuration
**Variables d'environnement :**
```
SMTP_HOST=...
SMTP_PORT=587
NOTIFICATION_FROM=noreply@app.com
```

## Tests
**Couverture :** tests/unit/test_approval_service.py, tests/e2e/approval.spec.ts
**Cas limites testés :** Double approbation, rôle insuffisant, document inexistant
```

### Template Documentation Utilisateur

```markdown
# Approuver ou Rejeter un Document

**Rôle requis :** Manager ou Administrateur
**Temps estimé :** 2-3 minutes par document

## Résumé
Cette fonctionnalité vous permet de valider ou refuser les documents soumis par votre équipe directement depuis l'application.

## Accéder aux Documents en Attente

1. Dans le menu principal, cliquez sur **"Documents"**
2. Sélectionnez le filtre **"En attente d'approbation"**

[CAPTURE : docs-utilisateur/assets/01-liste-documents-attente.png]
> Les documents en attente apparaissent avec le badge orange "En attente"

## Approuver un Document

1. Cliquez sur le titre du document pour l'ouvrir
2. Lisez le document attentivement
3. Cliquez sur le bouton **"Approuver"** en haut à droite

[CAPTURE : docs-utilisateur/assets/02-bouton-approuver.png]

4. Dans la fenêtre de confirmation, saisissez un commentaire (obligatoire)
5. Cliquez sur **"Confirmer l'approbation"**

[CAPTURE : docs-utilisateur/assets/03-confirmation-approbation.png]

**Résultat :** L'auteur reçoit une notification. Le document passe au statut "Approuvé".

## Rejeter un Document

1. Ouvrez le document
2. Cliquez sur **"Rejeter"**
3. Saisissez la raison du rejet (obligatoire — l'auteur la recevra)
4. Cliquez sur **"Confirmer le rejet"**

**Résultat :** L'auteur reçoit une notification avec votre commentaire. Il peut corriger et re-soumettre.

## Cas d'Utilisation

### Cas 1 : Approbation rapide en fin de journée
> Marie, manager RH, vérifie les documents en attente chaque vendredi à 16h.
> Elle ouvre la liste filtrée, passe en revue 3 documents, approuve les 2 conformes
> et rejette le 3e avec commentaire "Mettre à jour la section 4 — données obsolètes".

### Cas 2 : Délégation temporaire
> Jean part en congé. L'administrateur IT assigne temporairement le rôle manager
> à sa collègue Sophie pour la semaine. Sophie voit alors les documents en attente.

## Problèmes Courants

### "Je ne vois pas les boutons Approuver / Rejeter"
**Cause :** Votre compte n'a pas le rôle Manager
**Solution :** Contactez votre administrateur IT pour demander le rôle approprié

### "J'ai approuvé par erreur"
**Cause :** L'approbation est immédiate et déclenche une notification
**Solution :** Contactez l'administrateur IT — il peut manuellement revenir à l'état "En révision"
**Note :** Une fonctionnalité "Annuler approbation" est prévue en v1.2

### "L'auteur dit ne pas avoir reçu la notification"
**Solution :** Vérifiez les spams. Si toujours absent, l'admin IT peut vérifier les logs.
```

---

## Story Points (Fibonacci)

| Points | Effort | Exemples |
|--------|--------|---------|
| 1 | Trivial | Correction typo, ajustement config |
| 2 | Simple | Endpoint CRUD simple, composant bouton |
| 3 | Modéré | Endpoint avec logique métier, composant form |
| 5 | Moyen | Feature complète avec UI + API + tests |
| 8 | Complexe | Feature multi-systèmes, workflow, performance |
| 13 | Très complexe | Migration, intégration externe, refactoring majeur |
| 21+ | Epic | À décomposer obligatoirement |

**Règle :** Story >13 points = décomposer en plusieurs stories

---

## MoSCoW Prioritization

- **Must Have :** Bloquant, sans ça le projet échoue
- **Should Have :** Important, mais workaround possible temporairement
- **Could Have :** Nice-to-have si temps/budget le permettent
- **Won't Have :** Hors scope actuel (documenter pour roadmap future)

---

## Sprint Planning

**Durée sprint :** 2 semaines (recommandé)

**Capacité équipe :**
- 50-60% sur stories planifiées
- 40-50% : interruptions, bugs prod, reviews
- Velocity cible : 15-20 story points/sprint

**Rituels :**
- **Sprint Planning** (lundi matin) : Sélection stories backlog
- **Daily Standup** (async ou 15min) : Blocages, avancement
- **Sprint Review** (vendredi J-1) : Demo stakeholders
- **Retrospective** (vendredi) : Lessons learned

---

## Backlog Management

### Refinement bi-hebdomadaire
1. Review nouvelles demandes
2. Estimer story points (Planning Poker)
3. Clarifier ACs si flous
4. Prioriser via MoSCoW
5. Décomposer stories >13pts
6. Vérifier exigences documentation incluses

### Structure Backlog
```
/backlog/
├── epics/
│   ├── EPIC-001-gestion-documents.md
│   └── EPIC-002-reporting.md
├── stories/
│   ├── sprint-current/
│   │   ├── US-001.md
│   │   └── US-002.md
│   ├── sprint-next/
│   └── backlog/
└── done/
    └── archive-2024-Q4/
```

---

## Checklist Qualité Story

- [ ] Titre clair et concis
- [ ] Format "En tant que... Je veux... Afin de..."
- [ ] 3-5 Acceptance Criteria vérifiables
- [ ] Story points estimés
- [ ] Priorité MoSCoW assignée
- [ ] Dependencies identifiées
- [ ] Owner défini
- [ ] Fit dans 1 sprint (≤13pts)
- [ ] **Tasks documentation incluses** (doc IT + doc user si applicable)
- [ ] **DBA consulté** si schéma DB modifié
- [ ] **UI/UX consulté** si nouveau composant ou écran

---

## Bonnes Pratiques

1. **INVEST Principle :**
   - **I**ndependent : Story autonome si possible
   - **N**egotiable : ACs ajustables selon découverte
   - **V**aluable : Valeur métier claire et directe
   - **E**stimable : Effort quantifiable par l'équipe
   - **S**mall : Fit dans 1 sprint (≤13pts)
   - **T**estable : ACs vérifiables automatiquement ou manuellement

2. **3 Amigos :** Dev + Métier + QA review stories avant sprint

3. **Spike Stories :** Si incertitude technique élevée
   ```
   US-SPIKE-01: Évaluer intégration API externe [X]
   Timebox: 4h max
   Output: Go/No-Go + effort estimé
   ```

4. **Tech Debt Stories :** Tracker explicitement
   ```
   US-DEBT-01: Refactorer service documents (couplage fort)
   Priorité: Should Have
   Impact si non fait: Maintenance difficile sprint 5+
   ```

5. **Documentation as a Story :** Si documentation majeure nécessaire
   ```
   US-DOC-01: Documentation complète feature gestion documents
   Livrable: Guide IT + Guide Utilisateur + Storybook
   Effort: 3 pts
   ```

## Anti-Patterns

- Stories sans Acceptance Criteria (impossible à valider)
- Stories >13pts non décomposées
- ACs vagues ("should work well", "doit être rapide")
- Pas de Owner (confusion sur "done done")
- Tasks de documentation absentes (dette documentaire)
- Stories techniques sans valeur métier visible
- Over-planning des tasks trop en avance (les détails changent)

## Outils

- **Tracking :** Linear, Jira, GitHub Issues, GitLab Issues
- **Estimation :** Planning Poker (PlanningPoker.live ou Slack bot)
- **Docs :** Markdown in Git (versionné, diff possible)
- **Wireframes :** Excalidraw (rapide) ou Figma (précis)

## Workflow Recommandé

1. Epic Creation (1h) → Post architecture review
2. Story Decomposition (2-3h) → Brainstorm + rédiger stories
3. 3 Amigos Review (1h) → Dev + Métier + QA valident ACs
4. Estimation Session (1h) → Planning Poker équipe
5. Prioritization (30min) → MoSCoW avec stakeholders
6. Documentation Check (15min) → Tasks doc incluses dans chaque story ?
7. Sprint Planning (1h) → Sélection stories pour sprint
8. Daily Execution → Track, blocker removal
9. Sprint Review → Demo + retro
10. Post-sprint → Vérifier docs livrées avec le code

## Métriques

- **Velocity :** Story points complétés / sprint (baseline à mesurer)
- **Cycle Time :** Jours entre start et done
- **Burndown :** Tracking progression sprint
- **Documentation Coverage :** % stories avec doc livrée = 100% (cible)
- **Scope Creep :** Stories ajoutées mid-sprint (à minimiser, ≤10%)
