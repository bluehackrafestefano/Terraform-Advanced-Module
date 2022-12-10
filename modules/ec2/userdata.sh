#!/bin/bash
hostnamectl set-hostname ${server-name}
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 8080