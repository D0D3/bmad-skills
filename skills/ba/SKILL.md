# BA - Business Analysis Multi-Casquette

## Description
Business Analysis complète upstream du PRD. Couvre brainstorming, analyse métier, process mapping, feasibility, stakeholder management. Multi-casquette pour s'adapter au contexte projet (Quick Flow → Enterprise).

## Quand utiliser
- **Avant PRD** - Phase discovery
- Nouvelle opportunité métier floue
- Stakeholders multiples à aligner
- Processus métier complexe à analyser
- Feasibility study nécessaire
- Gap analysis AS-IS → TO-BE

## Workflows BA selon Complexité

### Quick Flow (< 5 min)
**Pour:** Bug fix, petite feature, scope clair

**Livrables:**
- ⚡ Problem Statement (1 paragraphe)
- ⚡ Impact rapide (qui/quoi/combien)
- ⚡ Go/No-Go decision

**Template:**
```markdown
# Quick Analysis: [Titre]

**Problem:** [1-2 phrases du problème]
**Impact:** [X users, Y€ économie, Z% gain]
**Effort:** Low/Med/High
**Decision:** ✅ Go / ❌ No-Go / ⏸️ Needs more analysis

**Next Step:** → Directement à dev OU → BA complet si complexe
```

### BMad Method (< 15 min)
**Pour:** Nouveau produit, plateforme, scope modéré

**Livrables:**
1. **Brainstorming Session Results** (techniques élicitation)
2. **Business Case** (ROI, stakeholders)
3. **Process Mapping** (AS-IS/TO-BE si applicable)
4. **Requirements Document** (high-level, avant PRD détaillé)

### Enterprise (< 30 min)
**Pour:** Conformité, scalabilité, multi-stakeholders, haute criticité

**Livrables:**
1. Tout BMad Method +
2. **Feasibility Study** (technique, financier, opérationnel)
3. **Risk Assessment** (matrice complète)
4. **Compliance Analysis** (réglementaire, sécurité)
5. **Change Management Plan** (adoption, formation)

## 1. Brainstorming Session Results

### Techniques d'Élicitation

#### A. Role Playing (3 Personas)
**Objectif:** Explorer besoins sous 3 angles différents

**Template:**
```markdown
## Brainstorming Session: [Projet]

**Date:** YYYY-MM-DD | **Facilitateur:** [BA Name] | **Durée:** 60min

### Persona 1: L'Expert Métier
**Profil:** [Description]
**Besoins exprimés:**
- Besoin 1: [Citation]
- Besoin 2: [Citation]
**Insights:** [Ce qu'on apprend]

### Persona 2: L'Utilisateur Final
**Profil:** [Description]
**Besoins exprimés:**
- Besoin 1: [Citation]
- Besoin 2: [Citation]
**Insights:** [Ce qu'on apprend]

### Persona 3: Le Décideur/Sponsor
**Profil:** [Description]
**Besoins exprimés:**
- Besoin 1: [Citation]
- Besoin 2: [Citation]
**Insights:** [Ce qu'on apprend]
```

**Exemple :**
```markdown
### Persona 1: Gestionnaire Apps Métier
**Profil:** Touche-à-tout, manque de temps, besoin efficacité
**Besoins:**
- "Je veux automatiser les tâches répétitives pour me concentrer sur l'amélioration"
- "J'ai besoin de solutions qui marchent du premier coup, pas de temps pour debugger"
**Insights:** Prioriser automation + robustesse sur features complexes

### Persona 2: Utilisateur Final
**Profil:** Pas tech-savvy, résistant au changement
**Besoins:**
- "Je veux que ça marche comme avant, mais en mieux"
- "Pas de formation de 2h, je veux comprendre en 5min"
**Insights:** UX intuitive critique, formation minimale, adoption progressive

### Persona 3: Chef de Projet
**Profil:** Accountability résultats, timeline serrées
**Besoins:**
- "Je veux des livrables prévisibles, pas de surprises"
- "ROI mesurable en 6 mois max"
**Insights:** Phased rollout, métriques claires, communication proactive
```

