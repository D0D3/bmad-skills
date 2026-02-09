# QA - Quality Assurance & Testing

## Description
Stratégies de test pour applications métier. Couvre tests manuels, automatisés, UAT, et validation déploiement N postes.

## Quand utiliser
- Avant mise en production
- Validation user story 
- Regression testing après updates
- Pilote avant rollout massif
- Post-deployment validation

## Pyramide de Tests Entreprise

```
        ┌──────────┐
        │   UAT    │ (5% - Manuel)
        │  Users   │
        └──────────┘
       ┌────────────┐
       │ Integration│ (15% - Semi-auto)
       │   Tests    │
       └────────────┘
      ┌──────────────┐
      │  Functional  │ (30% - Automatisable)
      │    Tests     │
      └──────────────┘
     ┌────────────────┐
     │  Unit/Script   │ (50% - Automatisé)
     │     Tests      │
     └────────────────┘
```

## Types de Tests

### 1. Unit Tests (Scripts/Code)
**Pour:** PowerShell, VBScript, JavaScript

```powershell
# Exemple Pester (PowerShell)
Describe "Get-ADUserInfo" {
    It "Returns user when valid SamAccountName" {
        $result = Get-ADUserInfo -Sam "jdupont"
        $result.DisplayName | Should -Not -BeNullOrEmpty
    }
    
    It "Throws error when user not found" {
        { Get-ADUserInfo -Sam "invalid" } | Should -Throw
    }
}
```

### 2. Functional Tests (Features)
**Pour:** M-Files workflows, SharePoint forms

**Test Case Template:**
```markdown
### TC-001: M-Files Document Approval Workflow

**Preconditions:**
- User "jdupont" has "Approver" role
- Document in "Pending Approval" state

**Steps:**
1. Login as "jdupont"
2. Open document ID 12345
3. Click "Approve" button
4. Enter comment: "Approved for deployment"
5. Submit

**Expected Results:**
- Document state changes to "Approved"
- Email notification sent to document owner
- Audit log entry created
- Next workflow step triggered

**Actual Results:** [Tester fills]
**Status:** Pass / Fail / Blocked
**Bugs:** [Reference bug IDs]
```

### 3. Integration Tests
**Pour:** API calls, system-to-system

```markdown
### INT-001: M-Files → SharePoint Sync

**Systems:** M-Files Vault ↔ SharePoint List

**Test:**
1. Create M-Files object (Class: Invoice)
2. Wait 30sec (webhook trigger)
3. Verify SharePoint list item created
4. Verify all metadata mapped correctly

**Expected:**
- SharePoint item ID matches M-Files ObjID
- Invoice Number, Date, Amount synced
- Created timestamp <1min delay

**Validation Queries:**
- M-Files: `SELECT * FROM ObjectVersions WHERE ID = X`
- SharePoint: REST API GET /sites/.../lists/.../items/X
```

### 4. UAT (User Acceptance Testing)
**Pour:** Validation finale métier

**UAT Script Template:**
```markdown
## UAT Session: M-Files Mobile Access

**Date:** YYYY-MM-DD | **Testers:** [Liste 5 users pilotes]

**Scenario 1: Login from Mobile**
- [ ] Open M-Files app on smartphone
- [ ] Enter credentials + 2FA code
- [ ] Access personal documents
- [ ] **Success Criteria:** Login <10sec, documents visible

**Scenario 2: Document Search**
- [ ] Search "Invoice 2024"
- [ ] Filter by date range
- [ ] Sort by amount descending
- [ ] **Success Criteria:** Results accurate, <5sec response

**Feedback:**
- Positive: [User comments]
- Issues: [Problems encountered]
- Suggestions: [Improvements]

**Decision:** ✅ Go-Live / ⚠️ Fix Issues / ❌ Abort
```

## Test Plan Template

