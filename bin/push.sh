#!/bin/bash
set -e
ROOT_DIR="$(cd $(dirname $0)/..; pwd)"
cd $ROOT_DIR
docker build --rm -f docker/Dockerfile -t test-app:latest .

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 674582907715.dkr.ecr.ap-northeast-1.amazonaws.com

VERSION=$(date +"%Y%m%d.%H%M")

docker tag test-app:latest 674582907715.dkr.ecr.ap-northeast-1.amazonaws.com/test-app:latest
docker push 674582907715.dkr.ecr.ap-northeast-1.amazonaws.com/test-app:latest

docker tag test-app:latest 674582907715.dkr.ecr.ap-northeast-1.amazonaws.com/test-app:${VERSION}
docker push 674582907715.dkr.ecr.ap-northeast-1.amazonaws.com/test-app:${VERSION}
