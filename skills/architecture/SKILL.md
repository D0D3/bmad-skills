# Architecture - Conception Technique

## Description
Conception d'architectures techniques pour applications métier Entreprise. Couvre M-Files, SharePoint, PowerShell automation, et infrastructure Docker/Proxmox.

## Quand utiliser
- Après validation PRD
- Choix technologiques à documenter
- Intégration multi-systèmes
- Migration/refactoring infrastructure
- Documentation architecture existante

## Principes Entreprise

### 1. Contraintes Hard
- **N workstations** Windows 10/11
- **M-Files**: Vault unique, gRPC mandatory
- **SharePoint**: On-premise + Online hybride
- **Sécurité**: Azure 2FA, pas de credentials hardcodés
- **Réseau**: Traefik proxy pour WAN externe

### 2. Stack Approuvé
**Frontend:**
- SharePoint JSON formatting
- M-Files Web Access
- PowerApps (si budget)

**Backend:**
- M-Files Server (workflows VBScript)
- SharePoint Server / Online
- SQL Server (Oracle legacy)
- Docker containers (homelab only)

**Scripting:**
- PowerShell 5.1+ (AD, automation)
- VBScript (M-Files workflows)
- JavaScript (SharePoint customizations)

**Infrastructure:**
- Proxmox (homelab tests)
- Traefik (reverse proxy)
- Nginx Proxy Manager (alternative)

## Template Architecture

```markdown
# Architecture: [Nom Projet]

**PRD Ref:** [Lien vers PRD] | **Version:** 1.0 | **Architect:** Moi

## 1. Vue d'Ensemble
**Diagramme C4 Level 1:**
```
[User] → [Frontend] → [Backend] → [Database]
            ↓
      [Integration Layer]
```

**Composants principaux:**
- Frontend: [Tech]
- Backend: [Tech]
- Data: [Tech]
- Integration: [Tech]

## 2. Décisions Architecturales (ADR)

### ADR-001: [Titre décision]
- **Status:** Accepted / Proposed / Deprecated
- **Context:** Pourquoi cette décision ?
- **Decision:** Quoi ?
- **Consequences:** Trade-offs
- **Alternatives considérées:** [Liste]

**Exemple:**
### ADR-001: gRPC pour M-Files Mobile
- **Status:** Accepted
- **Context:** 40 users terrain besoin accès mobile
- **Decision:** Migration HTTPS→gRPC pour latence réduite
- **Consequences:** 
  - ✅ Latence -60%, offline mode
  - ⚠️ Nécessite port 6555 ouvert, Azure 2FA
- **Alternatives:** HTTPS (trop lent), VPN (complexe)

## 3. Diagrammes Techniques

### Architecture Système
```
┌─────────────────┐
│    N Clients    │
│  Windows 10/11  │
└────────┬────────┘
         │
    ┌────▼─────┐
    │ Traefik  │ (WAN)
    │  Proxy   │
    └────┬─────┘
         │
    ┌────▼──────────┐
    │  M-Files Srv  │──┐
    │  SharePoint   │  │
    └────┬──────────┘  │
         │             │
    ┌────▼─────┐  ┌───▼──────┐
    │ SQL/Ora  │  │  AD/AAD  │
    └──────────┘  └──────────┘
```

### Flux de Données
```
User Action → Validation → Workflow → Integration → Notification
```

## 4. Sécurité & Compliance
- **Authentification:** Azure AD 2FA
- **Autorisation:** AD Groups / M-Files Permissions
- **Encryption:** TLS 1.2+, no plaintext passwords
- **Audit:** M-Files Event Log + SharePoint Audit
- **Backup:** Quotidien (M-Files), hebdo (SharePoint)

## 5. Scalabilité & Performance
- **Load:** N users simultanés max
- **Response Time:** <2sec (LAN), <5sec (WAN)
- **Availability:** 99% uptime (hours: 07:00-18:00)
- **Data Volume:** [Estimer]

## 6. Déploiement

### Stratégie
- **Pilote:** 5-10 users (2 semaines)
- **Rollout:** Phased par département (4 semaines)
- **Rollback:** Backup config + VM snapshot

### Environnements
| Env | Purpose | Access |
|-----|---------|--------|
| Dev | Tests Moi | Homelab Proxmox |
| Staging | UAT | VM Entreprise interne |
| Prod | N users | Infra Entreprise |

## 7. Intégrations

### APIs & Webhooks
```markdown
M-Files ←→ SharePoint: REST API
M-Files ←→ Oracle: ODBC Connection
SharePoint ←→ Power Automate: Webhook triggers
```

### Data Flow
1. User submit form (SharePoint)
2. Power Automate trigger
3. Create M-Files object via API
4. Update Oracle legacy (si besoin)
5. Email notification

## 8. Monitoring & Logs
- **M-Files:** Event Log (erreurs workflows)
- **SharePoint:** ULS Logs + Audit
- **PowerShell:** Transcript logs
- **Alerts:** Email @Application Métier/Administrateur IT si critical

## 9. Tech Debt & Evolutions
- **Debt actuel:** [Lister]
- **Roadmap Q1:** [Priorités]
- **Roadmap Q2+:** [Nice-to-have]
```

## Diagrammes Recommandés

### 1. C4 Model (simpllifié)
```
Level 1: System Context (qui utilise quoi)
Level 2: Container (composants tech)
Level 3: Component (détails si complexe)
```

### 2. BPMN (workflows métier)
Utilise Camunda Modeler ou draw.io

### 3. Deployment Diagram
Montre serveurs, networks, firewalls

## Checklist Validation
- [ ] Décisions architecturales documentées (ADR)
- [ ] Diagrammes système + flux données
- [ ] Sécurité & compliance adressés
- [ ] Plan de déploiement (pilote → prod)
- [ ] Intégrations définies avec APIs
- [ ] Monitoring & logging configurés
- [ ] Tech debt identifié
- [ ] Review avec Administrateur IT (IT validation)

## Bonnes Pratiques Entreprise
1. **Keep it Simple:** Architecture minimale viable
2. **Document Decisions:** ADR pour toute décision majeure
3. **Test Early:** Homelab Proxmox pour POCs
4. **Versioning:** Git pour scripts/configs
5. **Rollback Plan:** Toujours

## Anti-Patterns
- ❌ Over-engineering (YAGNI)
- ❌ Architecture sans ADR (décisions oubliées)
- ❌ Pas de plan rollback
- ❌ Ignorer legacy (Oracle, VBScript)
- ❌ Pas de test pilote avant rollout complet

## Exemples Entreprise

### M-Files Phase 3 Mobility
```
ADR-001: gRPC migration
ADR-002: Traefik reverse proxy pour WAN
ADR-003: Azure 2FA mandatory
Déploiement: 5 users pilote → 40 users phased
Rollback: VM snapshot + HTTPS fallback
```

### SharePoint Gantt JSON
```
ADR-001: JSON column formatting vs Power BI
Decision: JSON (no licensing cost, instant refresh)
Consequences: Limited browser support (IE11 issue)
Mitigation: Browser detection + fallback view
```

## Outils
- **Diagrammes:** draw.io, Mermaid, PlantUML
- **BPMN:** Camunda Modeler
- **ADR:** Markdown files in Git
- **Docs:** M-Files (central repo)

## Workflow Recommandé
1. **PRD Review** (30min): Comprendre exigences
2. **Draft Architecture** (3h): Diagrammes + ADRs
3. **Technical Review Administrateur IT** (1h): Validation infra
4. **Refine** (1h): Ajustements post-review
5. **Finalize v1.0** (30min)
6. **Passage à Epics/Stories** → Utilise skill `stories`
