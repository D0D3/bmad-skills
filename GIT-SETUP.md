# BMAD Skills - Structure du Repository Git

## Structure Recommandée

```
bmad-skills/
├── .git/
├── .gitignore
├── README.md
├── README-fr.md
├── LICENSE
├── GIT-SETUP.md
├── Install-BMADSkills.ps1          # Script installation Windows
├── install-bmad-skills.sh          # Script installation Linux/Mac
└── skills/
    ├── ba/
    │   └── SKILL.md               # Business Analysis
    ├── prd/
    │   └── SKILL.md               # Product Requirements Document
    ├── architecture/
    │   └── SKILL.md               # Architecture technique (stack open-source)
    ├── dba/
    │   └── SKILL.md               # Database Administrator (PostgreSQL)
    ├── uiux/
    │   └── SKILL.md               # UI/UX Design (design system, accessibilité)
    ├── stories/
    │   └── SKILL.md               # Epics & User Stories (avec alignement doc)
    └── qa/
        └── SKILL.md               # QA & Testing (agents autonomes, CI/CD)
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
mkdir -p skills/{ba,prd,architecture,dba,uiux,stories,qa}
```

### 2. Copier les fichiers

Copier les 7 fichiers SKILL.md :
- `skills/ba/SKILL.md`           → Business Analysis
- `skills/prd/SKILL.md`          → Product Requirements Document
- `skills/architecture/SKILL.md` → Architecture technique (stack open-source)
- `skills/dba/SKILL.md`          → Database Administrator (PostgreSQL)
- `skills/uiux/SKILL.md`         → UI/UX Design (design system, accessibilité)
- `skills/stories/SKILL.md`      → Epics & User Stories
- `skills/qa/SKILL.md`           → QA & Testing (agents autonomes, CI/CD)

Copier aussi à la racine :
- `README.md` et `README-fr.md`
- `Install-BMADSkills.ps1` et `install-bmad-skills.sh`
- `LICENSE`, `GIT-SETUP.md`, `.gitignore`

### 3. Premier commit

```bash
# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit: BMAD Skills v2.0.0

- BA skill (Business Analysis multi-casquette)
- PRD skill (Product Requirements Document)
- Architecture skill (stack open-source, ADRs, sécurité OWASP)
- DBA skill (PostgreSQL, migrations Alembic, backup, sécurité DB)
- UI/UX skill (design system, accessibilité WCAG 2.1, Storybook)
- Stories skill (Epics, User Stories, alignement documentation)
- QA skill (agents autonomes, CI/CD, rapports, tests E2E)
- Stack 100% open-source (FastAPI, PostgreSQL, Authentik, Docker)
- Scripts installation Linux/Mac + Windows"
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
git tag -a v2.0.0 -m "Release v2.0.0: BMAD Skills open-source stack

Skills inclus (7 au total):
- BA (Business Analysis)
- PRD (Product Requirements Document)
- Architecture (stack open-source: FastAPI, PostgreSQL, Authentik, Docker)
- DBA (PostgreSQL best practices, migrations, backup)
- UI/UX (design system Tailwind/shadcn, WCAG 2.1, Storybook)
- Stories (Epics & User Stories, alignement documentation IT + user)
- QA (agents autonomes, CI/CD pipeline, rapports automatiques)

Breaking change: Suppression de toutes les références propriétaires
(M-Files, SharePoint, VBScript, Azure AD, PowerApps)"

# Push tag
git push origin v2.0.0
```

**Ou via GitHub CLI:**
```bash
gh release create v2.0.0 \
  --title "BMAD Skills v2.0.0 - Open-Source Stack" \
  --notes "7 skills, 100% open-source, self-hosted. New: DBA + UI/UX agents."
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
          for skill in ba prd architecture dba uiux stories qa; do
            if [ ! -f "skills/$skill/SKILL.md" ]; then
              echo "Missing skill: $skill"
              exit 1
            fi
          done
          echo "All 7 skills present"
      
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
