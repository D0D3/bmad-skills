# Architecture - Conception Technique

## Description
Conception d'architectures techniques pour applications métier. Stack open-source, auto-hébergé, sécurisé et facile à déployer. Propose des solutions viables sans dépendance à des logiciels propriétaires.

## Quand utiliser
- Après validation PRD
- Choix technologiques à documenter
- Intégration multi-systèmes
- Migration/refactoring infrastructure
- Documentation architecture existante
- Revue de sécurité

## Stack Recommandé (Open-Source, Auto-hébergé)

### Frontend
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| React 18 + TypeScript | Framework UI | Écosystème mature, typage fort, large communauté |
| Tailwind CSS + shadcn/ui | Composants UI | Design system cohérent, accessible, personnalisable |
| Vite | Build tool | Démarrage <1sec, HMR instantané |
| TanStack Query | Data fetching | Cache, loading states, revalidation automatique |
| React Hook Form + Zod | Formulaires | Validation type-safe côté client |
| Storybook | Doc composants | Documentation vivante, tests visuels isolés |

### Backend
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| FastAPI (Python 3.11+) | API REST/WebSocket | Performant, auto-doc OpenAPI, async natif |
| PostgreSQL 16 | Base de données principale | ACID, JSON support, scalable, open-source |
| Redis 7 | Cache / Sessions / Pub-Sub | <1ms latence, file de messages légère |
| Celery + Flower | Tâches asynchrones | Workers distribués, monitoring intégré |
| SQLAlchemy 2.0 + Alembic | ORM + migrations | Type-safe, migrations versionnées |

**Alternative Node.js (si équipe JS) :** Fastify + Prisma + BullMQ

### Authentification & Sécurité
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| Authentik | SSO/OIDC/2FA auto-hébergé | Open-source, zéro dépendance cloud |
| JWT (RS256) | Tokens API | Stateless, vérifiable, avec expiration |
| RBAC | Contrôle d'accès | Rôles granulaires par ressource |
| HTTPS/TLS 1.3 | Transport | Chiffrement bout-en-bout |
| Infisical / Vault | Secrets management | Zéro credential en dur |

### Infrastructure
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| Docker + Docker Compose | Conteneurisation | Reproductible, isolé, portable |
| Traefik v3 | Reverse proxy + SSL | SSL Let's Encrypt auto, routing, middlewares |
| GitHub Actions / GitLab CI | CI/CD | Pipeline tests → déploiement automatisé |
| Portainer CE | Gestion containers | Interface UI pour ops non-dev |

### Storage & Documents
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| MinIO | S3-compatible (fichiers/docs) | Auto-hébergeable, API S3 standard |
| PostgreSQL | Données structurées | Source unique de vérité |

### Monitoring & Observabilité
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| Prometheus + Grafana | Métriques + dashboards | Standard industrie, alertes configurables |
| Loki | Logs centralisés | Intégré Grafana, sans indexation lourde |
| Uptime Kuma | Monitoring endpoints | Simple, open-source, alertes multi-canaux |
| Sentry (optionnel) | Error tracking | Exceptions contextualisées avec stack trace |

### Testing
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| Pytest + pytest-asyncio | Tests backend | Standard Python, fixtures puissantes |
| Testcontainers | Tests intégration | Vraie DB PostgreSQL (pas de mocks) |
| Vitest + Testing Library | Tests frontend | Rapide, compatible Vite |
| Playwright | Tests E2E | Cross-browser, screenshots, traces vidéo |
| k6 | Tests performance | Scripts JS, métriques précises |

### Documentation
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| MkDocs Material | Docs techniques IT | Markdown, recherche, versioning Git |
| Storybook | Docs composants UI | Tests visuels, catalogue interactif |
| OpenAPI/Swagger | Docs API | Auto-générée par FastAPI, toujours à jour |

---

## Template Architecture

