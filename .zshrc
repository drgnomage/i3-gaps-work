export ZSH=/usr/share/oh-my-zsh
export PATH=~/git/Scripts/scripts:~/work_scripts:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
#export PATH="/home/josh/git/Scripts/scripts:/home/josh/work_scripts:$PATH"

#ZSH_THEME="robbyrussell"
#ZSH_THEME="bullet-train"
#ZSH_THEME="agnosterzak"
ZSH_THEME="agnoster"
#ZSH_THEME="classy"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(adb archlinux colorize common-aliases extract fancy-ctrl-z git gnu-utils history nanoc nmap rsync screen ssh-agentsudo systemd thefuck themes zsh-navigation-tools zsh-notify zsh_reload)

source $ZSH/oh-my-zsh.sh

export LANG=en_GB.UTF-8

export EDITOR='nano'
export SSH_KEY_PATH="~/.ssh/id_rsa.pub"

if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
fi

export GPG_TTY=$(tty)

gpg-connect-agent updatestartuptty /bye >/dev/null

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
export NMON=mndc
export pacmansize=$(pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | head -n 10)

alias dirs="exa"
alias ls=exa
alias cp="rsync -av --progress"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#source /usr/share/zsh/plugins/zsh-directory-history/zsh-directory-history.zsh

setopt COMPLETE_ALIASES

export BROWSER="/usr/bin/firefox"

export TERM=xterm
PATH="/home/josh/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/josh/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/josh/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/josh/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/josh/perl5"; export PERL_MM_OPT;
PATH="/usr/lib/ccache/bin/:$PATH"

export NVM_DIR="/home/josh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
