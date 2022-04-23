
# https://security.stackexchange.com/questions/162552/gpg-fingerprint-prints-out-completely-different-fingerprint
alias gpg-list-all="gpg --list-keys --with-subkey-fingerprints --with-keygrip"
alias gpg-list-all-secret="gpg --list-secret-keys --with-subkey-fingerprints --with-keygrip"


alias gal="gcloud auth login"
alias mgrep="ll; grep -RHinE $1 $2 | grep -v Binary | sort -t: -k1,1d -k2,2g"

alias utc="date -u +%FT%TZ"


alias gsu="git submodule update --init --recursive"
alias gf="git fetch --all"
