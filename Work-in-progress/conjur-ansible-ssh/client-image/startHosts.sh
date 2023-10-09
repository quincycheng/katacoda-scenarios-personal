#!/bin/bash

docker run --name sshd1 -P -d quincycheng/killercoda-sshd-host:latest
docker run --name sshd2 -P -d quincycheng/killercoda-sshd-host:latest