#### B. Five Whys (Root Cause Analysis)
**Objectif:** Creuser pour trouver le vrai problème

**Template:**
```markdown
### Five Whys Analysis

**Problem Statement:** [Problème initial]

1. **Why?** [Réponse 1]
2. **Why?** [Réponse 2]
3. **Why?** [Réponse 3]
4. **Why?** [Réponse 4]
5. **Why?** [Root Cause identifié]

**Root Cause:** [Le vrai problème à résoudre]
**Implication:** [Ce que ça change pour la solution]
```

**Exemple:**
```markdown
**Problem:** "Les utilisateurs ne trouvent pas leurs documents M-Files"

1. Why? → Parce que la recherche retourne trop de résultats
2. Why? → Parce que les métadonnées ne sont pas remplies correctement
3. Why? → Parce que les users ne comprennent pas quels champs sont importants
4. Why? → Parce qu'il n'y a pas de formation ni de guidance dans l'UI
5. Why? → Parce qu'on a priorisé le déploiement rapide sur l'adoption

**Root Cause:** Manque de change management et UX guidance
**Implication:** Solution = Training + UI improvements, pas juste meilleur algo de recherche
```

#### C. Analogical Thinking
**Objectif:** Clarifier concept via analogies

**Template:**
```markdown
### Analogies pour [Concept]

**Analogie 1:** [Concept] est comme [Analogie connue]
- **Similitudes:** [Points communs]
- **Différences:** [Nuances importantes]
- **Insights:** [Ce que l'analogie révèle]

**Analogie 2:** [Autre analogie]
...
```

**Exemple:**
```markdown
**Concept:** M-Files workflow automation

**Analogie 1:** C'est comme une chaîne de montage automobile
- **Similitudes:** Document passe par stations (états), chaque station fait action spécifique
- **Différences:** Workflow peut avoir branches conditionnelles, chaîne est linéaire
- **Insights:** Besoin de visualiser le flow complet, identifier bottlenecks

**Analogie 2:** C'est comme Gmail filters + labels automatiques
- **Similitudes:** Rules-based, automatic categorization, routing
- **Différences:** M-Files = business process, Gmail = personal organization
- **Insights:** Users comprennent déjà ce pattern, UX familière aide adoption
```

### Output Brainstorming Session
```markdown
## Synthèse Brainstorming

**Top Insights:**
1. [Insight majeur 1]
2. [Insight majeur 2]
3. [Insight majeur 3]

**Besoins Prioritaires (consensus 3 personas):**
- Must Have: [Liste]
- Should Have: [Liste]
- Nice to Have: [Liste]

**Risques Identifiés:**
- [Risque 1 détecté durant brainstorming]
- [Risque 2]

**Recommandations pour PRD:**
- [Recommandation 1]
- [Recommandation 2]

**Next Steps:**
→ Business Case validation
→ Process Mapping (si workflow complexe)
→ PRD création
```

## 2. Business Case

