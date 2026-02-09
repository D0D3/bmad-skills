# Install-BMADSkills.ps1
# Script d'installation des BMAD Skills pour Claude Code

<#
.SYNOPSIS
    Installe les BMAD Skills dans Claude Code

.DESCRIPTION
    Ce script copie les skills BMAD dans le répertoire Claude Code.
    Supporte installation locale et vérification de l'environnement.

.PARAMETER SourcePath
    Chemin source des skills (par défaut: ./skills)

.PARAMETER Force
    Force l'écrasement des skills existants

.EXAMPLE
    .\Install-BMADSkills.ps1
    
.EXAMPLE
    .\Install-BMADSkills.ps1 -SourcePath "C:\dev\bmad-skills\skills" -Force
#>

[CmdletBinding()]
param(
    [Parameter()]
    [string]$SourcePath = ".\skills",
    
    [Parameter()]
    [switch]$Force
)

# Configuration
$ClaudeSkillsPath = Join-Path $env:USERPROFILE ".claude\skills"
$RequiredSkills = @('ba', 'prd', 'architecture', 'stories', 'qa')

# Fonction: Write-ColorOutput
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = 'White'
    )
    Write-Host $Message -ForegroundColor $Color
}

# Fonction: Test-ClaudeCodeInstalled
function Test-ClaudeCodeInstalled {
    try {
        $claudeVersion = & claude --version 2>&1
        return $true
    }
    catch {
        return $false
    }
}

# Header
Write-ColorOutput "`n========================================" Cyan
Write-ColorOutput "  BMAD Skills - Installation Claude Code" Cyan
Write-ColorOutput "========================================`n" Cyan

# Vérification Claude Code
Write-ColorOutput "🔍 Vérification Claude Code..." Yellow
if (-not (Test-ClaudeCodeInstalled)) {
    Write-ColorOutput "⚠️  Claude Code n'est pas détecté dans le PATH" Red
    Write-ColorOutput "   Installation continuera, mais vérifiez que Claude Code est installé.`n" Yellow
}
else {
    Write-ColorOutput "✅ Claude Code détecté`n" Green
}

# Vérification du chemin source
Write-ColorOutput "📁 Vérification du chemin source..." Yellow
if (-not (Test-Path $SourcePath)) {
    Write-ColorOutput "❌ Chemin source introuvable: $SourcePath" Red
    Write-ColorOutput "   Assurez-vous d'exécuter le script depuis le répertoire du repo." Red
    exit 1
}
Write-ColorOutput "✅ Chemin source trouvé: $SourcePath`n" Green

# Vérification des skills requis
Write-ColorOutput "🔍 Vérification des skills..." Yellow
$missingSkills = @()
foreach ($skill in $RequiredSkills) {
    $skillPath = Join-Path $SourcePath "$skill\SKILL.md"
    if (-not (Test-Path $skillPath)) {
        $missingSkills += $skill
    }
}

if ($missingSkills.Count -gt 0) {
    Write-ColorOutput "❌ Skills manquants:" Red
    $missingSkills | ForEach-Object { Write-ColorOutput "   - $_" Red }
    exit 1
}
Write-ColorOutput "✅ Tous les skills requis sont présents`n" Green

# Création du répertoire Claude skills si nécessaire
Write-ColorOutput "📂 Préparation du répertoire de destination..." Yellow
if (-not (Test-Path $ClaudeSkillsPath)) {
    Write-ColorOutput "   Création de $ClaudeSkillsPath" Gray
    New-Item -ItemType Directory -Path $ClaudeSkillsPath -Force | Out-Null
}
Write-ColorOutput "✅ Répertoire prêt: $ClaudeSkillsPath`n" Green

# Backup des skills existants
Write-ColorOutput "💾 Vérification de skills existants..." Yellow
$backupNeeded = $false
foreach ($skill in $RequiredSkills) {
    $destSkillPath = Join-Path $ClaudeSkillsPath $skill
    if (Test-Path $destSkillPath) {
        $backupNeeded = $true
        break
    }
}

if ($backupNeeded -and -not $Force) {
    Write-ColorOutput "⚠️  Des skills existants ont été détectés." Yellow
    $response = Read-Host "   Voulez-vous créer un backup ? (O/n)"
    
    if ($response -eq '' -or $response -eq 'O' -or $response -eq 'o') {
        $backupPath = Join-Path $ClaudeSkillsPath "backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Write-ColorOutput "   Création du backup dans: $backupPath" Gray
        New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
        
        foreach ($skill in $RequiredSkills) {
            $destSkillPath = Join-Path $ClaudeSkillsPath $skill
            if (Test-Path $destSkillPath) {
                Copy-Item -Path $destSkillPath -Destination $backupPath -Recurse -Force
            }
        }
        Write-ColorOutput "✅ Backup créé`n" Green
    }
}

# Installation des skills
Write-ColorOutput "🚀 Installation des skills..." Yellow
$installedCount = 0

foreach ($skill in $RequiredSkills) {
    $sourceSkillPath = Join-Path $SourcePath $skill
    $destSkillPath = Join-Path $ClaudeSkillsPath $skill
    
    try {
        # Supprimer destination si existe
        if (Test-Path $destSkillPath) {
            Remove-Item -Path $destSkillPath -Recurse -Force
        }
        
        # Copier skill
        Copy-Item -Path $sourceSkillPath -Destination $destSkillPath -Recurse -Force
        Write-ColorOutput "   ✅ $skill" Green
        $installedCount++
    }
    catch {
        Write-ColorOutput "   ❌ Erreur lors de l'installation de $skill : $_" Red
    }
}

# Résumé
Write-ColorOutput "`n========================================" Cyan
Write-ColorOutput "  Installation Terminée" Cyan
Write-ColorOutput "========================================" Cyan
Write-ColorOutput "`n📊 Résumé:" White
Write-ColorOutput "   Skills installés: $installedCount/$($RequiredSkills.Count)" $(if ($installedCount -eq $RequiredSkills.Count) { 'Green' } else { 'Yellow' })
Write-ColorOutput "   Destination: $ClaudeSkillsPath" Gray

# Instructions suivantes
Write-ColorOutput "`n📖 Prochaines étapes:" Yellow
Write-ColorOutput "   1. Redémarrez Claude Code (si déjà ouvert)" White
Write-ColorOutput "   2. Lancez Claude Code dans votre projet" White
Write-ColorOutput "   3. Tapez 'skills' pour vérifier les skills chargés" White
Write-ColorOutput "   4. Utilisez: 'utilise le skill ba' ou '/ba'" White

Write-ColorOutput "`n💡 Besoin d'aide ?" Cyan
Write-ColorOutput "   README.md : Guide complet d'utilisation" White
Write-ColorOutput "   GitHub Issues : https://github.com/[your-repo]/issues`n" White

# Success
exit 0