```markdown
# Architecture: [Nom Projet]

**PRD Ref:** [Lien vers PRD] | **Version:** 1.0 | **Architect:** [Nom]
**DBA Consulté:** ✅/❌ | **UI/UX Consulté:** ✅/❌

## 1. Vue d'Ensemble

**Diagramme C4 Level 1:**

[Utilisateur]
     |
     v
[Traefik Proxy] --SSL/TLS--> [Authentik SSO/2FA]
     |
     |---> [Frontend React]
     |         | API REST
     |         v
     |---> [FastAPI Backend]
               |
               |---> [PostgreSQL]
               |---> [Redis Cache]
               |---> [MinIO Storage]
               |---> [Celery Workers]

**Composants principaux:**
- Frontend : React 18 + TypeScript + Tailwind CSS
- Backend : FastAPI Python
- Data : PostgreSQL + Redis + MinIO
- Auth : Authentik (SSO/OIDC/2FA)
- Infra : Docker + Traefik

## 2. Décisions Architecturales (ADR)

### ADR-001: [Titre décision]
- **Status:** Accepted / Proposed / Deprecated
- **Context:** Pourquoi cette décision ?
- **Decision:** Quoi ?
- **Consequences:**
  - avantage
  - trade-off
- **Alternatives considérées:** [Liste avec raison de rejet]

**Exemple :**
### ADR-001: FastAPI comme backend principal
- **Status:** Accepted
- **Context:** Besoin d'une API performante avec documentation auto et validation forte
- **Decision:** FastAPI + Pydantic + OpenAPI auto-générée
- **Consequences:**
  - Doc API synchronisée avec le code
  - Validation native, async natif, typage fort
  - Nécessite Python 3.11+
- **Alternatives:** Django REST (trop lourd), Express.js (moins de validation)

### ADR-002: PostgreSQL comme base de données unique
- **Status:** Accepted
- **Context:** Besoin d'une base fiable, requêtes complexes, support JSON
- **Decision:** PostgreSQL 16 + SQLAlchemy 2.0 + Alembic
- **Alternatives:** MySQL (moins de fonctionnalités), MongoDB (perte ACID)
- **DBA Ref:** Consulter skill /dba pour conventions et indexation

### ADR-003: Authentik pour SSO et 2FA
- **Status:** Accepted
- **Context:** 2FA obligatoire, SSO pour éviter multi-passwords
- **Decision:** Authentik auto-hébergé (OIDC/OAuth2)
- **Alternatives:** Keycloak (plus complexe), Auth0 (vendor lock-in)

## 3. Diagrammes Techniques

### Architecture Système
```
Clients (navigateur / mobile)
         |
    [Traefik v3]        <-- SSL Let's Encrypt auto
         |
   +-----|-----+
   |           |
[Frontend]  [Authentik]
[React]     [SSO/2FA]
   |
[FastAPI Backend]
   |
   +--[PostgreSQL]
   +--[Redis Cache]
   +--[MinIO Storage]
   +--[Celery Workers]
         |
   [Prometheus/Grafana/Loki]
```

### Flux de Données
```
User Action
  -> Frontend React (validation Zod)
  -> API Call (Authorization: Bearer JWT)
  -> Traefik (routing + rate limiting)
  -> FastAPI (validation Pydantic, auth)
  -> Service Layer (logique métier)
  -> PostgreSQL (persistance)
  -> Response JSON
  -> TanStack Query (cache client)
  -> React re-render
```

## 4. Sécurité & Compliance

### Authentification & Autorisation
- SSO : Authentik (OIDC/OAuth2)
- 2FA : TOTP obligatoire (Google Authenticator, Authy)
- JWT RS256, access 15min + refresh 7j
- RBAC : admin | manager | user | viewer
- Permissions : resource:action (ex: document:delete)

### Données
- Chiffrement repos : LUKS disk + pgcrypto colonnes sensibles
- Chiffrement transit : TLS 1.3 uniquement
- Secrets : .env gitignored + Infisical en production
- Passwords : Argon2id
- GDPR : Données personnelles identifiées, droit à l'oubli

### Checklist OWASP Top 10
- [ ] Injection SQL -> ORM paramétrisé uniquement
- [ ] XSS -> React échappe par défaut + CSP header
- [ ] CSRF -> Tokens CSRF + SameSite cookie
- [ ] Auth -> JWT + 2FA + rate limiting brute-force
- [ ] Données sensibles -> chiffrement repos et transit
- [ ] RBAC -> vérifié côté backend (jamais trust client)
- [ ] Dépendances -> Dependabot + pip audit en CI
- [ ] Audit trail -> qui/quoi/quand/IP loggué

## 5. Scalabilité & Performance

### Targets
| Métrique | Cible | Critique |
|----------|-------|---------|
| Latence API (p95) | <200ms | <500ms |
| First Contentful Paint | <1.5s | <3s |
| Query DB (p95) | <50ms | <200ms |
| Error rate | <0.1% | <1% |
| Uptime (heures bureau) | 99.5% | 99.9% |

### Stratégies
- Cache Redis pour requêtes répétitives (TTL selon fraîcheur)
- Index DB sur colonnes WHERE/ORDER BY (voir /dba)
- Code splitting + lazy loading routes (frontend)
- Pagination cursor-based pour grandes tables (>10k lignes)

## 6. Déploiement

### Stratégie
- **Pilote :** 5-10 users (2 semaines, feedback collecté)
- **Rollout :** Phased par groupe (4 semaines)
- **Rollback :** git checkout v-previous && docker-compose pull && docker-compose up -d
- **Zero-downtime (prod) :** Blue/green avec Traefik routing switch

### Environnements
| Env | Purpose | Accès | Données |
|-----|---------|-------|---------|
| Dev | Dev local | Machine développeur | Fictives |
| Staging | UAT + Tests E2E | Équipe projet | Anonymisées |
| Production | Users réels | Prod only | Réelles |

## 7. Monitoring & Logs

### Dashboards Grafana
- System : CPU, RAM, Disk, Network
- Application : Req/sec, latence, error rate
- Database : Connexions, query time, locks
- Business : Utilisateurs actifs, actions métier

### Alertes Critiques
- API error rate > 1% pendant 2min -> Critical
- DB connexions > 80% pool -> Warning
- CPU > 85% pendant 5min -> Warning
- Disk > 85% -> Warning
- Uptime check fail -> Critical (notification immédiate)

## 8. Documentation

### Docs Techniques IT (MkDocs Material)
```
docs/
├── setup/local-dev.md
├── setup/production.md
├── architecture/overview.md
├── architecture/decisions/ (ADRs)
├── api/ (lien Swagger + exemples)
├── operations/backup-restore.md
├── operations/runbooks/
└── security/policy.md
```

## 9. Tech Debt & Évolutions
- Debt actuel : [Lister avec impact]
- Roadmap Q1 : [Priorités hautes]
- Roadmap Q2+ : [Nice-to-have / scalabilité]
```

