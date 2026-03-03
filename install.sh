#!/usr/bin/env bash
# Sets up symlinks so bash and fish find our dotfiles configs.
# Run once after cloning the repo: cd ~/dotfiles && ./install.sh

# "set -e" means: if any command fails, stop the script immediately
# instead of continuing. Safety net so we don't end up in a half-broken state.
set -e

# Use $DOTFILES if you've set it, otherwise default to ~/dotfiles.
# ${VAR:-default} is bash syntax for "use VAR if set, else use default".
# $HOME is your home directory (e.g. /root or /home/yourname).
DOTFILES="${DOTFILES:-$HOME/dotfiles}"

# cd into the repo so we know we're in the right place.
cd "$DOTFILES"

# Create a symlink: ~/.bashrc -> ~/dotfiles/.bashrc
# ln = "link", -s = "symbolic" (symlink, not hardlink), -f = "force" (overwrite if exists).
# After this, when bash opens ~/.bashrc on startup, the OS redirects it to
# our repo copy at ~/dotfiles/.bashrc. One file, accessible from both paths.
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"

# Fish expects its config at ~/.config/fish/config.fish.
# mkdir -p creates the directory (and any parents) if it doesn't exist.
# -p means "no error if it already exists, create parent dirs as needed".
mkdir -p "$HOME/.config/fish"

# Same idea: ~/.config/fish/config.fish -> ~/dotfiles/config.fish
ln -sf "$DOTFILES/config.fish" "$HOME/.config/fish/config.fish"

echo "Linked .bashrc and config.fish from $DOTFILES"
