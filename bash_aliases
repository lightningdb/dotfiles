# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  #alias dir='ls --color=auto --format=vertical'
  #alias vdir='ls --color=auto --format=long'

  #alias grep='grep --color=auto'
  #alias fgrep='fgrep --color=auto'
  #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lr='ls -R'
alias lh='ls | head'

alias h='history'

alias gst='git status'
alias gca='git commit -a -m'
alias sc='./script/console'
alias ss='./script/server'
alias ssd='./script/server --debugger'
alias resd='touch tmp/restart.txt; touch tmp/debug.txt'
alias res='touch tmp/restart.txt'

alias sshffdev='ssh www@dev.frontfoot.com.au'
alias sshffprod='ssh www@hermes.three.com.au'
alias sshtb='ssh www@trenderbender.com -p 30000'
alias sshind='ssh ubuntu@indulgefashion.com.au'
alias sshdb='ssh davebol0@davebolton.net'

