# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="rkj-repos"
# ZSH_THEME="jispwoso"
# ZSH_THEME="funky"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#


################################

# themes
# {
    function hg_prompt_info {
      if (( $+commands[hg] )) && grep -q "prompt" ~/.hgrc; then
        hg prompt --angle-brackets "\
    <hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
    </%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
    %{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
    patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
      fi
    }

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
    ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
    ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

    function mygit() {
      if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[blue]%}$ZSH_THEME_GIT_PROMPT_SUFFIX "
      fi
    }

    function retcode() {}

    # look at color in 256
    # sh: source ~/.oh-my-zsh/lib/spectrum.zsh
    # sh: spectrum_ls

    local blue_1="%{$fg_bold[blue]%}┌─"
    local blue_2="%{$fg_bold[blue]%}└─"
    local blue_op="%{$fg_bold[blue]%}["
    local blue_cp="%{$fg_bold[blue]%}]"
    local z_reset_c="%{$reset_color%}"
    local z_green="%{$fg[green]%}"
    local z_black="%{$fg[green]%}"
    local z_cyan="%{$fg[cyan]%}"
    local z_magenta="%{$fg[magenta]%}"
    local z_custom_1="%{$FG[002]%}"
    local z_custom_2="%{$FG[177]%}"
    local z_yellow="%{$fg[yellow]%}"
    local z_default="%{$fg[default]%}"
    local path_p="${blue_op}%~${blue_cp}"
    local user_host="${blue_op}%n@%m${blue_cp}"
    local ret_status="${blue_op}%?${blue_cp}"
    local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"

    PROMPT=$'${blue_1}${blue_op}${z_green}%n%b${z_black}@${z_yellow}%m${blue_cp}${z_reset_c} - ${blue_op}${z_default}%~${blue_cp}${z_reset_c} - ${blue_op}%b${z_custom_2}'%D{"%Y-%m-%d %I:%M:%S"}%b$'${blue_cp} - ${blue_op}${z_magenta}%?$(retcode)${blue_cp}
${blue_2}${blue_op}${z_reset_c}${smiley}${blue_cp} <$(mygit)$(hg_prompt_info)>${z_reset_c} '
    PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
# }


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export GOPATH=$HOME/go
# export GOROOT=/usr/local/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# go env -w GO111MODULE=auto
# export GOPROXY=https://proxy.golang.org,direct


alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias grep='grep --color=auto'
alias tmux='tmux -2'

function llt()
{
	ls -lt --color=auto $1 | head -n 10
}
export llt

unsetopt share_history
bindkey \^U backward-kill-line
# z_proxy='HTTPS_PROXY=http://bj-rd-proxy.byted.org:3128/ HTTP_PROXY=http://bj-rd-proxy.byted.org:3128/  '
# z_proxy='HTTPS_PROXY=http://bj-rd-proxy.byted.org:3128/ HTTP_PROXY=http://bj-rd-proxy.byted.org:3128/  '
# export http_proxy=sys-proxy-rd-relay.byted.org:3128 https_proxy=sys-proxy-rd-relay.byted.org:3128 no_proxy=code.byted.org

export TERM=xterm-256color
# prompt string
# PS1='\u@\h:\w\[\e[33m\]$(__git_ps1 "{%s}")\[\e[0m\]\$ '

# screen and xterm's dynamic title
# [ -z "$SSH_TTY" ] && [ -z "$TMUX" ] && case $TERM in
# case $TERM in
  # xterm*)
	# # Set xterm's title
	# TITLEBAR='\[\e]0;\u@\h:\w\a\]'
	# export PS1="${TITLEBAR}${PS1}"
	# ;;
  # screen*)
	# # Use path as title
	# PATHTITLE='\[\ek\W\e\\\]'
	# export PS1="${PATHTITLE}${PS1}"
	# # Use program name as title
	# #PROGRAMTITLE='\[\ek\e\\\]'
	# #export PS1="${PROGRAMTITLE}${PATHTITLE}${PS1}"
	# ;;
  # *)
	# ;;
# esac
