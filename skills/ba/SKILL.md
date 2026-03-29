# BA - Business Analysis Multi-Casquette

## Description
Business Analysis complète upstream du PRD. Couvre brainstorming, analyse métier, process mapping, feasibility, stakeholder management. Multi-casquette pour s'adapter au contexte projet (Quick Flow → Enterprise). Technologie-agnostique.

## Quand utiliser
- Avant le PRD — Phase discovery
- Nouvelle opportunité métier floue
- Stakeholders multiples à aligner
- Processus métier complexe à analyser
- Feasibility study nécessaire
- Gap analysis AS-IS → TO-BE

## Workflows BA selon Complexité

### Quick Flow (< 5 min)
**Pour :** Bug fix, petite feature, scope clair

**Livrables :**
- Problem Statement (1 paragraphe)
- Impact rapide (qui/quoi/combien)
- Go/No-Go decision

**Template :**
```markdown
# Quick Analysis: [Titre]

**Problem:** [1-2 phrases du problème]
**Impact:** [X users, Y€ économie, Z% gain]
**Effort:** Low/Med/High
**Decision:** Go / No-Go / Needs more analysis

**Next Step:** → Dev direct OU → BA complet si complexe
```

### BMad Method (< 15 min)
**Pour :** Nouveau produit, plateforme, scope modéré

