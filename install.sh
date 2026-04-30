#!/usr/bin/env bash

set -e

REPO_URL="https://blitzpythoner.github.io/AMBCT-Linux-Repo"
KEY_URL="$REPO_URL/public.key"
KEYRING="/usr/share/keyrings/ambct.gpg"
SOURCE_LIST="/etc/apt/sources.list.d/ambct.list"

echo "==> Installing AMBCT..."

# Root check
if [[ "$EUID" -ne 0 ]]; then
    echo "Run this script with sudo."
    exit 1
fi

echo "==> Downloading and installing GPG key..."
curl -fsSL "$KEY_URL" | gpg --dearmor -o "$KEYRING"

chmod 644 "$KEYRING"

echo "==> Adding APT repository..."
echo "deb [signed-by=$KEYRING] $REPO_URL stable main" > "$SOURCE_LIST"

echo "==> Updating package list..."
apt update

echo "==> Installing ambct..."
apt install -y ambct

echo "==> Installation complete."
