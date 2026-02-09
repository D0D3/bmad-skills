# BMAD Skills - Structure du Repository Git

## Structure Recommandée

```
bmad-skills/
├── .git/
├── .gitignore
├── README.md
├── LICENSE
├── Install-BMADSkills.ps1          # Script installation Windows
├── install-bmad-skills.sh          # Script installation Linux/Mac
├── skills/
│   ├── ba/
│   │   └── SKILL.md
│   ├── prd/
│   │   └── SKILL.md
│   ├── architecture/
│   │   └── SKILL.md
│   ├── stories/
│   │   └── SKILL.md
│   └── qa/
│       └── SKILL.md
├── examples/                       # Optionnel: Exemples d'usage
│   ├── sample-business-case.md
│   ├── sample-prd.md
│   ├── sample-architecture.md
│   ├── sample-epic.md
│   └── sample-test-plan.md
└── docs/                          # Optionnel: Documentation additionnelle
    ├── quick-start.md
    ├── workflows.md
    └── customization.md
```

---

## Initialisation du Repository

### 1. Créer le repo local

```bash
# Créer le répertoire
mkdir bmad-skills
cd bmad-skills

# Initialiser Git
git init

# Créer la structure
mkdir -p skills/{ba,prd,architecture,stories,qa}
mkdir -p examples docs
```

### 2. Copier les fichiers

Copier les 5 fichiers SKILL.md que je t'ai créés:
- `ba-SKILL.md` → `skills/ba/SKILL.md`
- `prd-SKILL.md` → `skills/prd/SKILL.md`
- `architecture-SKILL.md` → `skills/architecture/SKILL.md`
- `stories-SKILL.md` → `skills/stories/SKILL.md`
- `qa-SKILL.md` → `skills/qa/SKILL.md`

Copier aussi:
- `README.md` → racine
- `Install-BMADSkills.ps1` → racine

### 3. Premier commit

```bash
# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit: BMAD Skills v1.0.0

- BA skill (Business Analysis multi-casquette)
- PRD skill (Product Requirements Document)
- Architecture skill (ADRs, diagrammes, sécurité)
- Stories skill (Epics, User Stories, Sprint Planning)
- QA skill (Test Plans, UAT, Déploiement)
- Installation scripts (PowerShell)
- Documentation complète"
```

---

## Publication sur GitHub

### Option A: Via GitHub CLI (recommandé)

```bash
# Installer GitHub CLI si pas déjà fait
# https://cli.github.com/

# Login GitHub
gh auth login

# Créer le repo distant et push
gh repo create bmad-skills --public --source=. --remote=origin --push

# Ou pour repo privé
gh repo create bmad-skills --private --source=. --remote=origin --push
```

### Option B: Via GitHub Web UI

1. **Aller sur GitHub.com** → New Repository
2. **Nom:** `bmad-skills`
3. **Description:** "Professional BMAD Skills for Claude Code - Business Analysis, PRD, Architecture, Stories, QA"
4. **Visibilité:** Public ou Private
5. **Ne pas initialiser** (pas de README/gitignore/license)
6. **Créer**

Puis dans votre terminal:
```bash
git remote add origin https://github.com/[votre-username]/bmad-skills.git
git branch -M main
git push -u origin main
```

---

## Tags & Releases

### Créer une release v1.0.0

```bash
# Tag local
git tag -a v1.0.0 -m "Release v1.0.0: Initial BMAD Skills

Skills inclus:
- BA (Business Analysis)
- PRD (Product Requirements)
- Architecture
- Stories (Epics & User Stories)
- QA (Quality Assurance)

Workflow complet BA → PRD → Architecture → Stories → QA"

# Push tag
git push origin v1.0.0
```

**Ou via GitHub CLI:**
```bash
gh release create v1.0.0 \
  --title "BMAD Skills v1.0.0" \
  --notes "Initial release with 5 core skills: BA, PRD, Architecture, Stories, QA"
```

---

## Installation pour Users

Une fois publié, les users peuvent installer via:

### Option 1: Clone direct
```bash
git clone https://github.com/[votre-username]/bmad-skills.git
cd bmad-skills
.\Install-BMADSkills.ps1
```

### Option 2: Download ZIP
1. GitHub → Code → Download ZIP
2. Extraire
3. Exécuter `Install-BMADSkills.ps1`

