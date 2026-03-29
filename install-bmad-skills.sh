#!/bin/bash
# install-bmad-skills.sh
# Script d'installation des BMAD Skills pour Claude Code (Linux/Mac)

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Configuration
SOURCE_PATH="${1:-./skills}"
CLAUDE_SKILLS_PATH="$HOME/.claude/skills"
REQUIRED_SKILLS=("ba" "prd" "architecture" "stories" "qa" "dba" "uiux")

# Fonction: Print avec couleur
print_color() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Header
print_color "$CYAN" "\n========================================"
print_color "$CYAN" "  BMAD Skills - Installation Claude Code"
print_color "$CYAN" "========================================\n"

# Vérification Claude Code
print_color "$YELLOW" "🔍 Vérification Claude Code..."
if ! command -v claude &> /dev/null; then
    print_color "$RED" "⚠️  Claude Code n'est pas détecté dans le PATH"
    print_color "$YELLOW" "   Installation continuera, mais vérifiez que Claude Code est installé.\n"
else
    print_color "$GREEN" "✅ Claude Code détecté\n"
fi

# Vérification du chemin source
print_color "$YELLOW" "📁 Vérification du chemin source..."
if [ ! -d "$SOURCE_PATH" ]; then
    print_color "$RED" "❌ Chemin source introuvable: $SOURCE_PATH"
    print_color "$RED" "   Assurez-vous d'exécuter le script depuis le répertoire du repo."
    exit 1
fi
print_color "$GREEN" "✅ Chemin source trouvé: $SOURCE_PATH\n"

# Vérification des skills requis
print_color "$YELLOW" "🔍 Vérification des skills..."
MISSING_SKILLS=()
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ ! -f "$SOURCE_PATH/$skill/SKILL.md" ]; then
        MISSING_SKILLS+=("$skill")
    fi
done

if [ ${#MISSING_SKILLS[@]} -gt 0 ]; then
    print_color "$RED" "❌ Skills manquants:"
    for skill in "${MISSING_SKILLS[@]}"; do
        print_color "$RED" "   - $skill"
    done
    exit 1
fi
print_color "$GREEN" "✅ Tous les skills requis sont présents\n"

# Création du répertoire Claude skills si nécessaire
print_color "$YELLOW" "📂 Préparation du répertoire de destination..."
if [ ! -d "$CLAUDE_SKILLS_PATH" ]; then
    print_color "$GRAY" "   Création de $CLAUDE_SKILLS_PATH"
    mkdir -p "$CLAUDE_SKILLS_PATH"
fi
print_color "$GREEN" "✅ Répertoire prêt: $CLAUDE_SKILLS_PATH\n"

# Backup des skills existants
print_color "$YELLOW" "💾 Vérification de skills existants..."
BACKUP_NEEDED=false
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ -d "$CLAUDE_SKILLS_PATH/$skill" ]; then
        BACKUP_NEEDED=true
        break
    fi
done

if [ "$BACKUP_NEEDED" = true ]; then
    print_color "$YELLOW" "⚠️  Des skills existants ont été détectés."
    read -p "   Voulez-vous créer un backup ? (O/n): " response
    
    if [ -z "$response" ] || [ "$response" = "O" ] || [ "$response" = "o" ]; then
        BACKUP_PATH="$CLAUDE_SKILLS_PATH/backup-$(date +%Y%m%d-%H%M%S)"
        print_color "$GRAY" "   Création du backup dans: $BACKUP_PATH"
        mkdir -p "$BACKUP_PATH"
        
        for skill in "${REQUIRED_SKILLS[@]}"; do
            if [ -d "$CLAUDE_SKILLS_PATH/$skill" ]; then
                cp -r "$CLAUDE_SKILLS_PATH/$skill" "$BACKUP_PATH/"
            fi
        done
        print_color "$GREEN" "✅ Backup créé\n"
    fi
fi

# Installation des skills
print_color "$YELLOW" "🚀 Installation des skills..."
INSTALLED_COUNT=0

for skill in "${REQUIRED_SKILLS[@]}"; do
    SOURCE_SKILL_PATH="$SOURCE_PATH/$skill"
    DEST_SKILL_PATH="$CLAUDE_SKILLS_PATH/$skill"
    
    # Supprimer destination si existe
    if [ -d "$DEST_SKILL_PATH" ]; then
        rm -rf "$DEST_SKILL_PATH"
    fi
    
    # Copier skill
    if cp -r "$SOURCE_SKILL_PATH" "$DEST_SKILL_PATH"; then
        print_color "$GREEN" "   ✅ $skill"
        ((INSTALLED_COUNT++))
    else
        print_color "$RED" "   ❌ Erreur lors de l'installation de $skill"
    fi
done

# Résumé
print_color "$CYAN" "\n========================================"
print_color "$CYAN" "  Installation Terminée"
print_color "$CYAN" "========================================"

print_color "$WHITE" "\n📊 Résumé:"
if [ $INSTALLED_COUNT -eq ${#REQUIRED_SKILLS[@]} ]; then
    print_color "$GREEN" "   Skills installés: $INSTALLED_COUNT/${#REQUIRED_SKILLS[@]}"
else
    print_color "$YELLOW" "   Skills installés: $INSTALLED_COUNT/${#REQUIRED_SKILLS[@]}"
fi
print_color "$GRAY" "   Destination: $CLAUDE_SKILLS_PATH"

# Instructions suivantes
print_color "$YELLOW" "\n📖 Prochaines étapes:"
print_color "$WHITE" "   1. Redémarrez Claude Code (si déjà ouvert)"
print_color "$WHITE" "   2. Lancez Claude Code dans votre projet"
print_color "$WHITE" "   3. Tapez 'skills' pour vérifier les skills chargés"
print_color "$WHITE" "   4. Utilisez un skill: '/ba', '/prd', '/architecture', '/dba', '/uiux', '/stories', '/qa'"

print_color "$CYAN" "\n💡 Skills disponibles:"
print_color "$GRAY" "   /ba           → Business Analysis"
print_color "$GRAY" "   /prd          → Product Requirements Document"
print_color "$GRAY" "   /architecture → Architecture technique (open-source stack)"
print_color "$GRAY" "   /dba          → Database Administrator (PostgreSQL)"
print_color "$GRAY" "   /uiux         → UI/UX Design (design system, accessibilité)"
print_color "$GRAY" "   /stories      → Epics & User Stories"
print_color "$GRAY" "   /qa           → QA & Testing (agents autonomes, CI/CD)"

print_color "$CYAN" "\n💡 Besoin d'aide ?"
print_color "$WHITE" "   README.md : Guide complet d'utilisation"
print_color "$WHITE" "   GitHub Issues : https://github.com/[your-repo]/issues\n"

# Success
exit 0
