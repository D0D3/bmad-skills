# PRD - Product Requirements Document

## Description
Création de documents d'exigences produit structurés pour applications métier. Technologie-agnostique, orienté valeur métier. Adapté à tout type de projet (web, mobile, API, automatisation). Conçu pour alimenter directement les skills Architecture, DBA et UI/UX.

## Quand utiliser
- Nouveau projet d'application métier
- Évolution majeure d'un système existant
- Demande client nécessitant validation formelle
- Avant toute architecture technique
- Après la phase BA (Business Analysis)

## Structure du PRD

### 1. Vision & Objectifs
- Problème métier à résoudre
- Bénéfices attendus (quantifiables)
- Critères de succès mesurables

### 2. Personas & Utilisateurs
**Personas types :**
- Gestionnaire métier (efficacité, vue d'ensemble)
- Utilisateur final (facilité d'usage, adoption)
- Administrateur IT (maintenance, sécurité)
- Chef de projet (suivi, reporting)

### 3. Exigences Fonctionnelles
- Fonctionnalités prioritaires (MoSCoW)
- User stories format INVEST
- Critères d'acceptation vérifiables

### 4. Exigences Techniques
- Stack agnostique (à préciser avec skill `/architecture`)
- Authentification et autorisation requises
- Performances attendues
- Intégrations nécessaires

### 5. Contraintes & Risques
- Budget et délais
- Dépendances externes
- Sécurité et conformité (GDPR, etc.)
- Contraintes d'infrastructure

### 6. Success Metrics
- KPIs quantifiables
- Timeline de déploiement
- Plan de rollback

---

## Template Rapide

```markdown
# PRD: [Nom du Projet]

**Version:** 1.0 | **Date:** YYYY-MM-DD | **Owner:** [Nom]
**Statut:** Draft / Review / Approved

## 1. Vision
**Problème:** [2-3 phrases décrivant le problème métier]
**Solution:** [Proposition de solution]
**Impact attendu:** [Gains mesurables : temps, coût, satisfaction]

## 2. Personas
| Persona | Besoin principal | Pain point actuel |
|---------|-----------------|-------------------|
| Utilisateur final | [besoin] | [frustration actuelle] |
| Administrateur IT | [besoin] | [charge de travail] |
| Gestionnaire | [besoin] | [manque de visibilité] |

## 3. User Stories (MoSCoW)

### Must Have (obligatoire)
- [ ] US-01: En tant que [persona], je veux [action] afin de [bénéfice]
  - AC1 : [Critère vérifiable]
  - AC2 : [Critère vérifiable]

### Should Have (important)
- [ ] US-02: En tant que [persona], je veux [action] afin de [bénéfice]
  - AC1 : [Critère vérifiable]

### Could Have (souhaitable)
- [ ] US-03: ...

### Won't Have (hors scope)
- [Feature explicitement exclue + raison]

## 4. Exigences Techniques
- **Authentification :** [SSO / 2FA / basic auth]
- **Accès :** [Web uniquement / Mobile / Desktop]
- **Performance :** [Temps de réponse attendu, utilisateurs simultanés]
- **Intégrations :** [Systèmes tiers si applicable]
- **Infrastructure :** [Cloud / On-premise / Hybrid]

## 5. Risques
| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| [Risque 1] | H/M/L | H/M/L | [Action] |
| [Risque 2] | H/M/L | H/M/L | [Action] |

## 6. Success Criteria
- [ ] Critère 1 : [Mesurable, avec cible]
- [ ] Critère 2 : [Mesurable, avec cible]
- [ ] Timeline : [Date cible pilote] → [Date cible prod]

## 7. Questions Ouvertes
- [ ] [Question à résoudre avant architecture]
- [ ] [Décision à valider avec stakeholders]
```

---

## Template Complet (Projets Majeurs)

```markdown
# PRD: [Nom du Projet]

**Version:** 1.0 | **Date:** YYYY-MM-DD | **Owner:** [Nom]
**BA Ref:** [Lien Business Case] | **Approuvé par:** [Stakeholder]

---

## 1. Vision & Objectifs

### Contexte
[2-3 paragraphes : situation actuelle, problème métier, opportunité]

### Objectifs Stratégiques
1. [Objectif 1 aligné sur stratégie d'entreprise]
2. [Objectif 2]
3. [Objectif 3]

### Impact Attendu
| Dimension | Baseline (AS-IS) | Cible (TO-BE) | Délai |
|-----------|-----------------|---------------|-------|
| Temps tâche X | 30 min | 5 min | 3 mois |
| Taux erreurs | 15% | <2% | 3 mois |
| Satisfaction users | 3.2/5 | >4/5 | 6 mois |

---

## 2. Personas & Utilisateurs

### Persona 1 : [Nom]
- **Rôle :** [Description]
- **Objectifs :** [Ce qu'il veut accomplir]
- **Frustrations actuelles :** [Pain points]
- **Critères de succès :** [Comment il mesure la réussite]
- **Niveau technique :** Débutant / Intermédiaire / Expert

### Persona 2 : [Nom]
...

### Matrice RACI (Décision)
| Activité | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Requirements | BA | PM | Users | IT |
| Architecture | Architect | PM | DBA, UI/UX | Sponsor |
| Développement | Dev | PM | Architect | Sponsor |
| Tests | QA | PM | Users | All |
| Déploiement | IT | PM | BA | Users |

---

## 3. User Stories

### Epic 1 : [Domaine fonctionnel]

#### US-001 : [Titre]
**En tant que** [persona]
**Je veux** [action]
**Afin de** [bénéfice métier]

**Priorité :** Must Have | **Complexité estimée :** S/M/L/XL

**Acceptance Criteria :**
- AC1 : [Critère Given/When/Then ou texte vérifiable]
- AC2 : [Critère]
- AC3 : [Critère]

**Exigences UI/UX :** [Écran concerné, wireframe ref si disponible]
**Exigences DB :** [Données créées/modifiées, consulter /dba]
**Exigences sécurité :** [Rôle requis, données sensibles]

---

## 4. Exigences Fonctionnelles

### Authentification & Accès
- [ ] Login SSO (OIDC compatible)
- [ ] 2FA obligatoire pour rôles sensibles
- [ ] Session timeout configurable
- [ ] Rôles : [lister les rôles]

### Fonctionnalités Principales
| ID | Fonctionnalité | Priorité | Persona |
|----|---------------|----------|---------|
| F-01 | [Fonctionnalité] | Must | [Persona] |
| F-02 | [Fonctionnalité] | Should | [Persona] |

### Notifications
- [ ] Email pour [événement X]
- [ ] Notification in-app pour [événement Y]
- [ ] Fréquence configurable par utilisateur

---

## 5. Exigences Techniques

### Performance
| Métrique | Cible | Maximum acceptable |
|----------|-------|-------------------|
| Page load | <2s | <5s |
| API response (p95) | <300ms | <1s |
| Upload fichier | <30s (50MB) | <60s |
| Utilisateurs simultanés | N | N×2 |

### Compatibilité
- **Navigateurs :** Chrome, Firefox, Safari, Edge (versions N-1)
- **Mobile :** iOS 15+, Android 10+ (si applicable)
- **Résolution minimale :** 375px (mobile), 1280px (desktop)

### Intégrations
| Système | Type | Sens | Priorité |
|---------|------|------|----------|
| [Système A] | REST API | Bidirectionnel | Must |
| [Système B] | Webhook | Entrant | Should |

### Sécurité & Conformité
- HTTPS obligatoire (TLS 1.3)
- Données personnelles : GDPR compliant
- Rétention logs : [durée]
- Audit trail : [quelles actions tracées]
- Backup : quotidien, rétention [durée]

---

## 6. Contraintes & Hors Scope

### Contraintes
- Budget : [fourchette]
- Timeline : [Date cible]
- Ressources : [Équipe disponible]
- Infrastructure : [Existante vs nouvelle]

### Hors Scope (Won't Have)
- [Feature A] : Raison → [Explication]
- [Feature B] : Raison → [Planifié Q3 2025]

---

## 7. Success Metrics

| KPI | Baseline | Cible 3 mois | Cible 6 mois | Mesure |
|-----|----------|--------------|--------------|--------|
| Adoption | 0% | >60% | >85% | Users actifs/total |
| Satisfaction | N/A | >3.5/5 | >4/5 | Survey mensuel |
| [Métrique métier] | [valeur] | [cible] | [cible] | [comment mesurer] |

### Go-Live Criteria
- [ ] Tests UAT passés (>95% scénarios)
- [ ] Performance validée (charge test)
- [ ] Documentation utilisateur livrée
- [ ] Formation pilotes effectuée
- [ ] Plan rollback documenté

---

## 8. Références & Liens
- Business Case : [Lien]
- Maquettes Figma : [Lien]
- Architecture : [Lien - générée après ce PRD]
- Backlog Stories : [Lien]
```

---

## Questions DBA (à poser avant architecture)

> Le PRD doit anticiper les besoins data avant de passer à l'architecture

```markdown
## Consultation DBA requise pour :

### Volumes de données
- Nombre d'utilisateurs attendus : [N]
- Nombre d'enregistrements par table principale : [estimation]
- Croissance mensuelle estimée : [%]
- Rétention des données : [durée]

### Entités métier identifiées
- [Entité 1] → [Attributs principaux]
- [Entité 2] → [Attributs principaux]
- Relations : [Entité 1] 1-N [Entité 2]

### Requêtes critiques anticipées
- Recherche full-text sur [entité] ?
- Filtres fréquents : [colonnes]
- Exports/rapports : [volume, fréquence]
```

## Questions UI/UX (à poser avant architecture)

```markdown
## Consultation UI/UX requise pour :

### Complexité interface
- Nombre d'écrans estimé : [N]
- Formulaires complexes : [Oui/Non - décrire]
- Tableaux de données : [Oui/Non - volume lignes]
- Dashboard/analytics : [Oui/Non]

### Accès mobile
- Application mobile native : [Oui/Non]
- Web responsive mobile : [Oui/Non - priorité]
- Progressive Web App : [Oui/Non]

### Contraintes design
- Charte graphique existante : [Oui/Non]
- Accessibilité WCAG requis : [AA minimum]
- Multilingue : [Langues]
```

---

## Bonnes Pratiques

1. **Concision :** Max 3 pages Quick PRD, 8 pages Complet
2. **Mesurable :** Chaque objectif avec KPI quantifiable
3. **Itératif :** PRD v1.0 → v1.1 selon feedback (document vivant)
4. **Consulter DBA et UI/UX tôt :** Avant de finaliser les exigences techniques
5. **Questions ouvertes documentées :** Mieux vaut noter l'inconnu que l'ignorer
6. **Validation stakeholders :** Approbation formelle avant passage à architecture

## Anti-Patterns

- PRD de 20 pages que personne ne lit
- User stories sans critères d'acceptation
- "Améliorer l'UX" sans définition mesurable
- Exigences techniques qui prescrivent un logiciel spécifique (laisser à /architecture)
- Pas de plan rollback
- Scope créep non documenté (tout ajouter en cours de route)
- Pas de questions ouvertes (fausse certitude)

## Checklist Validation PRD

- [ ] Vision claire en 1-2 paragraphes
- [ ] Personas identifiés (minimum 2)
- [ ] User stories INVEST avec acceptance criteria
- [ ] Exigences techniques sans prescription logicielle
- [ ] Risques identifiés avec mitigation
- [ ] Success metrics quantifiables
- [ ] Questions DBA documentées
- [ ] Questions UI/UX documentées
- [ ] Validation PM/stakeholders obtenue
- [ ] Hors scope explicitement listé

## Workflow Recommandé

1. Brief initial (30min) → Problème + vision 1 paragraphe
2. Consultation /ba → Business case validé comme input
3. PRD v0.1 (2h) → Template complété
4. Consultation /dba (30min) → Questions data identifiées
5. Consultation /uiux (30min) → Questions interface identifiées
6. Review stakeholders (1h) → Validation PM + sponsor
7. PRD v1.0 (30min) → Finalisation + approbation
8. Passage à Architecture → Utilise skill /architecture
