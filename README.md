# BMAD Skills for Claude Code

A professional skill library for Claude Code implementing the **BMAD (Breakthrough Method for Agile AI-Driven Development)** methodology.

This version focuses on **open-source, self-hosted, vendor-agnostic technologies** — no proprietary software dependencies.

## Skills Available

| Skill | Command | Description |
|-------|---------|-------------|
| Business Analysis | `/ba` | Discovery, brainstorming, business cases, feasibility studies |
| Product Requirements | `/prd` | PRD creation, user stories, personas, success metrics |
| Architecture | `/architecture` | Technical design, open-source stack, ADRs, security |
| Database Admin | `/dba` | PostgreSQL best practices, schema design, migrations, backup |
| UI/UX Design | `/uiux` | Design system, accessibility (WCAG 2.1), components, user docs |
| Epics & Stories | `/stories` | Story decomposition, sprint planning, documentation alignment |
| Quality Assurance | `/qa` | Test strategy, autonomous QA agents, CI/CD pipeline, reports |

## Technology Stack

All skills are designed around a **modern, open-source, self-hosted stack**:

**Frontend:** React 18 + TypeScript + Tailwind CSS + shadcn/ui + Vite + Storybook

**Backend:** FastAPI (Python 3.11+) + PostgreSQL 16 + Redis + Celery

**Auth:** Authentik (self-hosted SSO/OIDC/2FA)

**Infrastructure:** Docker + Docker Compose + Traefik v3 (SSL auto)

**Testing:** Pytest + Testcontainers + Playwright + k6

**Monitoring:** Prometheus + Grafana + Loki + Uptime Kuma

**Documentation:** MkDocs Material (IT) + Storybook (components) + OpenAPI (API)

## BMAD Workflow

```
1. /ba       → Discovery, business case, feasibility
      ↓
2. /prd      → Requirements, user stories, personas
   ↓   ↓
  /dba  /uiux  ← Consult early (schema, design system)
      ↓
3. /architecture → ADRs, system design, security
      ↓
4. /stories  → Epics, sprint planning, doc alignment
      ↓
5. /qa       → Test strategy, CI/CD, UAT, reports
```

## Complexity Levels

- **Quick Flow** (<5 min): Bug fix, clear scope
- **BMad Method** (<15 min): New feature, moderate scope
- **Enterprise** (<30 min): Multi-stakeholder, compliance, high criticality

## Installation

### Option 1: Script automatique

**Linux/macOS:**
```bash
chmod +x install-bmad-skills.sh
./install-bmad-skills.sh
```

**Windows:**
```powershell
.\Install-BMADSkills.ps1
```

### Option 2: Git Submodule (per-project)
```bash
git submodule add https://github.com/YOUR_ORG/bmad-skills.git .claude/skills
```

### Option 3: Copie manuelle
```bash
cp -r skills/* ~/.claude/skills/
```

## Agent Collaboration

Agents can interrogate each other:

```
/architecture → "Consult /dba for schema conventions"
/prd          → "Consult /uiux for interface requirements"
/stories      → "Consult /dba if DB schema modified"
/qa           → "Consult /dba for slow query optimization"
```

## Documentation Philosophy

Every delivered user story must include:
- **Technical docs** (IT): API docs, ADRs, runbooks (MkDocs Material)
- **User docs**: Guides with annotated screenshots, use cases, FAQ

## License

MIT License — See LICENSE file.