```markdown
# Test Plan: [Projet Name]

**Version:** 1.0 | **Owner:** DoD | **Sprint:** [Number]

## 1. Scope
**In Scope:**
- User stories: US-001, US-002, US-003
- Features: [Liste]
- Systems: M-Files, SharePoint, PowerShell scripts

**Out of Scope:**
- Legacy Oracle system (no changes)
- Network infrastructure tests

## 2. Test Approach

| Test Type | Coverage | Tool | Responsible |
|-----------|----------|------|-------------|
| Unit | PowerShell scripts | Pester | DoD |
| Functional | M-Files workflows | Manual checklist | DoD + Administrateur IT |
| Integration | M-Files ↔ SP | Postman + Manual | DoD |
| UAT | End-to-end scenarios | User scripts | 5 pilotes |

## 3. Test Cases
### High Priority
- [ ] TC-001: [Titre] (Linked to US-001)
- [ ] TC-002: [Titre] (Linked to US-002)

### Medium Priority
- [ ] TC-003: [Titre]

## 4. Test Data
- **Users:** Test accounts (test.user1@exemple.local, etc.)
- **Documents:** Sample invoices, contracts
- **Environment:** Staging VM (isolated from prod)

## 5. Entry/Exit Criteria
**Entry:**
- [ ] All user stories coded & dev-tested
- [ ] Staging environment ready
- [ ] Test data prepared

**Exit:**
- [ ] 100% high-priority tests passed
- [ ] 0 critical bugs open
- [ ] UAT sign-off from 3/5 pilotes

## 6. Risks
- Limited staging environment (1 VM)
- UAT users availability
- Mitigation: Schedule UAT 1 week in advance

## 7. Schedule
- Unit tests: Daily during dev
- Functional tests: Sprint day 8-9
- Integration tests: Sprint day 10
- UAT: Sprint day 11-12
- Go/No-Go: Sprint day 13
```

## Stratégies par Technologie

### M-Files Testing
```markdown
**Workflow Tests:**
1. State transitions (Manual → Approved → Archived)
2. Permissions per state
3. Automatic metadata calculations
4. Email notifications
5. VBScript error handling

**Tools:**
- M-Files Admin: Event Log monitoring
- SQL Query: Database validation
- Manual: UI click-through
```

### SharePoint Testing
```markdown
**List/Library Tests:**
1. Column validation rules
2. JSON formatting rendering
3. Calculated columns accuracy
4. Permissions inheritance
5. Power Automate triggers

**Tools:**
- Browser DevTools (F12) for JSON
- SharePoint Designer (workflows)
- Postman (REST API)
```

### PowerShell Testing
```markdown
**Script Tests:**
1. Parameter validation
2. Error handling (try/catch)
3. Logging output
4. Idempotency (re-run safe)
5. Performance (<5sec for simple scripts)

**Framework:** Pester
```powershell
# Install Pester
Install-Module -Name Pester -Force

# Run tests
Invoke-Pester -Path ./tests/ -Output Detailed
```
```

## Déploiement N Postes

### Phase 1: Dev Testing 
- Unit tests + functional tests
- Staging VM validation
- **Duration:** Sprint days 1-7

### Phase 2: Pilote (5 Users)
- UAT scenarios
- Real-world usage 1 week
- Feedback collection
- **Duration:** 1 week post-sprint

### Phase 3: Phased Rollout
```markdown
**Week 1:** Département IT (10 users)
- Monitor logs daily
- Fix critical bugs

**Week 2:** Département Admin (30 users)
- Validate scaling
- Adjust configs

**Week 3-4:** Remaining users
- Batch deployments (50/week)
- Support tickets tracking

**Rollback Trigger:**
- >10% users report same critical bug
- System downtime >1 hour
- Security incident
```

## Bug Tracking

### Bug Template
```markdown
## BUG-[ID]: [Titre Court]

**Severity:** Critical / High / Medium / Low
**Priority:** P0 (hotfix) / P1 (this sprint) / P2 (next sprint) / P3 (backlog)
**Status:** Open / In Progress / Fixed / Verified / Closed

**Environment:**
- System: M-Files / SharePoint / PowerShell
- Version: [Specific version]
- OS: Windows 10/11
- User: [SamAccountName if relevant]

**Steps to Reproduce:**
1. Step 1
2. Step 2
3. Step 3

**Expected Behavior:** [What should happen]
**Actual Behavior:** [What happens instead]

**Screenshots/Logs:** [Attach]

**Impact:**
- Users affected: [Number or %]
- Workaround available: Yes/No
- Business impact: [Description]

**Root Cause:** [Analysis after fix]
**Fix:** [Solution implemented]
**Verification:** [How was fix tested]
```