### Template Business Case
```markdown
# Business Case: [Projet]

**Version:** 1.0 | **Date:** YYYY-MM-DD | **Owner:** [BA]

## Executive Summary
[2-3 paragraphes: Quoi, Pourquoi, ROI attendu]

## 1. Problem Statement
**Current Situation (AS-IS):**
- [Pain point 1 avec impact quantifié]
- [Pain point 2 avec impact quantifié]
- [Pain point 3 avec impact quantifié]

**Impact Métier:**
- Coût actuel: [X€/an, Y heures/mois, etc.]
- Opportunité manquée: [Revenus potentiels, efficacité perdue]

## 2. Proposed Solution (TO-BE)
**Solution Overview:** [Description 1 paragraphe]

**Key Features:**
1. [Feature 1]: [Bénéfice]
2. [Feature 2]: [Bénéfice]
3. [Feature 3]: [Bénéfice]

**Success Criteria:**
- [ ] Critère mesurable 1
- [ ] Critère mesurable 2
- [ ] Critère mesurable 3

## 3. Financial Analysis

### Costs (One-time + Recurring)
| Item | Type | Cost | Notes |
|------|------|------|-------|
| Development | One-time | X€ | Internal dev time |
| Licenses | Recurring | Y€/an | [Tool/platform] |
| Training | One-time | Z€ | N users @1h each |
| Maintenance | Recurring | W€/an | 20% dev cost |
| **TOTAL One-time** | | **XX€** | |
| **TOTAL Recurring (Year 1)** | | **YY€/an** | |

### Benefits (Quantifiable)
| Benefit | Annual Value | Calculation |
|---------|--------------|-------------|
| Time saved | X€ | N users × 2h/month × 50€/h |
| Error reduction | Y€ | 10 errors/month × 500€/error |
| Revenue increase | Z€ | [Methodology] |
| **TOTAL Benefits/Year** | **XXX€** | |

### ROI Calculation
```
Total Investment (3 years) = One-time + (Recurring × 3)
                           = XX€ + (YY€ × 3) = ZZZ€

Total Benefits (3 years)   = XXX€ × 3 = AAA€

ROI = (Benefits - Investment) / Investment × 100
    = (AAA€ - ZZZ€) / ZZZ€ × 100
    = XX%

Payback Period = Investment / (Benefits/Year)
               = ZZZ€ / XXX€
               = X.X years
```

**Financial Recommendation:** ✅ Go / ⚠️ Conditional / ❌ No-Go

## 4. Stakeholder Analysis

| Stakeholder | Role | Interest | Influence | Position | Engagement Strategy |
|-------------|------|----------|-----------|----------|---------------------|
| [Name/Role] | Sponsor | High | High | Supporter | Weekly updates |
| [Name/Role] | End User | High | Low | Neutral | Training & support |
| [Name/Role] | IT Admin | Med | Med | Resister | Early involvement |

**RACI Matrix:**
| Activity | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Requirements | BA | PM | Users | IT |
| Development | Dev | PM | Architect | Sponsor |
| Testing | QA | PM | Users | All |
| Deployment | IT | PM | BA | Users |

## 5. Risk Assessment

| Risk | Probability | Impact | Score | Mitigation |
|------|-------------|--------|-------|------------|
| [Risk 1] | H/M/L | H/M/L | 9/6/3/1 | [Action] |
| [Risk 2] | H/M/L | H/M/L | 9/6/3/1 | [Action] |

**Risk Matrix:**
```
Impact ↑
High   │ [R3] │      │ [R1] │
Medium │      │ [R4] │      │
Low    │ [R5] │      │ [R2] │
       └──────┴──────┴──────┴→ Probability
         Low   Med   High
```

## 6. Alternatives Considered

### Option A: [Alternative 1]
- **Pros:** [Liste]
- **Cons:** [Liste]
- **Cost:** X€
- **Why not chosen:** [Raison]

### Option B: Status Quo (Do Nothing)
- **Pros:** Zero investment
- **Cons:** Problems persist, opportunity cost
- **Cost:** Indirect (productivity loss)

## 7. Recommendation & Next Steps

**Recommendation:** ✅ Proceed with proposed solution

**Justification:**
- [Raison 1]
- [Raison 2]
- [Raison 3]

**Next Steps:**
1. [ ] Stakeholder approval (Due: [Date])
2. [ ] Budget allocation (Due: [Date])
3. [ ] Process Mapping (if needed)
4. [ ] PRD creation → [Link to PRD skill]

**Timeline:**
- Business Case approval: [Date]
- Project kickoff: [Date]
- Go-Live target: [Date]
```

## 3. Process Mapping (BPMN)

### Quand créer un Process Map
- Workflow complexe (>5 étapes)
- Multi-départements impliqués
- Processus actuel inefficace (AS-IS → TO-BE)
- Conformité/audit trail requis

