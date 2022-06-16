#!/bin/sh
apt update -y
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null -y
  apt update -y
  apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  docker pull postgres:latest -y
docker run -d  --restart=unless-stopped --name measurements -p 5432:5432 -e 'POSTGRES_PASSWORD=p@ssw0rd42' postgres
