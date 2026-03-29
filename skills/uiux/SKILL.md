# UI/UX - Design & Expérience Utilisateur

## Description
Agent spécialisé en conception d'interfaces et d'expérience utilisateur. Interrogeable par l'architecte et le PRD pour garantir un design cohérent, accessible et utilisable dès le départ. Couvre le design system, la conception de composants, et la documentation visuelle.

## Quand utiliser
- Dès que le PRD identifie des interfaces utilisateur
- Avant de coder les premiers composants React
- Choix du design system et de la librairie de composants
- Revue d'accessibilité (WCAG 2.1)
- Design de formulaires et de workflows utilisateur
- Documentation des composants (Storybook)
- User testing et validation UX

## Comment interroger le UI/UX

```
Architecture  -> /uiux : "Quel design system recommandes-tu pour ce projet ?"
PRD           -> /uiux : "Comment présenter ce workflow complexe à l'utilisateur ?"
Stories       -> /uiux : "Quels composants pour cette user story ?"
QA            -> /uiux : "Comment tester l'accessibilité de ce formulaire ?"
```

---

## 1. Stack Design Recommandée

### Outils de Design
| Outil | Usage | Pourquoi |
|-------|-------|----------|
| Figma (gratuit team) | Maquettes, prototypes | Collaboration temps-réel, composants partagés |
| Excalidraw | Wireframes rapides | Open-source, intégré VS Code |
| Storybook | Documentation composants | Catalogue interactif, tests visuels |
| Chromatic (optionnel) | Review visuelle CI | Screenshots automatiques, diff visuel |

### Stack Frontend (Design System)
| Technologie | Usage | Pourquoi |
|-------------|-------|----------|
| Tailwind CSS v3 | Styles utilitaires | Cohérence, pas de CSS custom spaghetti |
| shadcn/ui | Composants de base | Accessible (Radix UI), personnalisable, code owned |
| Lucide Icons | Icônes | Open-source, cohérent, tree-shakable |
| Framer Motion | Animations | Fluide, accessible (respect prefers-reduced-motion) |
| React Hook Form + Zod | Formulaires | Validation UX avec messages d'erreur contextuels |

**Pourquoi shadcn/ui :**
- Composants installés dans ton projet (pas dépendance npm)
- Entièrement personnalisables sans override CSS
- Accessibles dès le départ (Radix UI primitives)
- Compatibles Tailwind, TypeScript natif

---

## 2. Design System

### Tokens de Design (Tailwind config)
```javascript
// tailwind.config.ts - Tokens personnalisés
module.exports = {
  theme: {
    extend: {
      colors: {
        // Couleurs marque
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',   // Couleur principale
          600: '#2563eb',   // Hover
          700: '#1d4ed8',   // Active
          900: '#1e3a8a',
        },
        // Couleurs sémantiques
        success: { 50: '#f0fdf4', 500: '#22c55e', 700: '#15803d' },
        warning: { 50: '#fffbeb', 500: '#f59e0b', 700: '#b45309' },
        danger:  { 50: '#fef2f2', 500: '#ef4444', 700: '#b91c1c' },
      },
      // Espacement cohérent (4px grid)
      spacing: {
        '4.5': '1.125rem',
        '18': '4.5rem',
      },
      // Typographie
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
    },
  },
}
```

### Typographie
```
Titre H1 : 2.25rem (36px) / font-bold
Titre H2 : 1.875rem (30px) / font-semibold
Titre H3 : 1.5rem (24px) / font-semibold
Body      : 1rem (16px) / font-normal (min 16px pour lisibilité)
Small     : 0.875rem (14px) / uniquement pour labels/captions
Caption   : 0.75rem (12px) / uniquement pour aide contextuelle
Mono      : JetBrains Mono (code, données techniques)
```

