#!/usr/bin/env bash
export REGISTRY=gcr.io/syntasa-devops-sandbox
export DEPLOYER_TAG=5.0.2
export TAG=latest
export APP_NAME=syntasa

docker build \
--build-arg REGISTRY=$REGISTRY \
--build-arg APP_NAME=$APP_NAME \
--build-arg TAG=$TAG \
--tag $REGISTRY/$APP_NAME/deployer:$DEPLOYER_TAG .

docker push $REGISTRY/$APP_NAME/deployer:$DEPLOYER_TAG