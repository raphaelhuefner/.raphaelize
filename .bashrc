
export HISTFILESIZE=10000
export HISTCONTROL=erasedups
export HISTTIMEFORMAT="%FT%T"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# See also ~/bin/gcswitch.sh
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/dynamic_default_credentials.json

venv() {
	if [ ! -f ./bin/activate ]; then
		python3 -m venv .
		. ./bin/activate
		pip install --upgrade pip
	fi
	. ./bin/activate
}


mgrep() {
	WHAT=$1
	WHERE=$2
	~/bin/ll;
	echo "grep -RHinE $WHAT $WHERE | grep -v Binary | sort -t: -k1,1d -k2,2g"
}

# Keep this towards the end of .bash_profile
# @see https://github.com/pyenv/pyenv#homebrew-on-macos
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# @see https://help.github.com/articles/telling-git-about-your-signing-key/
export GPG_TTY=$(tty)