### Template Process Analysis
```markdown
# Process Analysis: [Process Name]

## AS-IS Process (Current State)

**Diagramme BPMN:**
```
[User] → Submit Request → [Manager] → Approve? → [System] → Process
                              ↓ No
                           [User] ← Reject Notification
```

**Pain Points Identifiés:**
1. 🔴 **Bottleneck:** Manager approval (avg 3 days wait)
2. 🔴 **Manual:** Email-based, no tracking
3. 🟡 **Error-prone:** 15% requests missing info

**Metrics AS-IS:**
- Cycle Time: 5 days (avg)
- Success Rate: 85%
- Manual Effort: 2h per request

## TO-BE Process (Proposed)

**Diagramme BPMN:**
```
[User] → Form (validation) → Auto-route → [Manager] → Approve? → Auto-process
            ↓                                            ↓ No
         Validation errors                         [User] ← Notification
```

**Improvements:**
1. ✅ **Automated Validation:** Form prevents incomplete submissions
2. ✅ **Tracking:** Workflow system with visibility
3. ✅ **Auto-routing:** Based on request type/amount

**Metrics TO-BE (Target):**
- Cycle Time: 1 day (avg) → 80% reduction
- Success Rate: 98% → +13%
- Manual Effort: 0.5h per request → 75% reduction

**ROI:** [Quantifier time saved × €/hour]

## Gap Analysis

| Gap | AS-IS | TO-BE | Action Required |
|-----|-------|-------|-----------------|
| Validation | Manual | Auto | Implement form validation |
| Tracking | Email | System | Deploy M-Files workflow |
| Routing | Manual | Auto | Configure business rules |

## Implementation Plan
1. [ ] Design TO-BE workflow (BPMN detailed)
2. [ ] Configure system (M-Files/SharePoint)
3. [ ] Test with 5 users (pilote)
4. [ ] Train all users
5. [ ] Migrate AS-IS → TO-BE (phased)
```

**Outils BPMN:**
- Camunda Modeler (gratuit, open source)
- draw.io / diagrams.net
- Lucidchart (payant)
- Bizagi Modeler

## 4. Requirements Elicitation Techniques

### Interviews
```markdown
**Interview Guide Template:**

**Interviewee:** [Name, Role]
**Date:** YYYY-MM-DD | **Duration:** 60min

**Opening (5min):**
- Présentation projet
- Confidentialité
- Permission enregistrement

**Questions (45min):**
1. Pouvez-vous décrire votre journée type avec [système actuel] ?
2. Quelles sont vos 3 principales frustrations ?
3. Si vous aviez une baguette magique, que changeriez-vous ?
4. Comment mesurez-vous le succès dans votre travail ?
5. Quels impacts voyez-vous sur vos collègues/département ?

**Closing (10min):**
- Synthèse points clés
- Prochaines étapes
- Merci

**Notes:**
[Verbatim key quotes]

**Action Items:**
- [ ] Follow-up question sur [sujet]
- [ ] Obtenir exemple document/processus
```

### Workshops
```markdown
**Workshop Agenda (2h):**

**Participants:** [Liste 8-12 max]
**Objectif:** [Définir scope, priorités, etc.]

**09:00-09:15 - Icebreaker**
- Tour de table
- Règles atelier (respect, écoute, timeboxing)

**09:15-09:45 - Brainstorming (Sticky Notes)**
- Question: "Quels sont vos besoins prioritaires ?"
- Chacun écrit 3-5 idées sur post-its
- Affichage mural, regroupement par thèmes

**09:45-10:15 - Dot Voting**
- Chacun 3 votes (dots) sur idées prioritaires
- Discussion top 5 idées les plus votées

**10:15-10:45 - MoSCoW Prioritization**
- Classer top 5 en Must/Should/Could/Won't
- Consensus via discussion

**10:45-11:00 - Next Steps & Wrap-up**
- Synthèse décisions
- Action items
- Date prochaine session

**Output:**
- Photo du mural (sticky notes)
- Liste priorisée exigences
- Compte-rendu atelier
```

