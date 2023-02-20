#!/bin/bash
set -euo pipefail

echo >&2 "Installing SSH Keys from Bitwarden (remember to use bw unlock/login)!"
mkdir -p $HOME/.ssh/
bw get item c7e1f659-efd5-4c14-8607-afaf003a3d52 | jq -r '.fields[] | select(.name=="PrivateKey") | .value' > $HOME/.ssh/id_rsa
bw get item c7e1f659-efd5-4c14-8607-afaf003a3d52 | jq -r '.fields[] | select(.name=="PublicKey") | .value'  > $HOME/.ssh/id_rsa.pub

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub


echo >&2 "Importing the GPG Private Key"
lpass show 3935622711685572767 --field 'Private Key' | gpg --import
