#!/bin/bash

echo "Installing AMBCT..."

wget -q https://raw.githubusercontent.com/BlitzPythoner/AMBCT-Repo/main/public.key -O /tmp/ambct.key
gpg --dearmor < /tmp/ambct.key | sudo tee /usr/share/keyrings/ambct.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/ambct.gpg] https://raw.githubusercontent.com/BlitzPythoner/AMBCT-Repo/main stable main" | sudo tee /etc/apt/sources.list.d/ambct.list

sudo apt update
sudo apt install -y ambct

echo "Done."