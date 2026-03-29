# DBA - Database Administrator

## Description
Agent spécialisé en conception et administration de bases de données relationnelles (PostgreSQL). Interrogeable par l'architecte et le PRD pour obtenir les meilleures pratiques immédiatement. Garantit un schéma solide, performant et sécurisé dès le départ.

## Quand utiliser
- Dès que le schéma DB est identifié (en parallèle de l'architecture)
- Avant de créer les premières migrations
- Choix de type de données ou de relations
- Optimisation de requêtes lentes
- Stratégie de backup/restore
- Revue de sécurité base de données
- Audit du schéma existant

## Comment interroger le DBA

Le DBA peut être consulté par n'importe quel autre agent :

```
Architecture -> /dba : "Quelles colonnes indexer pour cette requête ?"
PRD          -> /dba : "Quel impact DB pour cette fonctionnalité ?"
Stories      -> /dba : "Quelle migration Alembic pour cette US ?"
QA           -> /dba : "Comment tester cette contrainte DB ?"
```

---

## 1. Conventions de Nommage PostgreSQL

### Tables et colonnes
```sql
-- Tables : snake_case, pluriel, sans préfixe
CREATE TABLE users (...)
CREATE TABLE project_documents (...)  -- non: tbl_documents, Documents

-- Colonnes : snake_case, descriptif
id              UUID PRIMARY KEY DEFAULT gen_random_uuid()
created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
is_active       BOOLEAN NOT NULL DEFAULT true
deleted_at      TIMESTAMPTZ  -- soft delete (null = non supprimé)

-- Clés étrangères : <table_référencée>_id
user_id         UUID NOT NULL REFERENCES users(id)
project_id      UUID NOT NULL REFERENCES projects(id)

-- Index : idx_<table>_<colonne(s)>
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_documents_project_id ON documents(project_id);
CREATE INDEX idx_documents_created_at ON documents(created_at DESC);
```

### Règles générales
- Jamais de mots réservés SQL comme nom (type, user, order, group)
- Préférer UUID à serial/integer pour les PKs (évite les collisions, sécurité)
- Toujours `NOT NULL` sauf si l'absence a une signification métier
- Toujours `created_at` et `updated_at` sur toute table avec historique

---

## 2. Types de Données Recommandés

| Cas d'usage | Type PostgreSQL | Pourquoi |
|-------------|-----------------|----------|
| Identifiants | `UUID` | Pas de séquence prévisible, distributed-safe |
| Texte court (<255) | `VARCHAR(n)` ou `TEXT` | TEXT sans contrainte est OK dans PG |
| Texte long | `TEXT` | Pas de limite arbitraire |
| Montants/Prix | `NUMERIC(12,2)` | Précision exacte (jamais FLOAT pour l'argent) |
| Dates/heures | `TIMESTAMPTZ` | Avec timezone, toujours UTC stocké |
| Dates seules | `DATE` | Sans heure |
| Booléens | `BOOLEAN` | Natif, lisible |
| Données structurées | `JSONB` | Indexable, requêtable (préférer JSONB à JSON) |
| Énumérations | `TEXT` + CHECK ou `ENUM` | TEXT + CHECK plus flexible |
| Fichiers | Stocker chemin/URL dans `TEXT` | Jamais stocker binaire en DB |
| IP Addresses | `INET` | Type natif PG, validé |
| Emails | `TEXT` + contrainte CHECK | ou domaine custom |

### Exemple table bien typée
```sql
CREATE TABLE documents (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title           TEXT NOT NULL CHECK (char_length(title) > 0),
    content         TEXT,
    status          TEXT NOT NULL DEFAULT 'draft'
                    CHECK (status IN ('draft', 'review', 'approved', 'archived')),
    owner_id        UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    project_id      UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    metadata        JSONB NOT NULL DEFAULT '{}',
    file_url        TEXT,
    file_size_bytes BIGINT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ  -- soft delete
);
```

---

## 3. Stratégie d'Indexation

### Règle de base : index sur colonnes utilisées en WHERE, JOIN, ORDER BY

```sql
-- Index simple (colonne unique fréquemment filtrée)
CREATE INDEX idx_documents_owner_id ON documents(owner_id);
CREATE INDEX idx_documents_status ON documents(status) WHERE deleted_at IS NULL;

-- Index composite (requêtes multi-colonnes fréquentes)
-- Ordre : colonne la plus sélective en premier
CREATE INDEX idx_documents_project_status
    ON documents(project_id, status)
    WHERE deleted_at IS NULL;

-- Index sur JSONB (si requêtes sur champ JSON)
CREATE INDEX idx_documents_metadata_type
    ON documents USING GIN (metadata);

-- Index partiel (soft delete pattern)
CREATE UNIQUE INDEX idx_users_email_active
    ON users(email) WHERE deleted_at IS NULL;

-- Index pour full-text search
CREATE INDEX idx_documents_fts
    ON documents USING GIN (to_tsvector('french', title || ' ' || coalesce(content, '')));
```

### Quoi NE PAS indexer
- Colonnes avec faible cardinalité sans filtre (ex: booléen sans WHERE)
- Tables avec très peu de lignes (<1000 lignes rarement)
- Toutes les colonnes par précaution (ralentit INSERT/UPDATE)

### Analyser les index manquants
```sql
-- Requêtes lentes (activer pg_stat_statements)
SELECT query, calls, mean_exec_time, total_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 20;

-- Index inutilisés (à supprimer)
SELECT schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY tablename;

-- EXPLAIN ANALYZE pour analyser une requête
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM documents WHERE project_id = $1 AND status = 'approved';
```

---

## 4. Migrations avec Alembic

### Structure projet
```
alembic/
├── env.py          # Configuration connexion DB
├── script.py.mako  # Template migration
└── versions/
    ├── 001_initial_schema.py
    ├── 002_add_documents_table.py
    └── 003_add_full_text_index.py
```

### Commandes essentielles
```bash
# Créer une migration automatique depuis les modèles SQLAlchemy
alembic revision --autogenerate -m "add documents table"

# Appliquer toutes les migrations
alembic upgrade head

# Rollback d'une migration
alembic downgrade -1

# Voir l'état actuel
alembic current

# Historique des migrations
alembic history --verbose
```

### Template migration robuste
```python
"""add documents table

Revision ID: 002abc123
Revises: 001xyz789
Create Date: 2024-01-15 10:30:00
"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects.postgresql import UUID, JSONB

revision = '002abc123'
down_revision = '001xyz789'
branch_labels = None
depends_on = None

def upgrade() -> None:
    op.create_table('documents',
        sa.Column('id', UUID(), server_default=sa.text('gen_random_uuid()'),
                  nullable=False),
        sa.Column('title', sa.Text(), nullable=False),
        sa.Column('status', sa.Text(), server_default='draft', nullable=False),
        sa.Column('owner_id', UUID(), nullable=False),
        sa.Column('project_id', UUID(), nullable=False),
        sa.Column('metadata', JSONB(), server_default='{}', nullable=False),
        sa.Column('created_at', sa.TIMESTAMP(timezone=True),
                  server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.TIMESTAMP(timezone=True),
                  server_default=sa.text('now()'), nullable=False),
        sa.Column('deleted_at', sa.TIMESTAMP(timezone=True), nullable=True),
        sa.ForeignKeyConstraint(['owner_id'], ['users.id'], ondelete='RESTRICT'),
        sa.ForeignKeyConstraint(['project_id'], ['projects.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.CheckConstraint("status IN ('draft','review','approved','archived')",
                          name='ck_documents_status')
    )
    op.create_index('idx_documents_owner_id', 'documents', ['owner_id'])
    op.create_index('idx_documents_project_id', 'documents', ['project_id'])

def downgrade() -> None:
    op.drop_index('idx_documents_project_id')
    op.drop_index('idx_documents_owner_id')
    op.drop_table('documents')
```

### Règles migrations
- Chaque migration = une unité atomique
- Toujours écrire la fonction `downgrade()`
- Tester `upgrade` + `downgrade` en staging avant prod
- Jamais modifier une migration déjà appliquée en prod (créer une nouvelle)
- Migrations destructives (DROP TABLE, ALTER TYPE) : planifier avec fenêtre maintenance

---

## 5. Sécurité Base de Données

### Principe du moindre privilège
```sql
-- Utilisateur application (lecture + écriture tables métier uniquement)
CREATE ROLE app_user WITH LOGIN PASSWORD 'strong_password_from_vault';
GRANT CONNECT ON DATABASE mydb TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;

-- Utilisateur migrations (DDL uniquement en CI/CD)
CREATE ROLE migration_user WITH LOGIN PASSWORD 'other_strong_password';
GRANT ALL PRIVILEGES ON DATABASE mydb TO migration_user;

-- Utilisateur lecture seule (reporting, analytics)
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'another_password';
GRANT CONNECT ON DATABASE mydb TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
```

### Row-Level Security (RLS) - pour multi-tenant
```sql
-- Activer RLS sur table sensible
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Politique : utilisateur ne voit que ses documents
CREATE POLICY documents_user_policy ON documents
    FOR ALL TO app_user
    USING (owner_id = current_setting('app.current_user_id')::UUID);
```

### Audit Trail
```sql
-- Table d'audit centralisée
CREATE TABLE audit_log (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name  TEXT NOT NULL,
    record_id   UUID NOT NULL,
    action      TEXT NOT NULL CHECK (action IN ('INSERT','UPDATE','DELETE')),
    old_values  JSONB,
    new_values  JSONB,
    user_id     UUID,
    user_ip     INET,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Trigger d'audit générique
CREATE OR REPLACE FUNCTION audit_trigger_fn()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO audit_log (table_name, record_id, action, old_values, new_values)
    VALUES (
        TG_TABLE_NAME,
        COALESCE(NEW.id, OLD.id),
        TG_OP,
        CASE WHEN TG_OP != 'INSERT' THEN row_to_json(OLD)::JSONB END,
        CASE WHEN TG_OP != 'DELETE' THEN row_to_json(NEW)::JSONB END
    );
    RETURN COALESCE(NEW, OLD);
END;
$$;
```

---

## 6. Backup & Restore

### Stratégie backup recommandée
```bash
# Backup quotidien complet (pg_dump vers MinIO/S3)
pg_dump -h localhost -U postgres -d mydb \
  --format=custom \
  --file=/tmp/backup_$(date +%Y%m%d_%H%M%S).dump

# Upload vers MinIO
mc cp /tmp/backup_*.dump minio/backups/postgres/

# Rétention : 7 jours quotidiens + 4 semaines hebdomadaires + 12 mois mensuels
```

### Script backup automatisé (cron Docker)
```bash
#!/bin/bash
# backup.sh - lancé chaque nuit à 02:00 par cron

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/backups/db_${DATE}.dump"

pg_dump \
  --host="${DB_HOST}" \
  --username="${DB_USER}" \
  --dbname="${DB_NAME}" \
  --format=custom \
  --compress=9 \
  --file="${BACKUP_FILE}"

if [ $? -eq 0 ]; then
    echo "Backup OK: ${BACKUP_FILE}"
    # Supprimer backups >7 jours
    find /backups -name "*.dump" -mtime +7 -delete
else
    echo "ERREUR backup - envoyer alerte!"
    exit 1
fi
```

### Test de restore (obligatoire mensuel)
```bash
# Restore sur instance staging pour validation
pg_restore \
  --host="${STAGING_DB_HOST}" \
  --username="${DB_USER}" \
  --dbname="${DB_NAME_STAGING}" \
  --clean \
  --if-exists \
  "${BACKUP_FILE}"

# Valider données post-restore
psql -c "SELECT COUNT(*) FROM users;" "${STAGING_DB_NAME}"
psql -c "SELECT MAX(created_at) FROM documents;" "${STAGING_DB_NAME}"
```

**Règle d'or :** Un backup non testé n'est pas un backup.

---

## 7. Optimisation & Performance

### Paramètres PostgreSQL recommandés
```ini
# postgresql.conf (ajuster selon RAM disponible)

# Mémoire (pour 4GB RAM)
shared_buffers = 1GB                 # 25% RAM
work_mem = 64MB                      # Par opération de tri
maintenance_work_mem = 256MB         # Pour VACUUM, CREATE INDEX
effective_cache_size = 3GB           # 75% RAM (estimation cache OS)

# Connexions
max_connections = 100                # + PgBouncer si >50 app instances
pool_mode = transaction              # PgBouncer recommandé

# WAL & Logs
wal_level = replica                  # Pour réplication si besoin
log_min_duration_statement = 1000    # Logguer requêtes >1sec
log_checkpoints = on
log_connections = on
log_lock_waits = on

# Autovacuum
autovacuum = on
autovacuum_vacuum_threshold = 50
autovacuum_analyze_threshold = 50
```

### Requêtes N+1 (anti-pattern fréquent)
```python
# BAD : N+1 (1 requête pour documents + N pour chaque owner)
documents = session.query(Document).all()
for doc in documents:
    print(doc.owner.name)  # Requête SQL par document !

# GOOD : eager loading avec joinedload
from sqlalchemy.orm import joinedload
documents = session.query(Document)\
    .options(joinedload(Document.owner))\
    .all()
```

### Pagination efficace
```sql
-- BAD : OFFSET lent sur grandes tables
SELECT * FROM documents ORDER BY created_at DESC LIMIT 20 OFFSET 10000;

-- GOOD : cursor-based pagination
SELECT * FROM documents
WHERE created_at < :cursor_timestamp
ORDER BY created_at DESC
LIMIT 20;
```

---

## 8. Schémas Types Courants

### Gestion utilisateurs
```sql
CREATE TABLE users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email           TEXT NOT NULL,
    hashed_password TEXT NOT NULL,
    full_name       TEXT NOT NULL,
    role            TEXT NOT NULL DEFAULT 'user'
                    CHECK (role IN ('admin','manager','user','viewer')),
    is_active       BOOLEAN NOT NULL DEFAULT true,
    last_login_at   TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ
);
CREATE UNIQUE INDEX idx_users_email_active ON users(email) WHERE deleted_at IS NULL;
```

### Gestion documents/fichiers
```sql
CREATE TABLE files (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_name   TEXT NOT NULL,
    storage_key     TEXT NOT NULL UNIQUE,  -- Chemin MinIO/S3
    mime_type       TEXT NOT NULL,
    size_bytes      BIGINT NOT NULL,
    checksum_sha256 TEXT NOT NULL,
    uploaded_by     UUID NOT NULL REFERENCES users(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

### Notifications / Events
```sql
CREATE TABLE notifications (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type        TEXT NOT NULL,
    title       TEXT NOT NULL,
    body        TEXT,
    data        JSONB NOT NULL DEFAULT '{}',
    read_at     TIMESTAMPTZ,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_notifications_user_unread
    ON notifications(user_id, created_at DESC)
    WHERE read_at IS NULL;
```

---

## Checklist DBA

### Conception
- [ ] UUID comme PK sur toutes les tables
- [ ] created_at + updated_at sur tables avec historique
- [ ] deleted_at (soft delete) si suppression logique nécessaire
- [ ] Contraintes CHECK pour les énumérations
- [ ] Foreign keys avec ON DELETE explicite (CASCADE vs RESTRICT)
- [ ] Index sur toutes les FK
- [ ] Index composites pour requêtes fréquentes multi-colonnes

### Sécurité
- [ ] Utilisateur app avec droits minimaux (pas superuser)
- [ ] Mots de passe forts depuis vault (jamais en dur)
- [ ] RLS activé sur tables multi-tenant si applicable
- [ ] Audit trail pour tables sensibles

### Migration
- [ ] Migration testée : upgrade + downgrade
- [ ] Migration appliquée en staging avant prod
- [ ] Plan rollback documenté pour migrations destructives

### Backup
- [ ] Backup quotidien automatisé
- [ ] Test restore mensuel documenté
- [ ] Backup stocké hors du serveur DB (MinIO/S3 séparé)

### Performance
- [ ] EXPLAIN ANALYZE sur requêtes critiques
- [ ] pg_stat_statements activé
- [ ] Index inutilisés identifiés et supprimés
- [ ] Pas de requêtes N+1 (eager loading configuré)

## Bonnes Pratiques

1. **UUID partout :** Évite les séquences prédictibles, safe pour distribution
2. **Migrations versionnées :** Jamais modifier le schéma manuellement en prod
3. **Tester le restore :** Un backup non testé ne compte pas
4. **Least privilege :** L'app ne doit jamais être superuser
5. **Index stratégiques :** Sur mesure selon requêtes réelles (pas par précaution)
6. **JSONB pour flexibilité :** Mais pas de remplacement du schéma relationnel

## Anti-Patterns

- Stocker des fichiers binaires (images, PDF) dans PostgreSQL
- Utiliser FLOAT pour les montants financiers (utiliser NUMERIC)
- Pas de contraintes (FK, CHECK, NOT NULL) "pour aller plus vite"
- Index sur toutes les colonnes par précaution
- Requêtes N+1 non détectées
- Backup sans test de restore
- Superuser pour l'application
- Dates sans timezone (TIMESTAMP sans TZ)

## Workflow DBA Recommandé

1. **Réception exigences** (PRD/Architecture) -> Identifier entités et relations
2. **Draft schéma** -> Proposer tables, types, contraintes
3. **Review architecture** -> Valider avec architecte
4. **Conventions check** -> Nommage, types, index
5. **Création migrations** -> Alembic, avec downgrade
6. **Test staging** -> Upgrade + downgrade + perf test
7. **Documentation** -> Schema diagram + runbook backup
8. **Review périodique** -> Analyser index inutilisés, requêtes lentes