### Espacement (grille 4px)
```
xs  : 4px  (0.25rem)  - Espacement interne minimal
sm  : 8px  (0.5rem)   - Espacement entre éléments liés
md  : 16px (1rem)     - Espacement standard
lg  : 24px (1.5rem)   - Espacement entre sections
xl  : 32px (2rem)     - Espacement majeur
2xl : 48px (3rem)     - Espacement page
```

---

## 3. Composants Standards (shadcn/ui)

### Installation composants essentiels
```bash
# Installer shadcn/ui dans le projet
npx shadcn-ui@latest init

# Composants de base à installer dès le départ
npx shadcn-ui@latest add button
npx shadcn-ui@latest add input
npx shadcn-ui@latest add form
npx shadcn-ui@latest add table
npx shadcn-ui@latest add dialog
npx shadcn-ui@latest add select
npx shadcn-ui@latest add toast
npx shadcn-ui@latest add badge
npx shadcn-ui@latest add card
npx shadcn-ui@latest add dropdown-menu
npx shadcn-ui@latest add tabs
npx shadcn-ui@latest add alert
npx shadcn-ui@latest add skeleton
npx shadcn-ui@latest add data-table
```

### Patterns UI Communs

#### Formulaire avec validation
```tsx
// Pattern formulaire accessible avec React Hook Form + Zod + shadcn/ui
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { Form, FormField, FormItem, FormLabel,
         FormControl, FormMessage, FormDescription } from '@/components/ui/form'

const schema = z.object({
  email: z.string().email('Email invalide'),
  name:  z.string().min(2, 'Minimum 2 caractères'),
})

export function UserForm() {
  const form = useForm({ resolver: zodResolver(schema) })

  return (
    <Form {...form}>
      <FormField name="email" render={({ field }) => (
        <FormItem>
          <FormLabel>Email <span aria-hidden>*</span></FormLabel>
          <FormControl>
            <Input placeholder="nom@exemple.com" {...field}
                   aria-required="true" />
          </FormControl>
          <FormDescription>Utilisé pour les notifications</FormDescription>
          <FormMessage />  {/* Erreur accessible automatiquement */}
        </FormItem>
      )} />
    </Form>
  )
}
```

#### État de chargement (Skeleton)
```tsx
// Toujours prévoir le skeleton avant les données réelles
import { Skeleton } from '@/components/ui/skeleton'

function DocumentCard({ isLoading, document }) {
  if (isLoading) return (
    <div className="p-4 space-y-2">
      <Skeleton className="h-4 w-3/4" />
      <Skeleton className="h-4 w-1/2" />
    </div>
  )
  return <Card>{/* contenu réel */}</Card>
}
```

#### Message d'erreur & état vide
```tsx
// État vide (empty state) - toujours prévoir
function DocumentList({ documents }) {
  if (documents.length === 0) return (
    <div className="flex flex-col items-center justify-center py-12 text-center">
      <FileIcon className="h-12 w-12 text-muted-foreground mb-4" aria-hidden />
      <h3 className="text-lg font-semibold">Aucun document</h3>
      <p className="text-muted-foreground mb-4">
        Créez votre premier document pour commencer.
      </p>
      <Button>Nouveau document</Button>
    </div>
  )
  return <Table>{/* liste */}</Table>
}
```

---

## 4. Accessibilité (WCAG 2.1 AA)

### Règles non-négociables

#### Contraste couleurs
```
Texte normal : ratio minimum 4.5:1
Texte large (>18px bold) : ratio minimum 3:1
Composants UI (boutons, inputs) : ratio minimum 3:1

Vérification : https://webaim.org/resources/contrastchecker/
Outil Figma : plugin "Stark" ou "Contrast"
```

#### Navigation clavier
```tsx
// Tous les éléments interactifs doivent être accessibles au clavier
// shadcn/ui gère cela via Radix UI, mais vérifier :

// Focus visible (ne jamais faire outline: none sans alternative)
// tailwind.config.ts
ring: {
  DEFAULT: '2px',
  offset: '2px',
  color: 'primary-500',
}

// Ordre de tabulation logique (pas de tabindex positif sauf cas exceptionnel)
// Dialog/Modal : focus trap automatique avec Radix UI
// Combobox : navigation flèches automatique
```

