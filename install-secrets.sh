#!/bin/bash
# This requires 'lpass login' first

lpass show 3028927856830506403 --field 'Private Key' > ~/.ssh/id_rsa
lpass show 3028927856830506403 --field 'Public Key' > ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub


lpass show 3935622711685572767 --field 'Private Key' | gpg --import
