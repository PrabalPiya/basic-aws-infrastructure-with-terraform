#!/bin/bash

yum update -y
yum install -y docker

systemctl start docker
systemctl enable docker

docker run -d \
  --name devops-nginx \
  -p 80:80 \
  nginx:latest