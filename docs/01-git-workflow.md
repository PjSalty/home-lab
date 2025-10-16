cat > docs/01-git-workflow.md << 'EOF'
# Git Workflow Reference

## Daily Workflow

### Starting Work
```bash
# Switch to main branch
git checkout main

# Pull latest changes
git pull origin main

# Create feature branch
git checkout -b feature/add-prometheus
```

### Making Changes
```bash
# Check status
git status

# Stage specific files
git add terraform/modules/prometheus/

# Or stage all changes
git add .

# Commit with descriptive message
git commit -m "Add Prometheus monitoring module"
```

### Pushing Changes
```bash
# Push feature branch to GitHub
git push -u origin feature/add-prometheus

# Subsequent pushes
git push
```

### Merging Changes
```bash
# Switch to main
git checkout main

# Merge feature branch
git merge feature/add-prometheus

# Push to GitHub
git push origin main

# Delete feature branch locally
git branch -d feature/add-prometheus

# Delete feature branch on GitHub
git push origin --delete feature/add-prometheus
```

## Common Git Commands
```bash
# View commit history
git log --oneline --graph --all

# View changes
git diff

# View staged changes
git diff --staged

# Undo uncommitted changes
git checkout -- filename

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Stash changes (temporary save)
git stash

# Apply stashed changes
git stash pop

# List stashes
git stash list
```

## Branch Naming Conventions

- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `hotfix/description` - Urgent fixes
- `docs/description` - Documentation
- `refactor/description` - Code refactoring

## Commit Message Guidelines

Format: `<type>: <description>`

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

Examples: