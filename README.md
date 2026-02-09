# BMAD Skills - Business Agile Development

Skills professionnels pour Claude Code inspirés de la méthodologie BMAD (Breakthrough Method for Agile AI-Driven Development).

## 📚 Skills Disponibles

### 1. BA - Business Analysis
**Fichier:** `ba/SKILL.md`

Analyse métier multi-casquette avec 3 niveaux adaptables :
- **Quick Flow** (<5min): Problem statement, Go/No-Go
- **BMad Method** (<15min): Brainstorming, Business Case, Process Mapping
- **Enterprise** (<30min): Feasibility Study, Change Management

**Techniques:**
- Role Playing (3 personas)
- Five Whys (root cause)
- Analogical Thinking
- Interviews, Workshops, Surveys

**Livrables:**
- Brainstorming Session Results
- Business Case (ROI)
- Process Maps BPMN (AS-IS/TO-BE)
- Feasibility Study
- Change Management Plan

---

### 2. PRD - Product Requirements Document
**Fichier:** `prd/SKILL.md`

Création de documents d'exigences produit structurés.

**Contenu:**
- Vision & Objectifs
- Personas & Utilisateurs
- User Stories (format INVEST)
- Exigences fonctionnelles/techniques
- Contraintes & Risques
- Success Metrics

**Templates:**
- PRD Quick (3 pages)
- PRD Complet (5-8 pages)
- Design Sprint validation

---

### 3. Architecture
**Fichier:** `architecture/SKILL.md`

Conception technique et décisions architecturales.

**Inclut:**
- ADR (Architecture Decision Records)
- Diagrammes C4 Model
- Sécurité & Compliance
- Scalabilité & Performance
- Plan de déploiement
- Monitoring & Logging

**Outils:**
- BPMN pour workflows
- Diagrammes système
- Tech stack documentation

---

### 4. Stories - Epics & User Stories
**Fichier:** `stories/SKILL.md`

Décomposition agile en Epics et User Stories.

**Format:**
- User Stories INVEST
- Acceptance Criteria
- Definition of Done
- Story Points (Fibonacci)
- MoSCoW Prioritization

**Gestion:**
- Sprint Planning
- Backlog Refinement
- Epic Decomposition
- Velocity Tracking

---

### 5. QA - Quality Assurance
**Fichier:** `qa/SKILL.md`

Stratégies de test et validation qualité.

**Pyramide de tests:**
- Unit Tests (50%)
- Functional Tests (30%)
- Integration Tests (15%)
- UAT (5%)

**Inclut:**
- Test Plans
- Test Cases
- Bug Tracking
- Regression Testing
- Performance Testing
- Déploiement phased (pilote → production)

---

## 🚀 Installation

### Option 1: Installation Locale (Claude Code)

1. **Cloner le repo:**
```bash
git clone https://github.com/[votre-username]/bmad-skills.git
cd bmad-skills
```

2. **Copier dans Claude Code:**
```bash
# Windows
xcopy /E /I skills "%USERPROFILE%\.claude\skills"

# Linux/Mac
cp -r skills/* ~/.claude/skills/
```

3. **Vérifier l'installation:**
```bash
# Dans Claude Code
skills
```

Vous devriez voir :
- ba
- prd
- architecture
- stories
- qa

---

### Option 2: Installation Git Submodule (Projet Spécifique)

Si vous voulez utiliser ces skills dans un projet spécifique :

```bash
cd votre-projet

# Ajouter comme submodule
git submodule add https://github.com/[votre-username]/bmad-skills.git .claude/skills

# Initialiser
git submodule update --init --recursive
```

**Update skills:**
```bash
cd votre-projet
git submodule update --remote --merge
```

---

### Option 3: Installation Directe (sans Git)

1. **Télécharger le ZIP:**
   - GitHub → Code → Download ZIP
   - Extraire

2. **Copier manuellement:**
```
%USERPROFILE%\.claude\skills\
├── ba\
│   └── SKILL.md
├── prd\
│   └── SKILL.md
├── architecture\
│   └── SKILL.md
├── stories\
│   └── SKILL.md
└── qa\
    └── SKILL.md
```

3. **Redémarrer Claude Code**

---

## 📖 Utilisation

### Appel Direct (si supporté)
```bash
/ba
/prd
/architecture
/stories
/qa
```

### Langage Naturel (recommandé)
```
"utilise le skill BA pour analyser cette opportunité"
"crée un PRD avec le skill prd"
"applique le skill architecture pour documenter les décisions"
"décompose en stories selon le skill stories"
"crée un test plan avec le skill qa"
```

### Détection Automatique
Claude détecte automatiquement le skill pertinent selon votre demande :
```
"je veux créer un business case pour [projet]"
→ Claude charge automatiquement le skill BA

"quels sont les user stories pour cette feature ?"
→ Claude charge automatiquement le skill stories
```

