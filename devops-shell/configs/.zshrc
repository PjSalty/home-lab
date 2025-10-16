# Path to Oh My Zsh in repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ZSH="$DOTFILES_DIR/custom_plugins/../.oh-my-zsh"

# Load Oh My Zsh
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Starship
export STARSHIP_CONFIG="$DOTFILES_DIR/starship.toml"
eval "$(starship init zsh)"

# -----------------------------
# Aliases
# -----------------------------
alias k='kubectl'
alias t='terraform'
alias tf='terraform'
alias d='docker'
alias awsls='aws s3 ls'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gs='git status'
alias gp='git push'
alias ga='git add'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all'
alias pre='pre-commit'

# -----------------------------
# Git config for signed commits
# -----------------------------
export GPG_TTY=$(tty)
git config --global user.name "Hoffm"
git config --global user.email "hoffman.viking@gmail.com"
git config --global commit.gpgsign true
git config --global gpg.program gpg

# -----------------------------
# History and shell options
# -----------------------------
setopt auto_cd
setopt nocaseglob
setopt correct
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=$HOME/.zsh_history

# -----------------------------
# AWS / K8s / Git prompt functions
# -----------------------------
aws_prompt() {
    if command -v aws >/dev/null 2>&1; then
        ACCOUNT=$(aws sts get-caller-identity --query Account --output text 2>/dev/null)
        REGION=$(aws configure get region 2>/dev/null)
        [ -n "$ACCOUNT" ] && echo "AWS:$ACCOUNT:$REGION"
    fi
}

kube_prompt() {
    if command -v kubectl >/dev/null 2>&1; then
        CONTEXT=$(kubectl config current-context 2>/dev/null)
        [ -n "$CONTEXT" ] && echo "K8s:$CONTEXT"
    fi
}

git_prompt() {
    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        BRANCH=$(git branch --show-current)
        STATUS=$(git status --porcelain 2>/dev/null | wc -l)
        [ -n "$BRANCH" ] && echo "Git:$BRANCH$([ "$STATUS" -ne 0 ] && echo '(modified)')"
    fi
}

# -----------------------------
# Final prompt
# -----------------------------
setopt PROMPT_SUBST
PROMPT='[%F{cyan}%n@%m%f] %F{yellow}%~%f $(aws_prompt) $(kube_prompt) $(git_prompt) %# '
