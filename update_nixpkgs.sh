#!/bin/sh

nix flake lock --update-input nixpkgs &&
nix flake lock --update-input nixpkgs-unstable
