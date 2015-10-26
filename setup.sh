#!/usr/bin/env bash -xe

if [[ "$(uname)" != "Darwin" ]]; then
  echo 'This setup only runs on OS X machines'
  exit 1
fi

# Install Command Line Tools if not yet installed.
xcode-select -p 1>/dev/null || xcode-select --install

mkdir -p ~/github

rm -rf ~/github/dideler/dotfiles
git clone https://github.com/dideler/dotfiles.git ~/github/dideler/dotfiles # HTTPS clone avoids SSH setup.
pushd ~/github/dideler/dotfiles
  bash link_dotfiles -f
popd

rm -rf ~/github/dideler/setup-osx
git clone https://github.com/dideler/setup-osx.git ~/github/dideler/setup-osx # HTTPS clone avoids SSH setup.
pushd ~/github/dideler/setup-osx
  # TODO: Some of these can probably run in parallel. And maybe use nohup?
  bash settings/osx-defaults \
  && bash package-managers/homebrew \
  && bash package-managers/npm \
  && bash languages/node \
  && bash languages/ruby \
  && bash package-managers/gems \
  && bash languages/python3 \
  && bash shells/fish
popd
