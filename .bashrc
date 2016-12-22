cd /c/dev

git_author() {
	if [ -z "$GIT_AUTHOR_NAME" ]; then
		echo "developer"
	else
		echo "$GIT_AUTHOR_NAME"
	fi
}

export PS1='\[\033]0;$MSYSTEM:\w\007\]\n\[\033[32m\]`git_author` @ \h \[\033[33m\]\w`__git_ps1` \[\033[0m\]\n$ '

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

# Uncomment to persist pair info between terminal instances
hitch

chrome() {
  SRC="/c/Users/Developer/AppData/Local/Google/Chrome/User Data"
  DST="/c/temp/chromes/$RANDOM"

  mkdir -p $DST/Default
  cp "$SRC/Default/Bookmarks" $DST/Default
  cp "$SRC/Default/History" $DST/Default

  /c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe --incognito --no-first-run --user-data-dir=$DST &
}

SSH_ENV="${HOME}/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

. ~/bashmarks.sh
alias ls='ls -GFhL'
alias la='ls -a'
alias ll='ls -l'
alias be='bundle exec'
alias clean-chromes='rm -rf /c/temp/chromes'
alias unhitch='hitch -u'
alias msb='/c/Program\ Files\ \(x86\)/MSBuild/14.0/Bin/MSBuild.exe $*'
function open_sensible() {
    if [ -f *.sln ];
		then
			echo "PRO TIP: Reorganise this solution per convention ;)"
			\start *.sln
    else
    if [ -d "Source" ];
    then
	    if [ -f Source/*.iml ];
		  then
			  \start Source/*.iml
		  else if [ -f Source/*.sln ];
			then
				\start Source/*.sln
			else
				\start Source/**/*.sln
			fi
		fi
		else
			\atom .
		fi
    fi
}
alias os=open_sensible

hitch
# Add the following to your ~/.bashrc or ~/.zshrc
#
# Alternatively, copy/symlink this file and source in your shell.  See `hitch --setup-path`.

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

# Uncomment to persist pair info between terminal instances
# hitch
