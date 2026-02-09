# Stories - Epics & User Stories

## Description
Décomposition de projets en Epics et User Stories agiles. Adapté pour cycles courts Entreprise avec validation continue.

## Quand utiliser
- Après Architecture validée
- Sprint planning
- Backlog refinement
- Priorisation features
- Estimation efforts

## Hiérarchie

```
Initiative (6-12 mois)
    ↓
Epic (2-4 sprints)
    ↓
User Story (1-5 jours)
    ↓
Task (2-8 heures)
```

## Format User Story

### Template Complet
```markdown
## US-[ID]: [Titre Court]

**En tant que** [persona]
**Je veux** [action/fonctionnalité]
**Afin de** [bénéfice métier]

**Priorité:** Must/Should/Could/Won't (MoSCoW)
**Effort:** [Story Points: 1,2,3,5,8,13]
**Sprint:** [Numéro ou "Backlog"]

### Acceptance Criteria (AC)
- [ ] AC1: [Critère vérifiable]
- [ ] AC2: [Critère vérifiable]
- [ ] AC3: [Critère vérifiable]

### Definition of Done (Chef de projet)
- [ ] Code écrit & testé
- [ ] Documentation mise à jour
- [ ] Review par Adminstrateur IT/Resp. Métier
- [ ] Déployé en staging
- [ ] User Acceptance Test (UAT) passé

### Technical Notes
- **Dependencies:** [Autres stories/systèmes]
- **Risks:** [Technique, délai, etc.]
- **Architecture Ref:** [ADR ou diagramme]

### Tasks
- [ ] TASK-001: [Description] (2h)
- [ ] TASK-002: [Description] (4h)
- [ ] TASK-003: [Description] (3h)

**Total Estimated:** [Somme heures]
```

## Exemples Entreprise

### Epic Example
```markdown
# EPIC-001: M-Files Mobile Deployment

**Goal:** Déployer accès mobile M-Files pour N utilisateurs terrain

**Timeline:** 2 sprints (4 semaines)

**Stories:**
- US-001: Configuration gRPC serveur (5 pts)
- US-002: Traefik proxy setup WAN (3 pts)
- US-003: Azure 2FA integration (8 pts)
- US-004: Documentation utilisateur mobile (2 pts)
- US-005: Pilote 5 users + feedback (5 pts)
- US-006: Rollout N users phased (3 pts)

**Success Metrics:**
- 80% adoption mobile dans 3 mois
- Latence <5sec WAN
- Zero security incidents

**Risks:**
- Latence réseau → Mitigation: Pilote avant rollout
- Adoption faible → Mitigation: Training sessions
```

### User Story Example
```markdown
## US-003: Intégration Azure 2FA M-Files Mobile

**En tant que** administrateur IT
**Je veux** forcer 2FA Azure pour accès mobile M-Files
**Afin de** sécuriser accès WAN externe

**Priorité:** Must Have
**Effort:** 8 Story Points
**Sprint:** Sprint 2

### Acceptance Criteria
- [ ] AC1: Login mobile requiert 2FA Azure obligatoire
- [ ] AC2: Timeout session après 15min inactivité
- [ ] AC3: Logs d'authentification dans M-Files Event Log
- [ ] AC4: Fallback graceful si Azure down (mode offline only)

### Definition of Done
- [ ] Config Traefik avec Azure AD auth
- [ ] Tests avec 5 users pilotes
- [ ] Documentation admin + troubleshooting guide
- [ ] Review sécurité par Adminstrateur IT
- [ ] UAT avec 2 users terrain

### Technical Notes
- **Dependencies:** 
  - US-002 (Traefik proxy must be deployed first)
  - Azure AD tenant Entreprise
- **Risks:** 
  - Azure outage → Mitigation: offline mode + monitoring
- **Architecture Ref:** ADR-003 (Azure 2FA mandatory)

### Tasks
- [ ] TASK-001: Config Azure App Registration (2h)
- [ ] TASK-002: Traefik middleware OAuth2 (4h)
- [ ] TASK-003: M-Files server redirect config (3h)
- [ ] TASK-004: Test auth flow (2h)
- [ ] TASK-005: Documentation (2h)

**Total Estimated:** 13h
```

## Story Points (Fibonacci)

| Points | Effort | Exemple Entreprise |
|--------|--------|--------------|
| 1 | Trivial | Update doc, config tweak |
| 2 | Simple | PowerShell script simple |
| 3 | Moderate | M-Files workflow state ajout |
| 5 | Medium | SharePoint column JSON formatting |
| 8 | Complex | Azure integration, API |
| 13 | Very Complex | Migration complète, multi-system |
| 21+ | Epic | À décomposer |

**Règle:** Story >13 points = décomposer en plusieurs stories

## MoSCoW Prioritization

- **Must Have:** Bloquant, sans ça le projet échoue
- **Should Have:** Important, mais workaround possible
- **Could Have:** Nice-to-have si temps/budget
- **Won't Have:** Hors scope actuel (future roadmap)