### Option 3: Git Submodule (projet-specific)
```bash
cd mon-projet
git submodule add https://github.com/[votre-username]/bmad-skills.git .claude/skills
git submodule update --init --recursive
```

---

## Workflow Maintenance

### Ajouter un nouveau skill

```bash
# Créer branche
git checkout -b feature/nouveau-skill

# Créer le skill
mkdir skills/nouveau-skill
# Éditer skills/nouveau-skill/SKILL.md

# Mettre à jour README.md (section skills)
# Mettre à jour Install-BMADSkills.ps1 (RequiredSkills array)

# Commit
git add .
git commit -m "Add nouveau-skill: [description]"

# Push & Pull Request
git push origin feature/nouveau-skill
gh pr create --title "Add nouveau-skill" --body "Description du nouveau skill"
```

### Mise à jour d'un skill existant

```bash
# Créer branche
git checkout -b fix/improve-ba-skill

# Modifier skills/ba/SKILL.md

# Commit
git commit -am "Improve BA skill: Add SWOT analysis template"

# Push & PR
git push origin fix/improve-ba-skill
gh pr create
```

### Nouvelle version release

```bash
# Merge toutes les PRs voulues dans main
git checkout main
git pull

# Bump version
# Éditer README.md: Version: 1.1.0

# Commit
git commit -am "Bump version to 1.1.0"

# Tag
git tag -a v1.1.0 -m "Release v1.1.0

New features:
- Amélioration BA skill: SWOT analysis
- Fix PRD template: Better MoSCoW section
- Architecture: Add monitoring guidelines"

# Push
git push origin main
git push origin v1.1.0

# Create GitHub release
gh release create v1.1.0 --title "v1.1.0" --notes "..."
```

---

## Collaboration

### Pour contributeurs externes

**Fork → Branch → PR workflow:**

1. **Fork** le repo sur GitHub UI
2. **Clone** votre fork:
   ```bash
   git clone https://github.com/[leur-username]/bmad-skills.git
   cd bmad-skills
   ```
3. **Créer branche:**
   ```bash
   git checkout -b feature/ma-contribution
   ```
4. **Faire changements & commit:**
   ```bash
   git add .
   git commit -m "Description"
   git push origin feature/ma-contribution
   ```
5. **Pull Request** sur GitHub UI

**Reviewer merge:**
```bash
# Via GitHub UI: Merge Pull Request
# Ou via CLI:
gh pr merge [PR-number] --squash
```

---

## .github Workflows (Optionnel)

Si vous voulez automatiser validation:

**`.github/workflows/validate-skills.yml`:**
```yaml
name: Validate Skills

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Check required skills
        run: |
          for skill in ba prd architecture stories qa; do
            if [ ! -f "skills/$skill/SKILL.md" ]; then
              echo "❌ Missing skill: $skill"
              exit 1
            fi
          done
          echo "✅ All skills present"
      
      - name: Validate markdown
        uses: DavidAnson/markdownlint-action@v1
        with:
          files: '**/*.md'
```

---

## Tips Git

### Ignorer certains fichiers

Si vous créez des fichiers temporaires:
```bash
# .gitignore déjà fourni, mais vous pouvez ajouter:
echo "*.bak" >> .gitignore
echo ".DS_Store" >> .gitignore
git add .gitignore
git commit -m "Update gitignore"
```

### Synchroniser un fork

Si quelqu'un a forké votre repo et veut sync:
```bash
# Ajouter upstream (une fois)
git remote add upstream https://github.com/[original-owner]/bmad-skills.git

# Sync régulier
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

---

## Checklist Publication

- [ ] Structure de fichiers complète
- [ ] README.md à jour avec exemples
- [ ] LICENSE ajoutée (MIT recommandé)
- [ ] .gitignore configuré
- [ ] Scripts d'installation testés (Windows/Linux)
- [ ] Tous les skills validés (markdown correct)
- [ ] Premier commit avec message descriptif
- [ ] Repo GitHub créé (public/private)
- [ ] Push initial vers GitHub
- [ ] Tag v1.0.0 créé
- [ ] Release v1.0.0 publiée
- [ ] README contient lien installation correct
- [ ] Test installation depuis GitHub (clone fresh)

---

**Next Steps:**
1. Personnaliser README.md (remplacer `[votre-username]`)
2. Ajouter LICENSE (MIT recommandé)
3. Tester installation script localement
4. Push vers GitHub
5. Partager avec collègues ! 🚀