#### Texte alternatif & ARIA
```tsx
// Images : alt obligatoire (vide "" si décoratif)
<img src="logo.svg" alt="Logo Entreprise" />
<img src="bg-decoration.svg" alt="" aria-hidden="true" />

// Icônes avec sens
<Button>
  <TrashIcon aria-hidden="true" className="mr-2" />
  Supprimer le document
</Button>

// Icônes seules (sans texte)
<Button variant="ghost" aria-label="Supprimer le document">
  <TrashIcon aria-hidden="true" />
</Button>

// Éléments dynamiques (toasts, alertes)
<div role="alert" aria-live="polite">
  Document sauvegardé avec succès
</div>
```

#### Formulaires accessibles
```tsx
// Chaque input doit avoir un label associé
// Jamais de placeholder seul comme label
// Messages d'erreur liés à l'input via aria-describedby

<FormItem>
  <FormLabel htmlFor="email">Email *</FormLabel>
  <FormControl>
    <Input
      id="email"
      aria-required="true"
      aria-describedby="email-error email-hint"
    />
  </FormControl>
  <p id="email-hint" className="text-sm text-muted-foreground">
    Format : nom@domaine.com
  </p>
  <p id="email-error" role="alert" className="text-sm text-destructive">
    {error}
  </p>
</FormItem>
```

### Checklist Accessibilité (par composant)
- [ ] Contraste texte ≥ 4.5:1 (3:1 pour texte large)
- [ ] Navigation clavier fonctionnelle (Tab, Enter, Escape, flèches)
- [ ] Focus visible sur tous les éléments interactifs
- [ ] Labels sur tous les inputs (pas de placeholder seul)
- [ ] Messages d'erreur accessibles (aria-describedby)
- [ ] Images avec alt text (ou alt="" si décoratif)
- [ ] Icônes seules avec aria-label
- [ ] Pas de contenu uniquement par couleur (icône + texte + couleur)
- [ ] Motion respecte prefers-reduced-motion

---

## 5. Responsive Design

### Breakpoints Tailwind (mobile-first)
```
sm  : 640px   - Tablette portrait
md  : 768px   - Tablette paysage
lg  : 1024px  - Desktop petit
xl  : 1280px  - Desktop standard
2xl : 1536px  - Desktop large
```

### Patterns Layout
```tsx
// Sidebar responsive
<div className="flex h-screen">
  {/* Sidebar : cachée mobile, visible desktop */}
  <aside className="hidden lg:flex lg:w-64 lg:flex-col border-r">
    <Navigation />
  </aside>

  {/* Contenu principal */}
  <main className="flex-1 overflow-auto p-4 lg:p-8">
    <Outlet />
  </main>
</div>

// Grid responsive
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
  {items.map(item => <Card key={item.id} {...item} />)}
</div>

// Table responsive (scroll horizontal sur mobile)
<div className="overflow-x-auto -mx-4 sm:mx-0">
  <table className="min-w-full">...</table>
</div>
```

---

## 6. UX Patterns Clés

### Feedback utilisateur (toujours prévoir)
```tsx
// 4 états à toujours gérer :
// 1. Loading (skeleton ou spinner)
// 2. Empty state (illustration + CTA)
// 3. Error state (message clair + action corrective)
// 4. Success (confirmation toast ou inline)

import { toast } from '@/components/ui/use-toast'

// Action réussie
toast({ title: "Document sauvegardé", description: "Modifications enregistrées." })

// Action échouée
toast({
  title: "Erreur",
  description: "Impossible de sauvegarder. Vérifiez votre connexion.",
  variant: "destructive",
  action: <Button onClick={retry}>Réessayer</Button>
})
```