### Surveys (pour large audience)
```markdown
**Survey Design Principles:**
- Max 10 questions (completion <5min)
- Mix Likert scale + open-ended
- Anonyme si besoin honnêteté

**Example Survey:**

1. À quelle fréquence utilisez-vous [système] ?
   - [ ] Quotidien
   - [ ] Hebdomadaire
   - [ ] Mensuel
   - [ ] Rarement

2. Niveau de satisfaction actuel (1-5):
   [Échelle 1=Très insatisfait → 5=Très satisfait]

3. Top 3 problèmes rencontrés (open-ended):
   [Texte libre]

4. Fonctionnalités souhaitées (ranking):
   Drag & drop pour ordonner [Feature A, B, C, D]

**Distribution:** Email, SharePoint, Forms

**Analysis:**
- Quantitative: Graphs, moyennes
- Qualitative: Thematic analysis (text responses)
```

## 5. Feasibility Study (Enterprise)

### Template Feasibility
```markdown
# Feasibility Study: [Projet]

## 1. Technical Feasibility
**Question:** Peut-on construire cette solution techniquement ?

**Stack évalué:**
- Frontend: [Tech] → ✅ Maîtrisé / ⚠️ À apprendre / ❌ Non viable
- Backend: [Tech] → Status
- Infrastructure: [Tech] → Status
- Integrations: [Tech] → Status

**POC Recommandé:**
- [ ] Spike technique: [Area incertaine]
- [ ] Durée: 2-5 jours
- [ ] Success criteria: [Définir]

**Risks Techniques:**
- [Risk 1]: Mitigation: [Action]

**Conclusion:** ✅ Faisable / ⚠️ Conditionnel / ❌ Non faisable

## 2. Financial Feasibility
**Question:** Peut-on se permettre cette solution financièrement ?

**Budget Required:** XX€
**Budget Available:** YY€
**Gap:** ZZ€ (déficit/surplus)

**Funding Options:**
- [ ] Budget département existant
- [ ] Request budget additionnel
- [ ] Phased approach (étaler coûts)
- [ ] External funding/grants

**Conclusion:** ✅ Financé / ⚠️ Partiel / ❌ Insuffisant

## 3. Operational Feasibility
**Question:** Peut-on opérer cette solution au quotidien ?

**Capacité Équipe:**
- Dev: [X FTE disponibles] vs [Y FTE requis]
- Support: [Capacité actuelle vs future charge]
- Maintenance: [Ressources long-terme]

**Change Impact:**
- Users affectés: N
- Training requis: [X heures/user]
- Resistance anticipated: Low/Med/High

**Conclusion:** ✅ Opérable / ⚠️ Ajustements / ❌ Insuffisant

## 4. Legal/Compliance Feasibility
**Question:** Respecte-t-on réglementations/policies ?

**Compliance Checks:**
- [ ] GDPR (données personnelles)
- [ ] ISO 27001 (sécurité info)
- [ ] Policies internes IT
- [ ] Contrats fournisseurs (licenses)

**Legal Review:**
- [ ] Validation département légal (si applicable)
- [ ] Privacy Impact Assessment (si données sensibles)

**Conclusion:** ✅ Conforme / ⚠️ Ajustements / ❌ Bloquant

## 5. Schedule Feasibility
**Question:** Peut-on livrer dans les délais ?

**Timeline Demandé:** [Date]
**Timeline Réaliste:** [Date] (basé sur estimation)
**Gap:** [X semaines en avance/retard]

**Critical Path:**
1. Requirements: 2 semaines
2. Architecture: 1 semaine
3. Development: 6 semaines
4. Testing: 2 semaines
5. Deployment: 1 semaine
**TOTAL:** 12 semaines

**Conclusion:** ✅ Achievable / ⚠️ Tight / ❌ Irréaliste

## Overall Feasibility Recommendation

| Dimension | Status | Weight | Score |
|-----------|--------|--------|-------|
| Technical | ✅ | 25% | 25 |
| Financial | ✅ | 30% | 30 |
| Operational | ⚠️ | 20% | 10 |
| Legal | ✅ | 15% | 15 |
| Schedule | ⚠️ | 10% | 5 |
| **TOTAL** | | **100%** | **85/100** |

**Scoring:** >80 = Go, 60-80 = Conditional, <60 = No-Go

**Final Recommendation:** ✅ Proceed (avec mitigation operational & schedule)

**Conditions:**
1. Hire 1 additional support FTE
2. Extend timeline +2 weeks
3. Phased rollout pour reduce operational shock
```

