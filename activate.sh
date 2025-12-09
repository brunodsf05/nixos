#!/usr/bin/env sh

set -e

sudo NIX_CONFIG="experimental-features = nix-command flakes" \
    nixos-rebuild switch --flake .
