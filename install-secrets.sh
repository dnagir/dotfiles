#!/bin/bash
set -euo pipefail

item=$(bw get item 9f3bebb3-7e33-40c5-80dc-b17400d6c3d5)

echo >&2
echo >&2 "Importing the GPG Private Key"
jq -cr '.fields[] | select(.name=="PrivateKey") | .value' <<< "$item" | base64 --decode | gpg --import


echo >&2
echo >&2 "Amending git config with the key"
jq -cr '.fields[] | select(.name=="KeyID") | .value' <<< "$item"| xargs -n1 git config --global user.signingkey

echo >&2
echo >&2 "Please add the below public key to GitHub"
jq -cr '.fields[] | select(.name=="PublicKey") | .value' <<< "$item" | base64 --decode
