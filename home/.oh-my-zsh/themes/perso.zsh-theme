# perso.zsh-theme, based on smt, avit and others.
# Re-use of old functions from my .bashrc file.

MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
local return_status="%{$fg_bold[red]%}%(?..⏎)%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}⚡%{$reset_color%}" # ✗
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ⚑"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜" # ▴
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
#ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%} ●"
#ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%} ●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═" # §
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭" # ◒

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function prompt_char() {
  git branch >/dev/null 2>/dev/null && echo "%{$fg[green]%}±%{$reset_color%}" && return
  hg root >/dev/null 2>/dev/null && echo "%{$fg_bold[red]%}☿%{$reset_color%}" && return
  darcs show repo >/dev/null 2>/dev/null && echo "%{$fg_bold[green]%}❉%{$reset_color%}" && return
  echo "" # "%{$fg[cyan]%}◯%{$reset_color%}"
}

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo "[$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
            elif [ "$MINUTES" -gt 60 ]; then
                echo "[$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
            else
                echo "[$COLOR${MINUTES}m%{$reset_color%}]"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "[$COLOR~]"
        fi
    fi
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(ssh)%{$reset_color%} "
  fi
}

function season_char() {
    # Resolution of 1 week is enough...
    # Don't want to compute the real starting day of each season!
    week=$(date +%W)
    if [ $week -gt 50 ] || [ $week -le 11 ]; then
        echo "❄" # Winter
    elif [ $week -gt 11 ] && [ $week -le 24 ]; then 
        echo "⚘" # Spring
    elif [ $week -gt 24 ] && [ $week -le 37 ]; then
        echo "☀" # Summer
    elif [ $week -gt 37 ] && [ $week -le 50 ]; then
        echo "☔" # Fall
    fi
}

function user_name() {
    if [[ $USER == "root" ]]; then
        echo "%{$fg_bold[red]%}%n%{$reset_color%}"
    else
        echo "%{$fg[white]%}%n%{$reset_color%}"
    fi
}

# Todo: add message for specific days, not only for hours.
function its_time_long() {
    hour=$(date +%H)
    if [ $hour -le 3 ]; then
	echo "It's high time you went to sleep..."
    elif [ $hour -gt 3 ] && [ $hour -le 5 ]; then
	echo "Today you'll sleep."
    elif [ $hour -gt 5 ] && [ $hour -le 7 ]; then
	echo "Already on a computer?!"
    elif [ $hour -gt 7 ] && [ $hour -le 11 ]; then
	echo "Enjoy the morning."
    elif [ $hour -gt 11 ] && [ $hour -le 12 ]; then
	echo "It's bad habit eating in front of a computer."
    elif [ $hour -gt 12 ] && [ $hour -le 18 ]; then
	echo "After noon it's afternoon."
    elif [ $hour -gt 18 ] && [ $hour -le 19 ]; then
	echo "Good time to stop working."
    elif [ $hour -gt 19 ] && [ $hour -le 20 ]; then
	echo "The night is coming..."
    elif [ $hour -gt 20 ]; then
	echo "Take care of your eyes, it's night!"
    fi
}

function its_time_short() {
    hour=$(date +%H)
    if [ $hour -le 3 ]; then
	echo "Stop. Now."
    elif [ $hour -gt 3 ] && [ $hour -le 5 ]; then
	echo "So early!"
    elif [ $hour -gt 5 ] && [ $hour -le 7 ]; then
	echo "Come on!"
    elif [ $hour -gt 7 ] && [ $hour -le 11 ]; then
	echo "Morning"
    elif [ $hour -gt 11 ] && [ $hour -le 12 ]; then
	echo "Lunch!"
    elif [ $hour -gt 12 ] && [ $hour -le 18 ]; then
	echo "Afternoon"
    elif [ $hour -gt 18 ] && [ $hour -le 19 ]; then
	echo "Well!"
    elif [ $hour -gt 19 ] && [ $hour -le 20 ]; then
	echo "Twilight."
    elif [ $hour -gt 20 ]; then
	echo "Night."
    fi
}

NCPU=$(awk '/^cpu cores/ {print $4; exit}' /proc/cpuinfo)
function cpu_load() {
    LOAD=$(uptime | cut -d ' ' -f 12)
    LOAD=${LOAD%,}
    LOAD=${LOAD/,/.}
    cpu_percent=$(printf "%.0f" "$((100. * $LOAD / $NCPU))")
    if [ $cpu_percent -le 25 ]; then
        echo "%{$fg[green]%}$cpu_percent%%%{$reset_color%}"
    elif [ $cpu_percent -gt 25 ] && [ $cpu_percent -le 50 ]; then
        echo "%{$fg_bold[green]%}$cpu_percent%%%{$reset_color%}"
    elif [ $cpu_percent -gt 50 ] && [ $cpu_percent -le 75 ]; then
        echo "%{$fg[yellow]%}$cpu_percent%%%{$reset_color%}"
    elif [ $cpu_percent -gt 75 ] && [ $cpu_percent -le 90 ]; then
        echo "%{$fg_bold[yellow]%}$cpu_percent%%%{$reset_color%}"
    elif [ $cpu_percent -gt 90 ] && [ $cpu_percent -le 100 ]; then
        echo "%{$fg[red]%}$cpu_percent%%%{$reset_color%}"
    elif [ $cpu_percent -gt 100 ]; then
        echo "%{$fg_bold[red]%}$cpu_percent%%%{$reset_color%}"
    fi
}

# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="exfxcxdxbxegedabagacad"
#export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
#export GREP_COLOR='1;33'

GITPROMPT=${return_status}$(git_time_since_commit)$(git_prompt_status)%{$reset_color%}

PROMPT='
$(ssh_connection)$(user_name)@%m ➜ %{$fg_bold[blue]%}%~%{$reset_color%} $(prompt_char)$(git_prompt_short_sha)$(git_prompt_info)${return_status}$(git_time_since_commit)$(git_prompt_status)%{$reset_color%}
> '

# ╭╰▶ Some chars I want to keep...

RPROMPT='%{$fg[cyan]%}%!%{$reset_color%} $(cpu_load) $(season_char)[%*]'

# Function to run upon exit of shell
function _exit()
{
    echo "It's already $(date +%H:%M), $(its_time_long)"
    echo "$fg_bold[red]Hasta la vista, baby$rest_color"
    sleep 0.3
}
trap _exit EXIT
