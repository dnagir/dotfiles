#!/bin/bash
set -euo pipefail

echo >&2 "Installing SSH Keys from LastPass"
mkdir -p $HOME/.ssh/
lpass show 3028927856830506403 --field 'Private Key' > $HOME/.ssh/id_rsa
lpass show 3028927856830506403 --field 'Public Key' > $HOME/.ssh/id_rsa.pub

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub


echo >&2 "Importing the GPG Private Key"
lpass show 3935622711685572767 --field 'Private Key' | gpg --import
