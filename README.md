# BMAD Skills - Business Agile Development
[Version en français](READ-fr.md)

Professional skills for Claude Code inspired by the BMAD methodology (Breakthrough Method for Agile AI-Driven Development).

## 📚 Available Skills

### 1. BA - Business Analysis
**File:** `ba/SKILL.md`

Multi-faceted business analysis with 3 adaptable levels:
- **Quick Flow** (<5min): Problem statement, Go/No-Go
- **BMad Method** (<15min): Brainstorming, Business Case, Process Mapping
- **Enterprise** (<30min): Feasibility Study, Change Management

**Techniques:**
- Role Playing (3 personas)
- Five Whys (root cause)
- Analogical Thinking
- Interviews, Workshops, Surveys

**Deliverables:**
- Brainstorming Session Results
- Business Case (ROI)
- Process Maps BPMN (AS-IS/TO-BE)
- Feasibility Study
- Change Management Plan

---

### 2. PRD - Product Requirements Document
**File:** `prd/SKILL.md`

Structured product requirements documentation.

**Contents:**
- Vision & Objectives
- Personas & Users
- User Stories (INVEST format)
- Functional/Technical Requirements
- Constraints & Risks
- Success Metrics

**Templates:**
- Quick PRD (3 pages)
- Complete PRD (5-8 pages)
- Design Sprint validation

---

### 3. Architecture
**File:** `architecture/SKILL.md`

Technical design and architectural decisions.

**Includes:**
- ADR (Architecture Decision Records)
- C4 Model Diagrams
- Security & Compliance
- Scalability & Performance
- Deployment Plan
- Monitoring & Logging

**Tools:**
- BPMN for workflows
- System diagrams
- Tech stack documentation

---

### 4. Stories - Epics & User Stories
**File:** `stories/SKILL.md`

Agile decomposition into Epics and User Stories.

**Format:**
- INVEST User Stories
- Acceptance Criteria
- Definition of Done
- Story Points (Fibonacci)
- MoSCoW Prioritization

**Management:**
- Sprint Planning
- Backlog Refinement
- Epic Decomposition
- Velocity Tracking

---

### 5. QA - Quality Assurance
**File:** `qa/SKILL.md`

Test strategies and quality validation.

**Test Pyramid:**
- Unit Tests (50%)
- Functional Tests (30%)
- Integration Tests (15%)
- UAT (5%)

**Includes:**
- Test Plans
- Test Cases
- Bug Tracking
- Regression Testing
- Performance Testing
- Phased deployment (pilot → production)

---

## 🚀 Installation

### Option 1: Local Installation (Claude Code)

1. **Clone the repo:**
```bash
git clone https://github.com/D0D3/bmad-skills.git
cd bmad-skills
```

2. **Copy to Claude Code:**
```bash
# Windows
xcopy /E /I skills "%USERPROFILE%\.claude\skills"

# Linux/Mac
cp -r skills/* ~/.claude/skills/
```

3. **Verify installation:**
```bash
# In Claude Code
skills
```

You should see:
- ba
- prd
- architecture
- stories
- qa

---

### Option 2: Git Submodule Installation (Project Specific)

If you want to use these skills in a specific project:

```bash
cd your-project

# Add as submodule
git submodule add https://github.com/D0D3/bmad-skills.git .claude/skills

# Initialize
git submodule update --init --recursive
```

**Update skills:**
```bash
cd your-project
git submodule update --remote --merge
```

---

### Option 3: Direct Installation (without Git)

1. **Download ZIP:**
   - GitHub → Code → Download ZIP
   - Extract

2. **Copy manually:**
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

3. **Restart Claude Code**

---

## 📖 Usage

### Direct Call (if supported)
```bash
/ba
/prd
/architecture
/stories
/qa
```

### Natural Language (recommended)
```
"use the BA skill to analyze this opportunity"
"create a PRD using the prd skill"
"apply the architecture skill to document decisions"
"decompose into stories using the stories skill"
"create a test plan with the qa skill"
```