### Severity Definitions

| Severity | Definition | Example Entreprise | SLA |
|----------|------------|--------------|-----|
| Critical | System down, data loss | M-Files vault inaccessible | 4h |
| High | Major feature broken | Workflow approval stuck | 1 day |
| Medium | Minor feature issue | Search filter not working | 1 week |
| Low | Cosmetic, typo | Button label typo | Backlog |

## Regression Testing

**Trigger:** Any production deployment

**Regression Suite:**
```markdown
### Critical Path Tests (Run every deployment)
- [ ] Login (AD + Azure 2FA)
- [ ] Document upload M-Files
- [ ] Workflow approval cycle
- [ ] SharePoint list CRUD operations
- [ ] PowerShell automation jobs (scheduled tasks)

**Automation:** PowerShell scripts + Selenium (si budget)
**Frequency:** Pre-deployment (always)
```

## Performance Testing

### Load Testing (si applicable)
```markdown
**Scenario:** N users login simultaneously (morning peak)

**Metrics:**
- Login time: <10sec (target: 5sec)
- Document search: <3sec
- Workflow submit: <2sec
- SharePoint page load: <4sec

**Tools:**
- M-Files Admin: Performance counters
- SQL Server: Query execution plans
- Browser: Network tab timing
```

## Checklist DoD (Definition of Done)

- [ ] **Code Quality:**
  - [ ] All unit tests pass
  - [ ] No critical static analysis warnings
  - [ ] Code reviewed by Administrateur IT (if infra impact)

- [ ] **Functional:**
  - [ ] All acceptance criteria met
  - [ ] Functional test cases pass
  - [ ] Integration tests pass (if multi-system)

- [ ] **UAT:**
  - [ ] 3/5 pilote users approve
  - [ ] No critical bugs open
  - [ ] User documentation updated

- [ ] **Deployment Ready:**
  - [ ] Staging validated
  - [ ] Rollback plan documented
  - [ ] Monitoring/alerts configured

## Bonnes Pratiques Entreprise
1. **Test Early, Test Often:** Ne pas attendre fin de sprint
2. **Automate Repetitive:** Pester for PowerShell, scripts for regressions
3. **Pilote Before Blast:** ALWAYS test 5 users avant rollout complet
4. **Document Bugs:** Template standardisé, tracking M-Files
5. **UAT is Sacred:** Ne jamais skip UAT pour gagner du temps

## Anti-Patterns
- ❌ "Works on my machine" sans staging test
- ❌ Skip pilote, deploy direct N users (disaster risk)
- ❌ Manual tests sans documentation (non-repeatable)
- ❌ Bugs without severity/priority (confusion)
- ❌ "Testing in production" (no staging env)

## Outils Entreprise

**Gratuits:**
- Pester (PowerShell testing)
- Browser DevTools (F12)
- M-Files Admin (built-in)
- SharePoint Designer (workflows)
- Git (version control scripts)

**Payants (si budget):**
- Selenium (browser automation)
- Postman (API testing)
- TestRail (test management)

## Métriques Qualité

- **Test Coverage:** % user stories avec test cases
- **Defect Density:** Bugs / story points
- **Pass Rate:** % tests passed / total
- **Escaped Defects:** Bugs found in prod (target: <5%)
- **UAT Satisfaction:** Feedback pilotes (target: >80% positive)

## Workflow QA Recommandé
1. **Dev Complete** → Unit tests 
2. **Code Review** → Functional tests (DoD + Administrateur IT)
3. **Deploy Staging** → Integration tests 
4. **UAT Prep** → Create user scripts, recruit 5 pilotes
5. **UAT Execution** → 1 week real usage
6. **UAT Review** → Feedback analysis, bug fixes
7. **Go/No-Go Decision** → Chef de projet + DoD
8. **Phased Rollout** → Monitor logs, support users
9. **Post-Deployment** → Regression suite, metrics tracking
