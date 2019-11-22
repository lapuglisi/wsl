#!/usr/bin/env bash

export DOCKER_HOST="tcp://localhost:2375"

if [ -d "${HOME}/.local/go" ];
then
	export PATH=${PATH}:${HOME}/.local/go/bin
fi

if [ "$1"!="zsh" ];
then
	exec zsh
fi