## 6. Change Management Plan (Enterprise)

### Template Change Management
```markdown
# Change Management Plan: [Projet]

## 1. Change Impact Assessment

**Stakeholders Impactés:**
| Group | Size | Impact Level | Resistance Risk |
|-------|------|--------------|-----------------|
| End users | N | High | Medium |
| IT Admin | 2 | Medium | Low |
| Management | 5 | Low | Low |

## 2. Communication Plan

| Audience | Message | Channel | Frequency | Owner |
|----------|---------|---------|-----------|-------|
| All users | Project kickoff | Email | Once | PM |
| End users | Training invite | Email + Poster | Weekly | BA |
| Management | Progress report | Meeting | Bi-weekly | PM |
| IT Admin | Technical details | Slack | As needed | Architect |

## 3. Training Strategy

**Training Tracks:**
1. **End Users (N):**
   - Format: Video 5min + hands-on 15min
   - Content: Basic usage, FAQ
   - Delivery: Self-serve + office hours
   - Timeline: 2 weeks avant go-live

2. **Power Users (20):**
   - Format: Workshop 2h
   - Content: Advanced features, troubleshooting
   - Delivery: In-person session
   - Timeline: 1 week avant go-live

3. **IT Admin (2):**
   - Format: Deep-dive 4h
   - Content: Architecture, maintenance, support
   - Delivery: Hands-on lab
   - Timeline: 2 weeks avant go-live

**Materials:**
- [ ] Quick Start Guide (1 page)
- [ ] Video tutorial (5min)
- [ ] FAQ document
- [ ] Troubleshooting flowchart

## 4. Adoption Metrics

**Leading Indicators (Early):**
- Training completion rate: Target >90%
- Support tickets volume: Monitor spike
- User feedback sentiment: Survey post-training

**Lagging Indicators (Post Go-Live):**
- Active users %: Target >80% in 1 month
- Feature usage: Track top 3 features adoption
- Time saved: Measure via process metrics

**Dashboard:** Weekly report to stakeholders

## 5. Resistance Management

**Anticipated Objections:**
1. "Ancien système marchait bien"
   → Response: Show metrics pain points AS-IS

2. "Pas le temps d'apprendre"
   → Response: 5min video + quick wins demo

3. "Trop compliqué"
   → Response: UX improvements + power users as champions

**Champions Network:**
- Recruit 10 early adopters (1 per department)
- Train as super-users
- Peer support role

## 6. Rollback Plan

**Trigger Conditions:**
- >20% users report critical issues
- System downtime >4 hours
- Security incident

**Rollback Steps:**
1. Pause new user onboarding
2. Revert to AS-IS process
3. Root cause analysis
4. Fix issues
5. Phased re-launch

**Timeline:** Rollback executable en <2h
```

## Checklist BA Complet

### Quick Flow
- [ ] Problem statement clair
- [ ] Impact quantifié (users, €, temps)
- [ ] Go/No-Go decision

### BMad Method
- [ ] Brainstorming session (3 personas, 5 Whys, analogies)
- [ ] Business case (ROI, stakeholders)
- [ ] Process mapping AS-IS/TO-BE (si workflow)
- [ ] Requirements document high-level

