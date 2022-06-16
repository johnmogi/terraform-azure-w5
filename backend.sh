#!/bin/sh
apt update
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
apt install docker-ce -y
docker pull postgres:latest
docker run -d --restart=unless-stopped --name measurements -p 5432:5432 -e 'POSTGRES_PASSWORD=p@ssw0rd42' postgres