## Checklist Validation Architecture

- [ ] ADRs documentés (minimum 3 décisions majeures)
- [ ] Diagramme C4 niveau 1 et 2
- [ ] Stack tech défini avec justification
- [ ] Sécurité : OWASP, 2FA, secrets, chiffrement
- [ ] Performance targets définis
- [ ] Plan déploiement (pilote -> staging -> prod)
- [ ] Environnements dev/staging/prod séparés
- [ ] Monitoring & alertes configurés
- [ ] Documentation technique IT planifiée
- [ ] DBA consulté (conventions DB, indexation, migrations)
- [ ] UI/UX consulté (design system, accessibilité)
- [ ] Rollback plan documenté et testé
- [ ] Tech debt identifié

## Agents à Consulter

| Agent | Quand consulter | Ce qu'il apporte |
|-------|-----------------|------------------|
| `/dba` | Dès que schéma DB identifié | Conventions, index, migrations, backup |
| `/uiux` | Après ADRs frontend définis | Design system, accessibilité, composants |
| `/qa` | Avant plan déploiement | Stratégie tests, critères perf |
| `/ba` | Si contraintes floues | Feasibility technique |
| `/prd` | Si scope change | Impact sur exigences validées |

## Bonnes Pratiques

1. **Keep it Simple :** Monolithe modulaire d'abord, microservices uniquement si scale prouvé
2. **Docker First :** Tout service = container, pas d'installation directe sur host
3. **Infrastructure as Code :** docker-compose.yml versionné dans Git
4. **Secrets jamais en Git :** .env dans .gitignore, vault pour production
5. **Staging = Prod :** Même image Docker, même config (sauf données)
6. **ADR pour toute décision majeure :** Mémoire collective du projet

## Anti-Patterns

- Microservices pour équipe <5 développeurs (sur-engineering)
- Credentials en dur dans code ou images Docker
- Pas d'environnement staging (tester directement en prod)
- Architecture sans ADR (décisions oubliées)
- Pas de plan rollback documenté et testé
- Dépendances propriétaires sans alternative (vendor lock-in)
- Mocks de base de données en tests d'intégration

## Outils

- **Diagrammes :** draw.io, Mermaid, PlantUML, Excalidraw
- **BPMN :** Camunda Modeler (gratuit, open-source)
- **ADR :** Markdown dans docs/architecture/decisions/
- **API Testing :** Bruno (open-source, alternative Postman)
- **Secrets :** Infisical (open-source) ou HashiCorp Vault

## Workflow Recommandé

1. PRD Review (30min) -> Comprendre exigences et contraintes
2. Consultation /dba (30min) -> Entités, conventions DB
3. Consultation /uiux (30min) -> Stack frontend, design system
4. Draft Architecture (3h) -> Diagrammes C4 + ADRs
5. Technical Review (1h) -> Validation équipe IT
6. Refine (1h) -> Ajustements post-review
7. Finalize v1.0 (30min) -> Validation stakeholders
8. Passage à Epics/Stories -> Utilise skill /stories