### Enterprise
- [ ] Tout BMad Method +
- [ ] Feasibility study (5 dimensions)
- [ ] Risk assessment matrice complète
- [ ] Compliance analysis
- [ ] Change management plan détaillé

## Bonnes Pratiques Multi-Casquette

1. **Start Simple, Scale Up:**
   - Quick Flow par défaut
   - Escalate to BMad si complexité émerge
   - Enterprise only si vraiment nécessaire

2. **Timeboxing Strict:**
   - Quick: 5min max
   - BMad: 15min max
   - Enterprise: 30min max
   - Si dépasse → décomposer ou async

3. **Artifacts Réutilisables:**
   - Templates dans Git
   - Examples library (anonymized)
   - Checklist automatisées

4. **Collaboration:**
   - Brainstorming ≠ solo (minimum 2-3 personas)
   - Stakeholder validation à chaque gate
   - Feedback loops courts

5. **Decision-Driven:**
   - Chaque artifact → Go/No-Go/Pivot decision
   - Pas d'analyse pour analyse
   - Actionable outputs always

## Anti-Patterns

- ❌ **Analysis Paralysis:** Trop de détails, jamais de Go decision
- ❌ **Solution-First:** Proposer solution avant comprendre problème
- ❌ **Ignorer Stakeholders:** BA solo sans input parties prenantes
- ❌ **ROI Fantaisiste:** Bénéfices inventés sans données
- ❌ **One-Size-Fits-All:** Toujours Enterprise flow (overkill)
- ❌ **Pas de Validation:** Business case non approuvé avant PRD

## Outils BA

**Élicitation:**
- Interviews: Zoom + transcript
- Workshops: Miro, Mural (virtual whiteboard)
- Surveys: Microsoft Forms, Google Forms

**Documentation:**
- Business Case: Markdown, Word
- Process Mapping: Camunda Modeler, draw.io
- Requirements: M-Files, SharePoint, Jira

**Analyse:**
- Stakeholder mapping: Excel, PowerPoint
- Risk matrix: Excel templates
- ROI calculator: Excel with scenarios

## Workflow BA Recommandé

```
Nouvelle Opportunité
    ↓
1. Quick Analysis (5min)
    ↓
   Go? → Quick Flow (direct dev) ✅
    ↓ No/Maybe
2. Brainstorming Session (1h)
    ↓
3. Business Case (2h)
    ↓
   ROI Positif? → Enterprise needed?
    ↓ Yes           ↓ No
4a. Feasibility    4b. Process Mapping (si workflow)
    + Change Mgmt       ↓
    ↓                   ↓
5. Stakeholder Approval
    ↓
6. → PRD Creation (utilise skill PRD)
    ↓
7. → Architecture (utilise skill Architecture)
```

## Output Final BA

**Documents Livrés:**
1. ✅ Brainstorming Session Results
2. ✅ Business Case (avec ROI)
3. ✅ Process Map AS-IS/TO-BE (si applicable)
4. ✅ Feasibility Study (si Enterprise)
5. ✅ Change Management Plan (si Enterprise)
6. ✅ Requirements Document (high-level, avant PRD détaillé)

**Decision Gates:**
- Gate 1: Go/No-Go sur opportunité (après Quick Analysis)
- Gate 2: Budget approval (après Business Case)
- Gate 3: Feasibility confirmed (si Enterprise)
- Gate 4: Stakeholder alignment (avant PRD)

**Handoff to PRD:**
- Requirements document → Input PRD skill
- Process maps → Input Architecture skill
- Change plan → Input Deployment planning

**Success Metrics BA:**
- Time-to-decision: <1 semaine (Quick) ou <2 semaines (Enterprise)
- Approval rate: >80% business cases approuvés
- Pivot rate: <20% projets pivotés post-BA
- Stakeholder satisfaction: Survey >4/5