### Confirmation d'actions destructives
```tsx
// Toujours confirmer les actions irréversibles
<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Supprimer</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Confirmer la suppression</AlertDialogTitle>
      <AlertDialogDescription>
        Cette action est irréversible. Le document sera définitivement supprimé.
      </AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Annuler</AlertDialogCancel>
      <AlertDialogAction onClick={handleDelete}>Supprimer</AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>
```

### Navigation et fil d'Ariane
```tsx
// Toujours indiquer où on est dans l'application
<nav aria-label="Fil d'Ariane">
  <ol className="flex items-center space-x-2 text-sm">
    <li><Link href="/projects">Projets</Link></li>
    <li aria-hidden>/</li>
    <li><Link href={`/projects/${id}`}>{project.name}</Link></li>
    <li aria-hidden>/</li>
    <li aria-current="page">Documents</li>
  </ol>
</nav>
```

### Optimistic Updates (UX réactive)
```tsx
// Mettre à jour l'UI immédiatement, rollback si erreur
const { mutate } = useMutation({
  mutationFn: updateDocument,
  onMutate: async (newData) => {
    // Annuler requêtes en cours
    await queryClient.cancelQueries({ queryKey: ['document', id] })
    // Snapshot état précédent
    const previous = queryClient.getQueryData(['document', id])
    // Mise à jour optimiste
    queryClient.setQueryData(['document', id], newData)
    return { previous }
  },
  onError: (err, newData, context) => {
    // Rollback en cas d'erreur
    queryClient.setQueryData(['document', id], context.previous)
    toast({ title: "Erreur", variant: "destructive" })
  },
  onSettled: () => {
    queryClient.invalidateQueries({ queryKey: ['document', id] })
  }
})
```

---

## 7. Documentation Storybook

### Structure stories
```
src/
└── components/
    ├── ui/           (composants shadcn/ui customisés)
    │   ├── button.tsx
    │   └── button.stories.tsx
    ├── features/     (composants métier)
    │   ├── DocumentCard/
    │   │   ├── DocumentCard.tsx
    │   │   └── DocumentCard.stories.tsx
    └── layouts/
```

### Template story
```tsx
// DocumentCard.stories.tsx
import type { Meta, StoryObj } from '@storybook/react'
import { DocumentCard } from './DocumentCard'

const meta: Meta<typeof DocumentCard> = {
  component: DocumentCard,
  title: 'Features/DocumentCard',
  tags: ['autodocs'],
  parameters: {
    // Exemple dans la doc
    docs: {
      description: {
        component: 'Carte d\'affichage d\'un document avec actions rapides.'
      }
    }
  }
}
export default meta
type Story = StoryObj<typeof DocumentCard>

export const Default: Story = {
  args: {
    title: 'Rapport annuel 2024',
    status: 'approved',
    owner: { name: 'Marie Dupont', avatar: '/avatar.jpg' },
    updatedAt: new Date('2024-01-15'),
  }
}

export const Loading: Story = {
  args: { isLoading: true }
}

export const WithError: Story = {
  args: {
    title: 'Document corrompu',
    status: 'error',
    errorMessage: 'Fichier inaccessible'
  }
}
```

---

## 8. Documentation Utilisateur

### Captures d'écran dans la documentation
```markdown
# Bonnes pratiques captures d'écran

## Format
- PNG pour interfaces statiques
- GIF/WebP animé pour workflows (max 10sec)
- Résolution : 1280×800 minimum, 2x pour Retina

## Contenu
- Annoter les zones importantes (flèches, numéros, surbrillance)
- Masquer données sensibles (emails, noms, IDs)
- État réaliste (données représentatives, pas "test test")

## Outil recommandé : Flameshot (Linux) ou Snagit
- Annotation directe
- Flouage automatique de données sensibles
- Export haute résolution

## Organisation docs/
docs-utilisateur/
├── demarrage-rapide/
│   ├── 01-connexion.md         (+ captures)
│   └── 02-premier-document.md  (+ captures)
├── guides/
│   ├── gestion-documents.md
│   └── workflow-approbation.md
└── faq/
    └── problemes-courants.md
```

