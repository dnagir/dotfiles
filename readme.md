## Dima's dotfiles

The ones that can be public at least.

Pre-requisites:

- Tools:
  - `git`
  - `bw` (BitWarden CLI)
  - `jq`
  - `gpg`
  - `base64` (`coreutils` on Linux)
- SSH:
  - agent is installed
  - new SSH keys are setup
  - the SSH public keys is [added to GitHub](https://github.com/settings/keys).

Run:

```sh
git clone git@github.com:dnagir/dotfiles.git $HOME`
$HOME/dotfiles/install.sh
$HOME/dotfiles/install-secrets.sh
```