**Livrables :**
1. Brainstorming Session Results (techniques d'élicitation)
2. Business Case (ROI, stakeholders)
3. Process Mapping (AS-IS/TO-BE si applicable)
4. Requirements Document (high-level, avant PRD détaillé)

### Enterprise (< 30 min)
**Pour :** Conformité, scalabilité, multi-stakeholders, haute criticité

**Livrables :**
1. Tout BMad Method +
2. Feasibility Study (technique, financier, opérationnel)
3. Risk Assessment (matrice complète)
4. Compliance Analysis (réglementaire, sécurité)
5. Change Management Plan (adoption, formation)

---

## 1. Brainstorming Session Results

### Techniques d'Élicitation

#### A. Role Playing (3 Personas)
**Objectif :** Explorer besoins sous 3 angles différents

**Template :**
```markdown
## Brainstorming Session: [Projet]

**Date:** YYYY-MM-DD | **Facilitateur:** [Nom] | **Durée:** 60min

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
### Persona 1: Gestionnaire Applications Métier
**Profil:** Touche-à-tout, manque de temps, besoin d'efficacité
**Besoins:**
- "Je veux automatiser les tâches répétitives pour me concentrer sur l'amélioration"
- "J'ai besoin de solutions robustes, pas le temps de déboguer en permanence"
**Insights:** Prioriser l'automation et la robustesse sur la richesse fonctionnelle

### Persona 2: Utilisateur Final
**Profil:** Peu tech-savvy, résistant au changement
**Besoins:**
- "Je veux que ça marche comme avant, mais en mieux"
- "Pas de formation de 2h, je veux comprendre en 5 minutes"
**Insights:** UX intuitive critique, formation minimale, adoption progressive

### Persona 3: Chef de Projet
**Profil:** Accountability sur les résultats, délais serrés
**Besoins:**
- "Je veux des livrables prévisibles, pas de surprises"
- "ROI mesurable en 6 mois maximum"
**Insights:** Phased rollout, métriques claires, communication proactive
```

#### B. Five Whys (Root Cause Analysis)
**Objectif :** Creuser pour trouver le vrai problème

**Template :**
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

**Exemple :**
```markdown
**Problem:** "Les utilisateurs ne retrouvent pas leurs documents"

1. Why? → Parce que la recherche retourne trop de résultats
2. Why? → Parce que les données ne sont pas bien catégorisées
3. Why? → Parce que les utilisateurs ne comprennent pas quels champs remplir
4. Why? → Parce qu'il n'y a pas de guidance ni de formation dans l'interface
5. Why? → Parce qu'on a priorisé le déploiement rapide sur l'adoption

**Root Cause:** Manque de change management et de guidage UX
**Implication:** Solution = formation + améliorations UX, pas seulement meilleur algorithme
```

#### C. Analogical Thinking
**Objectif :** Clarifier un concept complexe via des analogies

**Template :**
```markdown
### Analogies pour [Concept]

**Analogie 1:** [Concept] est comme [Analogie connue]
- **Similitudes:** [Points communs]
- **Différences:** [Nuances importantes]
- **Insights:** [Ce que l'analogie révèle]
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
-> Business Case validation
-> Process Mapping (si workflow complexe)
-> PRD création
```

---

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

**Impact Métier:**
- Coût actuel: [X€/an, Y heures/mois]
- Opportunité manquée: [Description]

## 2. Proposed Solution (TO-BE)
**Solution Overview:** [Description 1 paragraphe]

**Key Features:**
1. [Feature 1]: [Bénéfice]
2. [Feature 2]: [Bénéfice]

**Success Criteria:**
- [ ] Critère mesurable 1
- [ ] Critère mesurable 2

## 3. Financial Analysis

### Costs
| Item | Type | Coût | Notes |
|------|------|------|-------|
| Développement | One-time | X€ | Temps équipe interne |
| Infrastructure | Recurring | Y€/an | Serveurs, licences open-source |
| Formation | One-time | Z€ | N users × 1h |
| Maintenance | Recurring | W€/an | 20% coût dev |

### Benefits
| Bénéfice | Valeur Annuelle | Calcul |
|----------|----------------|--------|
| Temps économisé | X€ | N users × 2h/mois × 50€/h |
| Réduction erreurs | Y€ | 10 erreurs/mois × 500€/erreur |

### ROI
```
Total Investment (3 ans) = One-time + (Recurring × 3)
Total Benefits (3 ans)   = Benefits/an × 3
ROI = (Benefits - Investment) / Investment × 100
Payback Period = Investment / (Benefits/Year)
```

## 4. Stakeholder Analysis

| Stakeholder | Rôle | Intérêt | Influence | Position | Stratégie |
|-------------|------|---------|-----------|----------|-----------|
| [Nom/Rôle] | Sponsor | High | High | Supporter | Updates hebdo |
| [Nom/Rôle] | User final | High | Low | Neutre | Formation + support |
| [Nom/Rôle] | IT Admin | Med | Med | Résistant | Implication précoce |

## 5. Risk Assessment

| Risque | Probabilité | Impact | Score | Mitigation |
|--------|-------------|--------|-------|------------|
| [Risque 1] | H/M/L | H/M/L | 9/6/3/1 | [Action] |

## 6. Alternatives Considérées

### Option A: Solution proposée
- Pros: [Liste]
- Cons: [Liste]

### Option B: Status Quo
- Pros: Zéro investissement
- Cons: Problèmes persistent, coût d'opportunité

## 7. Recommandation & Next Steps

**Recommandation:** Procéder avec la solution proposée

**Conditions:**
1. [Condition 1]
2. [Condition 2]

**Next Steps:**
1. [ ] Approbation stakeholders (Deadline: [Date])
2. [ ] Allocation budget (Deadline: [Date])
3. [ ] PRD création → skill /prd
```

---

## 3. Process Mapping (BPMN)

### Quand créer un Process Map
- Workflow complexe (>5 étapes)
- Multi-départements impliqués
- Processus actuel inefficace
- Audit trail requis

### Template Process Analysis
```markdown
# Process Analysis: [Process Name]

## AS-IS Process (État Actuel)

**BPMN Diagram:**
```
[User] -> Submit Request -> [Manager] -> Approve? -> [System] -> Process
                                |  Non
                             [User] <- Notification Rejet
```

**Pain Points Identifiés:**
1. Bottleneck: Approbation manager (délai moyen 3 jours)
2. Manuel: Basé sur email, sans traçabilité
3. Error-prone: 15% des demandes incomplètes

**Métriques AS-IS:**
- Cycle Time: 5 jours (moyenne)
- Taux de succès: 85%
- Effort manuel: 2h par demande

## TO-BE Process (Proposition)

**BPMN Diagram:**
```
[User] -> Formulaire (validation) -> Auto-routing -> [Manager] -> Approve?
             |                                           |  Non
         Erreurs validation                       [User] <- Notification
```

**Améliorations:**
1. Validation automatique: Formulaire bloque les soumissions incomplètes
2. Traçabilité: Workflow système avec visibilité complète
3. Auto-routing: Basé sur type/montant demande

**Métriques TO-BE (Cibles):**
- Cycle Time: 1 jour (réduction 80%)
- Taux de succès: 98% (+13%)
- Effort manuel: 0.5h par demande (réduction 75%)

## Gap Analysis

| Gap | AS-IS | TO-BE | Action Requise |
|-----|-------|-------|----------------|
| Validation | Manuelle | Auto | Implémenter validation formulaire |
| Traçabilité | Email | Système | Déployer workflow applicatif |
| Routing | Manuel | Auto | Configurer règles métier |
```

**Outils BPMN :**
- Camunda Modeler (gratuit, open-source)
- draw.io / diagrams.net
- Excalidraw (rapide pour wireframes workflow)
- Bizagi Modeler

---

## 4. Techniques d'Élicitation

### Interviews
```markdown
**Guide d'Interview:**

**Interviewé:** [Nom, Rôle]
**Date:** YYYY-MM-DD | **Durée:** 60min

**Ouverture (5min):**
- Présentation projet
- Confidentialité si applicable
- Permission enregistrement

**Questions (45min):**
1. Décrivez votre journée type avec [système actuel]
2. Quelles sont vos 3 principales frustrations ?
3. Si vous pouviez changer une seule chose, ce serait quoi ?
4. Comment mesurez-vous votre succès au quotidien ?
5. Quels impacts voyez-vous sur vos collègues / département ?

**Clôture (10min):**
- Synthèse points clés
- Prochaines étapes
- Remerciements

**Notes:** [Verbatim citations clés]
**Action Items:**
- [ ] Follow-up sur [sujet]
- [ ] Obtenir exemple de processus
```

### Workshops
```markdown
**Workshop Agenda (2h):**

**Participants:** [Liste 8-12 max]
**Objectif:** [Définir scope, priorités]

**09:00-09:15 - Icebreaker**
Tour de table + règles atelier

**09:15-09:45 - Brainstorming (Post-its ou Miro)**
"Quels sont vos besoins prioritaires ?"
-> Chacun 3-5 idées, affichage, regroupement par thèmes

**09:45-10:15 - Dot Voting**
Chacun 3 votes sur idées prioritaires
Discussion top 5

**10:15-10:45 - MoSCoW Prioritization**
Classer en Must/Should/Could/Won't

**10:45-11:00 - Wrap-up**
Synthèse décisions + Action items

**Output:**
- Liste priorisée exigences
- Compte-rendu atelier
```

### Surveys
```markdown
**Principes Survey:**
- Max 10 questions (complétion <5min)
- Mix Likert + open-ended
- Anonyme si besoin d'honnêteté

**Outils :** Google Forms (gratuit), LimeSurvey (open-source auto-hébergé)

**Distribution :** Email, lien direct, intégration portail interne
```

---

## 5. Feasibility Study (Enterprise)

### Template Feasibility
```markdown
# Feasibility Study: [Projet]

## 1. Technical Feasibility
**Stack évalué:**
- Frontend: [Tech] -> Maîtrisé / À apprendre / Non viable
- Backend: [Tech] -> Status
- Infrastructure: [Tech] -> Status

**POC Recommandé:**
- [ ] Spike technique: [Zone incertaine]
- [ ] Durée: 2-5 jours
- [ ] Critères de succès: [Définir]

**Conclusion:** Faisable / Conditionnel / Non faisable

## 2. Financial Feasibility
**Budget Requis:** XX€
**Budget Disponible:** YY€
**Conclusion:** Financé / Partiel / Insuffisant

## 3. Operational Feasibility
**Capacité Équipe:**
- Dev: [X FTE disponibles] vs [Y FTE requis]
- Support: [Capacité actuelle vs future charge]

**Conclusion:** Opérable / Ajustements / Insuffisant

## 4. Legal/Compliance Feasibility
**Compliance Checks:**
- [ ] GDPR (données personnelles)
- [ ] Politiques internes IT
- [ ] Contrats fournisseurs

**Conclusion:** Conforme / Ajustements / Bloquant

## 5. Schedule Feasibility
**Timeline Demandé:** [Date]
**Timeline Réaliste:** [Date]

**Critical Path:**
1. Requirements: 2 semaines
2. Architecture: 1 semaine
3. Développement: 6 semaines
4. Tests: 2 semaines
5. Déploiement: 1 semaine
**TOTAL:** 12 semaines

**Conclusion:** Achievable / Tight / Irréaliste

## Overall Recommendation

| Dimension | Status | Poids | Score |
|-----------|--------|-------|-------|
| Technique | OK | 25% | 25 |
| Financier | OK | 30% | 30 |
| Opérationnel | Partiel | 20% | 10 |
| Legal | OK | 15% | 15 |
| Schedule | Partiel | 10% | 5 |
| **TOTAL** | | **100%** | **85/100** |

**Scoring:** >80 = Go, 60-80 = Conditionnel, <60 = No-Go

**Recommandation Finale:** Proceed (avec conditions)
```

---

## 6. Change Management Plan (Enterprise)

### Template Change Management
```markdown
# Change Management Plan: [Projet]

## 1. Impact Assessment

| Groupe | Taille | Impact | Risque Résistance |
|--------|--------|--------|-------------------|
| Utilisateurs finaux | N | High | Medium |
| IT Admin | 2 | Medium | Low |
| Management | 5 | Low | Low |

## 2. Communication Plan

| Audience | Message | Canal | Fréquence | Owner |
|----------|---------|-------|-----------|-------|
| Tous users | Lancement projet | Email | Unique | PM |
| Users finaux | Invitation formation | Email + poster | Hebdo | BA |
| Management | Rapport avancement | Réunion | Bi-hebdo | PM |
| IT Admin | Détails techniques | Chat | Selon besoin | Architecte |

## 3. Training Strategy

**Tracks de Formation:**
1. **Utilisateurs finaux (N) :**
   - Format: Vidéo 5min + hands-on 15min
   - Contenu: Usage de base, FAQ
   - Livraison: Self-serve + permanences
   - Timeline: 2 semaines avant go-live

2. **Power Users (20) :**
   - Format: Atelier 2h
   - Contenu: Fonctionnalités avancées, troubleshooting
   - Livraison: Session présentielle

3. **IT Admin (2) :**
   - Format: Deep-dive 4h
   - Contenu: Architecture, maintenance, support
   - Livraison: Lab hands-on
   - Timeline: 2 semaines avant go-live

**Matériels:**
- [ ] Guide démarrage rapide (1 page)
- [ ] Vidéo tutoriel (5min)
- [ ] FAQ document
- [ ] Flowchart troubleshooting

## 4. Métriques d'Adoption

**Leading Indicators (précoce) :**
- Taux complétion formation: >90%
- Volume tickets support: Surveiller pic
- Sentiment feedback: Survey post-formation

**Lagging Indicators (post go-live) :**
- Utilisateurs actifs: >80% en 1 mois
- Utilisation top 3 fonctionnalités
- Temps économisé: Mesure via métriques process

## 5. Resistance Management

**Objections anticipées:**
1. "L'ancien système marchait bien"
   -> Montrer métriques des pain points AS-IS

2. "Je n'ai pas le temps d'apprendre"
   -> Vidéo 5min + quick wins demo

3. "C'est trop compliqué"
   -> Améliorations UX + champions utilisateurs

**Champions Network:**
- Recruter 10 early adopters (1 par département)
- Former comme super-users
- Rôle de pair support

## 6. Rollback Plan

**Triggers:**
- >20% users rapportent des problèmes critiques
- Downtime système >4 heures
- Incident de sécurité

**Étapes:**
1. Pause onboarding nouveaux users
2. Revenir au processus AS-IS
3. Root cause analysis
4. Correction problèmes
5. Re-lancement phasé
```

---

## Checklist BA Complet

### Quick Flow
- [ ] Problem statement clair
- [ ] Impact quantifié
- [ ] Go/No-Go decision

### BMad Method
- [ ] Brainstorming session (3 personas, 5 Whys)
- [ ] Business case (ROI, stakeholders)
- [ ] Process mapping AS-IS/TO-BE (si workflow)
- [ ] Requirements document high-level

### Enterprise
- [ ] Tout BMad Method +
- [ ] Feasibility study (5 dimensions)
- [ ] Risk assessment matrice complète
- [ ] Compliance analysis
- [ ] Change management plan détaillé

## Bonnes Pratiques

1. **Start Simple, Scale Up :** Quick Flow par défaut, escalader si complexité émerge
2. **Timeboxing Strict :** Quick 5min max, BMad 15min max, Enterprise 30min max
3. **Artifacts Réutilisables :** Templates dans Git, examples anonymisés
4. **Collaboration :** Brainstorming ≠ solo (minimum 2-3 personas)
5. **Decision-Driven :** Chaque artifact → Go/No-Go/Pivot

## Anti-Patterns

- Analysis Paralysis: Trop d'analyse, jamais de décision
- Solution-First: Proposer une solution avant comprendre le problème
- Ignorer les Stakeholders: BA solo sans input des parties prenantes
- ROI Fantaisiste: Bénéfices inventés sans données réelles
- One-Size-Fits-All: Toujours Enterprise flow (overkill)
- Pas de Validation: Business case non approuvé avant PRD

## Outils BA

**Élicitation:**
- Interviews: Zoom + transcript
- Workshops: Miro, Mural (whiteboard virtuel), Excalidraw

**Documentation:**
- Business Case: Markdown dans Git
- Process Mapping: Camunda Modeler, draw.io, Excalidraw
- Requirements: Markdown + PRD skill

**Analyse:**
- Stakeholder mapping: Markdown table, Miro
- Risk matrix: Markdown table
- ROI calculator: Tableur avec scénarios

## Workflow BA Recommandé

```
Nouvelle Opportunité
    |
1. Quick Analysis (5min)
    |
   Go? -> Quick Flow (direct dev)
    | Non/Peut-être
2. Brainstorming Session (1h)
    |
3. Business Case (2h)
    |
   ROI Positif? -> Enterprise needed?
    | Oui             | Non
4a. Feasibility    4b. Process Mapping (si workflow)
    + Change Mgmt
    |
5. Stakeholder Approval
    |
6. -> PRD Creation (skill /prd)
    |
7. -> Architecture (skill /architecture)
```

## Output Final BA

**Documents Livrés:**
1. Brainstorming Session Results
2. Business Case (avec ROI)
3. Process Map AS-IS/TO-BE (si applicable)
4. Feasibility Study (si Enterprise)
5. Change Management Plan (si Enterprise)
6. Requirements Document (high-level, input PRD)

**Decision Gates:**
- Gate 1: Go/No-Go sur opportunité (après Quick Analysis)
- Gate 2: Budget approval (après Business Case)
- Gate 3: Feasibility confirmed (si Enterprise)
- Gate 4: Stakeholder alignment (avant PRD)

**Métriques Qualité BA:**
- Time-to-decision: <1 semaine (Quick) ou <2 semaines (Enterprise)
- Taux d'approbation: >80% business cases approuvés
- Taux de pivot: <20% projets pivotés post-BA
