#!/usr/bin/env bash

set -e

echo "==> Installing AMBCT..."

KEYRING="/usr/share/keyrings/ambct.gpg"
SOURCE_LIST="/etc/apt/sources.list.d/ambct.list"
REPO_URL="https://blitzpythoner.github.io/AMBCT-Linux-Repo"

# Check for root
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run this script as root (sudo)."
    exit 1
fi

echo "==> Installing GPG key..."

curl -fsSL "$REPO_URL/public.key" | gpg --dearmor -o "$KEYRING"

chmod 644 "$KEYRING"

echo "==> Adding repository..."

echo "deb [signed-by=$KEYRING] $REPO_URL stable main" > "$SOURCE_LIST"

echo "==> Updating package lists..."
apt update

echo "==> Installing ambct..."
apt install -y ambct

echo "==> Done."
