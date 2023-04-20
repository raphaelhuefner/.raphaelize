
# https://security.stackexchange.com/questions/162552/gpg-fingerprint-prints-out-completely-different-fingerprint
alias gpg-list-all="gpg --list-keys --with-subkey-fingerprints --with-keygrip"
alias gpg-list-all-secret="gpg --list-secret-keys --with-subkey-fingerprints --with-keygrip"

alias gal="gcloud auth login"

alias utc="date --utc +%FT%TZ"

alias gsu="git submodule update --init --recursive"
alias gf="git fetch --all --prune"
alias gfm="git fetch --all --prune; git branch -f main origin/main"
alias utc="date --utc +%FT%TZ"

# Sneak my custom .bashrc cfg in here rather than having to figure out a way to (idempotently) add a `source ~/.raphaelize/.bashrc` to ~/.bashrc
if [ -f ~/.raphaelize/.bashrc_overrides ]; then
    . ~/.raphaelize/.bashrc_overrides
fi