### Template documentation utilisateur
```markdown
# [Titre de la fonctionnalité]

## Résumé
[1-2 phrases : ce que la fonctionnalité permet de faire]

## Prérequis
- Rôle requis : [user / manager / admin]
- [Autre prérequis si applicable]

## Étapes

### 1. [Première étape]
[Description courte]

[CAPTURE : capture-01-etape1.png]
> Légende : Cliquez sur le bouton "Nouveau document" en haut à droite

### 2. [Deuxième étape]
...

## Résultat attendu
[Ce qui doit se passer après avoir suivi les étapes]

## Cas d'utilisation

### Cas 1 : [Scénario courant]
> Marie, gestionnaire, veut approuver un document depuis son téléphone...

### Cas 2 : [Scénario alternatif]
> Jean, administrateur, veut voir l'historique d'un document...

## Problèmes courants

### "Je ne vois pas le bouton X"
**Cause :** Vous n'avez probablement pas le rôle [X]
**Solution :** Contactez votre administrateur

### "Le document n'apparaît pas après upload"
**Cause :** Taille du fichier > 50MB ou format non supporté
**Solution :** Vérifiez le format (PDF, DOCX, XLSX) et la taille

## À savoir
- [Limite ou contrainte importante]
- [Raccourci clavier utile]
```

---

## Checklist UI/UX

### Design
- [ ] Design system défini (palette, typo, espacement)
- [ ] Maquettes créées (Figma) pour écrans principaux
- [ ] Mobile-first vérifié (320px minimum)
- [ ] Dark mode planifié (si requis)
- [ ] États gérés : loading, empty, error, success

### Accessibilité
- [ ] Contraste couleurs validé (≥4.5:1)
- [ ] Navigation clavier testée
- [ ] Labels sur tous les inputs
- [ ] Alt text sur toutes les images
- [ ] Testé avec lecteur d'écran (NVDA/VoiceOver)
- [ ] prefers-reduced-motion respecté

### Composants
- [ ] shadcn/ui installé et configuré
- [ ] Composants métier dans Storybook
- [ ] Stories pour états : default, loading, error, empty
- [ ] Tests visuels configurés (Chromatic si budget)

### Documentation Utilisateur
- [ ] Guide démarrage rapide (1 page)
- [ ] Captures d'écran annotées pour fonctionnalités clés
- [ ] Cas d'utilisation documentés
- [ ] FAQ troubleshooting
- [ ] Données sensibles masquées dans captures

## Bonnes Pratiques

1. **Mobile-first :** Concevoir d'abord pour 320px, puis élargir
2. **States complets :** Loading, empty, error, success pour chaque composant
3. **Feedback immédiat :** L'utilisateur doit toujours savoir ce qui se passe
4. **Accessibilité by default :** shadcn/ui + Radix UI gèrent les bases, ne pas override
5. **Storybook dès le début :** Chaque composant documenté à la création
6. **Captures réalistes :** Données représentatives, pas de "Lorem ipsum"

## Anti-Patterns

- Placeholder comme seul label (inaccessible, disparaît à la frappe)
- outline: none sans alternative de focus visible
- Actions destructives sans confirmation
- Pas d'état loading (interface gelée = impression de bug)
- Pas d'état vide (liste vide sans explication)
- Icônes seules sans aria-label ni texte
- Texte trop petit (<14px pour corps, <16px recommandé)
- Couleur seule pour transmettre une information (ex: rouge = erreur sans icône)

## Workflow Recommandé

1. PRD Review (30min) -> Identifier écrans et flux utilisateurs
2. Wireframes (Excalidraw, 1h) -> Structure rapide des écrans principaux
3. Maquettes Figma (2-4h) -> Design détaillé avec design system
4. Review stakeholders (1h) -> Validation avant code
5. Composants Storybook (en parallèle dev) -> Documenter à la création
6. Accessibilité check (1h par écran) -> Validation finale
7. Documentation utilisateur (après dev) -> Captures réelles de l'app