## Sprint Planning Entreprise

**Sprint Duration:** 2 semaines (recommandé)

**Capacité Chef de projet:**
- ~50-60% sur dev/config (interruptions, tickets)
- ~40-50% disponible pour stories planifiées
- Velocity moyenne: 15-20 story points/sprint

**Rituels:**
- **Sprint Planning** (Lundi matin): Select stories backlog
- **Daily Standup** (informel): Slack update Resp. Application Métier/Adminstrateur IT
- **Sprint Review** (Vendredi J-1): Demo à stakeholders
- **Retrospective** (Vendredi après-midi): Lessons learned

## Template Epic

```markdown
# EPIC-[ID]: [Titre]

**Owner:** Chef de projet | **PM:** Resp. Application Métier | **Sprint Target:** [Dates]

## Goal & Vision
[1-2 paragraphes: Pourquoi cet epic, bénéfice métier]

## Success Metrics
- [ ] Metric 1: [Mesurable]
- [ ] Metric 2: [Mesurable]
- [ ] Timeline: [Date cible]

## User Stories (Ordered by Priority)
1. ⬜ US-001: [Titre] (Must Have, 5 pts)
2. ⬜ US-002: [Titre] (Must Have, 3 pts)
3. ⬜ US-003: [Titre] (Should Have, 8 pts)
4. ⬜ US-004: [Titre] (Could Have, 2 pts)

**Total Effort:** 18 Story Points (~1.5 sprints)

## Dependencies
- External: [Prestataire A, Prestataire B, etc.]
- Internal: [Autre epic/projet]
- Technical: [Infrastructure, licenses]

## Risks & Mitigation
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Action] |

## Architecture Reference
- PRD: [Lien]
- Architecture: [ADR refs]
- Related Epics: [Liens]
```

## Backlog Management

### Backlog Refinement (Bi-weekly)
1. Review nouvelles demandes
2. Estimer story points
3. Clarifier ACs si flous
4. Prioriser via MoSCoW
5. Décomposer stories >13pts

### Backlog Structure
```
/backlog/
├── epics/
│   ├── EPIC-001-m-files-mobile.md
│   └── EPIC-002-sharepoint-gantt.md
├── stories/
│   ├── sprint-current/
│   │   ├── US-001.md
│   │   └── US-002.md
│   ├── sprint-next/
│   └── backlog/
└── done/
    └── archive-2024-Q4/
```

## Checklist Story Quality
- [ ] Titre clair & concis
- [ ] Format "En tant que... Je veux... Afin de..."
- [ ] 3-5 Acceptance Criteria vérifiables
- [ ] Story points estimés (consensus équipe)
- [ ] Priorité MoSCoW assignée
- [ ] Dependencies identifiées
- [ ] Chef de projet défini
- [ ] Fit dans 1 sprint (max 13 pts)

## Bonnes Pratiques Entreprise
1. **INVEST Principle:**
   - **I**ndependent: Story autonome
   - **N**egotiable: AC ajustables
   - **V**aluable: Valeur métier claire
   - **E**stimable: Effort quantifiable
   - **S**mall: Fit 1 sprint
   - **T**estable: AC vérifiables

2. **3 Amigos:** Chef de projet + Resp. Application Métier + Adminstrateur IT review stories

3. **Spike Stories:** Si incertitude technique élevée
   ```
   US-SPIKE-01: Research M-Files API OAuth2 support
   Timebox: 4h max
   Output: Decision document (go/no-go)
   ```

4. **Technical Debt Stories:** Track explicitement
   ```
   US-DEBT-01: Refactor PowerShell scripts logging
   Priorité: Should Have (pas urgent)
   ```

## Anti-Patterns
- ❌ Stories sans AC (impossible à valider)
- ❌ Stories >13 pts (trop gros, décomposer)
- ❌ AC vagues ("should work well")
- ❌ Pas de Chef de projet (confusion "done" vs "done done")
- ❌ Stories techniques sans valeur métier visible
- ❌ Over-planning (details tasks trop tôt)

## Outils
- **Tracking:** M-Files (metadata workflow), SharePoint List
- **Estimation:** Planning Poker (async via Slack)
- **Docs:** Markdown in Git ou M-Files documents

## Workflow Recommandé
1. **Epic Creation** (1h): Post architecture review
2. **Story Decomposition** (2-3h): Brainstorm + write stories
3. **Estimation Session** (1h): Planning poker avec équipe
4. **Prioritization** (30min): MoSCoW avec Resp. Application Métier
5. **Sprint Planning** (1h): Select stories pour sprint
6. **Daily Execution** → Track dans M-Files/SharePoint
7. **Sprint Review** → Demo + retrospective

## Métriques
- **Velocity:** Story points complétés / sprint
- **Cycle Time:** Jours entre start → done
- **Burndown:** Tracking sprint progress
- **Scope Creep:** Stories ajoutées mid-sprint (à minimiser)
