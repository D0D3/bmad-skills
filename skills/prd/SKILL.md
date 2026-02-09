# PRD - Product Requirements Document

## Description
Création de documents d'exigences produit structurés pour applications métier, workflows M-Files, et projets SharePoint. Adapté au contexte Entreprise et ses N postes de travail.

## Quand utiliser
- Nouveau projet d'application métier
- Évolution majeure de workflow M-Files
- Déploiement SharePoint avec automatisation
- Demande client nécessitant validation formelle
- Avant toute architecture technique

## Structure du PRD

### 1. Vision & Objectifs
- Problème métier à résoudre
- Bénéfices attendus (quantifiables)
- Critères de succès mesurables

### 2. Personas & Utilisateurs
**Exemples Entreprise:**
- Gestionnaire métier 
- Utilisateur final 
- Administrateur IT 
- Chef de projet 

### 3. Exigences Fonctionnelles
- Fonctionnalités prioritaires (MoSCoW: Must/Should/Could/Won't)
- User stories format: "En tant que [persona], je veux [action] pour [bénéfice]"
- Critères d'acceptation vérifiables

### 4. Exigences Techniques
**Stack Entreprise typique:**
- M-Files (workflows, métadonnées, gRPC)
- SharePoint (listes, colonnes JSON, Power Automate)
- PowerShell (AD, automation)
- Docker/Proxmox (homelab)

### 5. Contraintes & Risques
- Budget temps/ressources
- Dépendances externes (prestataires, partenaires)
- Compatibilité avec N postes
- Sécurité Azure 2FA

### 6. Success Metrics
- KPIs quantifiables
- Timeline de déploiement
- Plan de rollback

## Template Rapide

```markdown
# PRD: [Nom du Projet]

**Version:** 1.0 | **Date:** YYYY-MM-DD | **Owner:** DoD

## 1. Vision
**Problème:** [Décris en 2-3 phrases]
**Solution:** [Ta proposition]
**Impact:** [Gains mesurables]

## 2. Personas
| Persona | Besoin | Pain Point |
|---------|--------|------------|
| User final | [besoin] | [problème actuel] |
| Admin IT | [besoin] | [problème actuel] |

## 3. User Stories (MoSCoW)
### Must Have
- [ ] US-01: En tant que [persona], je veux [action] pour [bénéfice]
  - AC: [Critère d'acceptation]

### Should Have
- [ ] US-02: ...

## 4. Stack Technique
- Backend: [M-Files / SharePoint / Custom]
- Frontend: [Web / Desktop / Mobile]
- Integration: [APIs, PowerShell, etc.]
- Déploiement: [Workstations / Cloud / Hybrid]

## 5. Risques
| Risque | Impact | Mitigation |
|--------|--------|------------|
| [Risque 1] | High/Med/Low | [Comment l'atténuer] |

## 6. Success Criteria
- [ ] Critère 1 (mesurable)
- [ ] Critère 2 (mesurable)
- [ ] Timeline: [Date cible]
```

## Bonnes Pratiques Entreprise
1. **Validation Design Sprint:** Utilise ton toolkit Design Sprint avant PRD complet
2. **Itération:** PRD n'est pas figé, version it (v1.0 → v1.1)
3. **Concision:** Max 3 pages pour quick-wins, 5-8 pour projets majeurs
4. **Alignement:** Sync avec Chef de projet (PM) avant finalisation
5. **Documentation:** Stocke dans M-Files, référence dans SharePoint

## Anti-Patterns
- ❌ PRD de 20 pages que personne ne lit
- ❌ Pas de critères de succès mesurables
- ❌ User stories vagues ("améliorer UX")
- ❌ Ignorer les contraintes de déploiement 
- ❌ Pas de plan de rollback

## Checklist Validation
- [ ] Vision claire en 1 paragraphe
- [ ] Au moins 3 personas identifiés
- [ ] User stories avec acceptance criteria
- [ ] Stack technique défini
- [ ] 3-5 risques identifiés avec mitigation
- [ ] Success metrics quantifiables
- [ ] Validation PM/stakeholders

## Exemples Entreprise

### Exemple 1: M-Files Phase 3 Mobility
```markdown
**Vision:** Permettre accès mobile sécurisé à M-Files pour N utilisateurs terrain
**Success Metric:** 80% adoption mobile dans 3 mois post-déploiement
**Must Have:** gRPC, Azure 2FA, Traefik proxy WAN
**Risque:** Latence réseau → Mitigation: Test pilote 5 users avant rollout
```

### Exemple 2: SharePoint Gantt JSON
```markdown
**Vision:** Visualisation Gantt temps-réel sans Power BI
**Success Metric:** Refresh automatique <5sec, 100% compatible IE11
**Must Have:** Column formatting JSON, calculs dates automatiques
**Should Have:** Export PDF, filtres dynamiques
```

## Workflow Recommandé
1. **Brief initial** (30min): Problème + vision 1 paragraphe
2. **Design Sprint validation** (si applicable)
3. **PRD v0.1** (2h): Template complété
4. **Review Chef de projet** (1h): Validation PM
5. **PRD v1.0** (30min): Finalisation
6. **Passage à Architecture** → Utilise skill `architecture`
