#!/usr/bin/env bash

sudo apt install curl gnupg2 ca-certificates lsb-release
echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

sudo apt update
sudo apt install nginx