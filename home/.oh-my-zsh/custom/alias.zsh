# Listing
alias lls='ls -larth --color'
alias l=lls
alias lld="ls -lArth --group-directories-first"
#alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
# alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -larth --color | more'    # pipe through 'more' (less doesn't like colors !)
alias lr='ls -lAR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# Cleaning
alias rm='rm -i --preserve-root'
alias rmf='rm -f --preserve-root'
alias clean='rmf *~'

# Moving
alias ..='cd ..'

alias h='history'
alias j='jobs -l'

# System
alias pf='ps -eF'
alias pt='ps -eFH'
alias pu='ps -F -u $USER'

# Updating
alias apts='aptitude search'
alias apti='sudo aptitude install'
alias aptud='sudo aptitude update'
alias aptug='sudo aptitude upgrade'
alias aptv='aptitude versions'
alias aptshow='aptitude show'

# Leaving
alias bye='exit'
alias q='exit'

# Programs
alias gcc='gcc -Wall -pedantic'
alias g99='gcc -Wall -pedantic -std=c99'
alias emacsnw='emacs -nw'
alias gfortran='gfortran -Wall -fimplicit-none'
alias wget_website='wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --no-parent'
# --domains website.org \

export PATH=/home/$USER/GMT4.5.9/bin:$PATH