---

## 🔄 Workflow Complet BMAD

```
1. BA (Business Analysis)
   ↓
   → Brainstorming Session
   → Business Case (ROI)
   → Process Mapping (si workflow)
   → Feasibility Study (si Enterprise)
   ↓
2. PRD (Product Requirements)
   ↓
   → Vision & Objectifs
   → User Stories high-level
   → Success Metrics
   ↓
3. Architecture
   ↓
   → ADR (décisions techniques)
   → Diagrammes système
   → Sécurité & Déploiement
   ↓
4. Stories (Epics & User Stories)
   ↓
   → Décomposition en stories
   → Estimation (Story Points)
   → Sprint Planning
   ↓
5. QA (Quality Assurance)
   ↓
   → Test Plan
   → Test Cases
   → UAT
   → Déploiement
```

---

## 🎯 Tracks de Planification

### Quick Flow
**Durée:** <5min  
**Pour:** Bug fix, petite feature, scope clair

**Skills utilisés:**
- BA (Quick Analysis uniquement)
- PRD (optionnel, version courte)
- Stories (1-2 stories max)

---

### BMad Method
**Durée:** <15min  
**Pour:** Nouveau produit, plateforme, scope modéré

**Skills utilisés:**
- BA (Brainstorming + Business Case)
- PRD (complet)
- Architecture (ADRs essentiels)
- Stories (Epics + Stories décomposés)
- QA (Test Plan standard)

---

### Enterprise
**Durée:** <30min  
**Pour:** Conformité, scalabilité, multi-stakeholders

**Skills utilisés:**
- BA (Feasibility + Change Management)
- PRD (complet + compliance)
- Architecture (complet + monitoring)
- Stories (Epics + Stories + Spikes)
- QA (Test Plan complet + Performance)

---

## 🛠️ Personnalisation

### Adapter à Votre Contexte

Chaque skill contient des sections "Exemples GESA" qui sont optionnelles. Vous pouvez :

1. **Les ignorer** - Skills fonctionnent de manière générique
2. **Les remplacer** - Mettre vos propres exemples
3. **Les enrichir** - Ajouter vos cas d'usage

**Exemple de personnalisation:**

```markdown
# Dans prd/SKILL.md

## Exemples [VOTRE-ENTREPRISE]

### Exemple 1: [Votre projet]
**Vision:** [Description]
**Success Metric:** [KPI]
**Must Have:** [Features]
```

---

## 📝 Templates Disponibles

Chaque skill inclut des templates prêts à l'emploi :

### BA Templates
- Quick Analysis (1 paragraphe)
- Brainstorming Session Results
- Business Case (ROI complet)
- Process Map BPMN
- Feasibility Study
- Change Management Plan

### PRD Templates
- PRD Quick (3 pages)
- PRD Complet (5-8 pages)
- User Story format

### Architecture Templates
- ADR (Architecture Decision Record)
- System Diagram
- Deployment Plan
- Tech Stack Documentation

### Stories Templates
- Epic Template
- User Story Template
- Sprint Planning Template
- Backlog Structure

### QA Templates
- Test Plan
- Test Case
- Bug Report
- UAT Script
- Regression Suite

---

## 🔧 Maintenance

### Mise à Jour des Skills

**Si installation locale:**
```bash
cd bmad-skills
git pull origin main
xcopy /E /I /Y skills "%USERPROFILE%\.claude\skills"
```

**Si submodule:**
```bash
cd votre-projet
git submodule update --remote --merge
```

---

## 🤝 Contribution

Les contributions sont bienvenues !

1. **Fork** le repo
2. **Créer une branche** (`git checkout -b feature/amelioration-ba`)
3. **Commit** (`git commit -m 'Ajout template X au skill BA'`)
4. **Push** (`git push origin feature/amelioration-ba`)
5. **Pull Request**

**Guidelines:**
- Templates doivent rester génériques (pas de data client)
- Exemples anonymisés si basés sur cas réel
- Markdown formaté correctement
- Tester avec Claude Code avant PR

---

## 📄 License

MIT License

Copyright (c) 2026 [Votre Nom]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## 🙏 Remerciements

Inspiré par [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) - Breakthrough Method for Agile AI-Driven Development.

---

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/[votre-username]/bmad-skills/issues)
- **Discussions:** [GitHub Discussions](https://github.com/[votre-username]/bmad-skills/discussions)

---

## 🗺️ Roadmap

- [ ] Skill Deployment (CD/CI pipelines)
- [ ] Skill Monitoring (métriques projet)
- [ ] Skill Retrospective (lessons learned)
- [ ] Templates visuels (Mermaid diagrams)
- [ ] Intégration Jira/M-Files/SharePoint
- [ ] Skill Creator (méta-skill pour créer skills)

---

**Version:** 1.0.0  
**Dernière mise à jour:** 2026-02-09
