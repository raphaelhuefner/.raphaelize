
OS=`uname`

case "$OS" in
  Darwin)
    alias utc="date -u +%FT%TZ"
    alias uuid="uuidgen | tr [:upper:] [:lower:]"

    alias pr="httpsignature-proxy start --verbose-mode --listen --show-webhook-headers --ui"

    ;;
  Linux)
    alias utc="date --utc +%FT%TZ"
    alias uuid="python3 -c 'import uuid; print(uuid.uuid4())'"

    ;;
  *)
    echo "unknown operating system"
    ;;
esac

if command -v docker 1>/dev/null 2>&1; then
  alias docker-clean-all="docker container rm \`docker container ls -aq\`"
  alias docker-clean-exited="docker container rm \`docker container ls --filter status=exited -q\`"
fi

if command -v gpg 1>/dev/null 2>&1; then
  # https://security.stackexchange.com/questions/162552/gpg-fingerprint-prints-out-completely-different-fingerprint
  alias gpg-show="gpg --show-keys --with-subkey-fingerprints --with-keygrip"
  alias gpg-list-all="gpg --list-keys --with-subkey-fingerprints --with-keygrip"
  alias gpg-list-all-secret="gpg --list-secret-keys --with-subkey-fingerprints --with-keygrip"
  alias gpg-switch-card='gpg-connect-agent "scd serialno" "learn --force" /bye'
fi

if command -v http 1>/dev/null 2>&1; then
  alias https='http --default-scheme=https'
fi

if command -v gcloud 1>/dev/null 2>&1; then
  alias gal="gcloud auth login"
fi

if command -v git 1>/dev/null 2>&1; then
  alias gf="git fetch --all --tags --prune"
  alias gfm="git fetch --all --tags --prune; git branch -f main origin/main"
  alias gsu="git submodule update --init --recursive"
  alias gco="git checkout -b $1 origin/$1"
fi

if command -v pass 1>/dev/null 2>&1; then
  alias p1="pass 1 -c"
  alias bw="pass bw -c"
fi

alias mgrep="lll; grep -RHinE $1 $2 | grep -v Binary | sort -t: -k1,1d -k2,2g"
alias rnd="python3 -c 'import random, string, sys; print(\"\".join(random.choices(string.digits + string.ascii_letters, k=int(sys.argv[1]) if len(sys.argv) > 1 else 256)))'"

# Sneak my custom .bashrc cfg in here rather than having to figure out a way to (idempotently) add a `source ~/.raphaelize/.bashrc` to ~/.bashrc
if [ -f ~/.raphaelize/.bashrc_overrides ]; then
    . ~/.raphaelize/.bashrc_overrides
fi