### Automatic Detection
Claude automatically detects the relevant skill based on your request:
```
"I want to create a business case for [project]"
→ Claude automatically loads the BA skill

"what are the user stories for this feature?"
→ Claude automatically loads the stories skill
```

---

## 🔄 Complete BMAD Workflow

```
1. BA (Business Analysis)
   ↓
   → Brainstorming Session
   → Business Case (ROI)
   → Process Mapping (if workflow)
   → Feasibility Study (if Enterprise)
   ↓
2. PRD (Product Requirements)
   ↓
   → Vision & Objectives
   → High-level User Stories
   → Success Metrics
   ↓
3. Architecture
   ↓
   → ADR (technical decisions)
   → System diagrams
   → Security & Deployment
   ↓
4. Stories (Epics & User Stories)
   ↓
   → Story decomposition
   → Estimation (Story Points)
   → Sprint Planning
   ↓
5. QA (Quality Assurance)
   ↓
   → Test Plan
   → Test Cases
   → UAT
   → Deployment
```

---

## 🎯 Planning Tracks

### Quick Flow
**Duration:** <5min  
**For:** Bug fix, small feature, clear scope

**Skills used:**
- BA (Quick Analysis only)
- PRD (optional, short version)
- Stories (1-2 stories max)

---

### BMad Method
**Duration:** <15min  
**For:** New product, platform, moderate scope

**Skills used:**
- BA (Brainstorming + Business Case)
- PRD (complete)
- Architecture (essential ADRs)
- Stories (Epics + decomposed Stories)
- QA (standard Test Plan)

---

### Enterprise
**Duration:** <30min  
**For:** Compliance, scalability, multi-stakeholders

**Skills used:**
- BA (Feasibility + Change Management)
- PRD (complete + compliance)
- Architecture (complete + monitoring)
- Stories (Epics + Stories + Spikes)
- QA (complete Test Plan + Performance)

---

## 🛠️ Customization

### Adapt to Your Context

Each skill contains generic examples. You can:

1. **Use as-is** - Skills work generically
2. **Customize** - Add your own company examples
3. **Enrich** - Add your specific use cases

**Customization example:**

```markdown
# In prd/SKILL.md

## Examples [YOUR-COMPANY]

### Example 1: [Your project]
**Vision:** [Description]
**Success Metric:** [KPI]
**Must Have:** [Features]
```

---

## 📝 Available Templates

Each skill includes ready-to-use templates:

### BA Templates
- Quick Analysis (1 paragraph)
- Brainstorming Session Results
- Business Case (complete ROI)
- BPMN Process Map
- Feasibility Study
- Change Management Plan

### PRD Templates
- Quick PRD (3 pages)
- Complete PRD (5-8 pages)
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

### Updating Skills

**If local installation:**
```bash
cd bmad-skills
git pull origin main
xcopy /E /I /Y skills "%USERPROFILE%\.claude\skills"
```

**If submodule:**
```bash
cd your-project
git submodule update --remote --merge
```

---

## 🤝 Contributing

Contributions are welcome!

1. **Fork** the repo
2. **Create a branch** (`git checkout -b feature/improve-ba`)
3. **Commit** (`git commit -m 'Add template X to BA skill'`)
4. **Push** (`git push origin feature/improve-ba`)
5. **Pull Request**

**Guidelines:**
- Templates must remain generic (no confidential data)
- Examples anonymized if based on real cases
- Properly formatted Markdown
- Test with Claude Code before PR

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

Inspired by [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) - Breakthrough Method for Agile AI-Driven Development.

---

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/D0D3/bmad-skills/issues)
- **Discussions:** [GitHub Discussions](https://github.com/D0D3/bmad-skills/discussions)

---

## 🗺️ Roadmap

- [ ] Skill Deployment (CD/CI pipelines)
- [ ] Skill Monitoring (project metrics)
- [ ] Skill Retrospective (lessons learned)
- [ ] Visual templates (Mermaid diagrams)
- [ ] Integrations (Jira, Azure DevOps, etc.)
- [ ] Skill Creator (meta-skill to create skills)

---

**Version:** 1.0.0  
**Last updated:** 2026-02-10
