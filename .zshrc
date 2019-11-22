#!/usr/bin/env zsh

export DEVENV_ROOT=`dirname $0:a:h`
export DEVENV_WSLROOT=$0:a:h
export DEVENV_APPROOT="${DEVENV_ROOT}/Applications";
export DEVENV_SRCROOT="${DEVENV_ROOT}/Sources";
export DEVENV_SYSROOT="${DEVENV_ROOT}/System";

function gosrc()
{
	if [ -z "$1" -o ! -d "${DEVENV_SRCROOT}/$1" ];
	then
		dst_dir="${DEVENV_SRCROOT}/";
		vared -h -p "Where to? " dst_dir;

		cd "${dst_dir}";
	else
		cd "${DEVENV_SRCROOT}/$1";
	fi
}

function goroot()
{
	if [ -z "$1" -o ! -d "${DEVENV_ROOT}/$1" ];
	then
		dst_dir="${DEVENV_ROOT}/";
		vared -h -p "Where to? " dst_dir;

		cd "${dst_dir}";
	else
		cd "${DEVENV_ROOT}/$1";
	fi
}

function gosys()
{
	if [ -z "$1" -o ! -d "${DEVENV_SYSROOT}/$1" ];
	then
		dst_dir="${DEVENV_SYSROOT}/";
		vared -h -p "Where to? " dst_dir;

		cd "${dst_dir}";
	else
		cd "${DEVENV_SYSROOT}/$1";
	fi
}

function dkbash()
{
	local container=$1;
	local shell_user=$2;
	if [ -z "$container" ];
	then
		echo;
		echo "usage: ";
		echo "dkbash CONTAINER [USER]";
		echo;

		return;
	fi

	if [ -z "$shell_user" ];
	then
		docker exec -ti ${container} bash --login;
	else
		docker exec -it ${container} bash -c "su - $shell_user";
	fi
}

function dkzsh()
{
	local container=$1;
	local shell_user=$2;
	if [ -z "$container" ];
	then
		echo;
		echo "usage: ";
		echo "dkzsh CONTAINER [USER]";
		echo;

		return;
	fi
	
	if [ -z "$shell_user" ];
	then
		docker exec -ti ${container} zsh --login;
	else
		docker exec -it ${container} zsh -c "su - $shell_user";
	fi
}

function dkgui()
{
	local container=$1;
	local shell_user=$2;
	if [ -z "$container" ];
	then
		echo;
		echo "usage: ";
		echo "dkgui CONTAINER [USER]";
		echo;

		return;
	fi

	docker_display="host.docker.internal:0"
	
	docker exec --env DISPLAY=${docker_display} -ti ${container} gnome-terminal --display=${docker_display} -- bash -c "su - ${shell_user}";
}

function wpath()
{
	target="$1";

	# Is our environment ok?
    if [ -z "${DEVENV_ROOT}" ];
	then
		echo "[wpath] DEVENV_ROOT is not defined.";
		echo "Goodbye".

		return 1;
	fi

	# What to translate?
	if [ -z "${target}" ];
	then
		echo;
		echo "usage:";
		echo "    wpath WSL_DIR";
		echo;
		return 1;
	fi
	
	# Is 'target' a valid directory?
	if [ ! -d "${target}" ];
	then
		echo;
		echo "[wpath] '${target}' is not a valid directory.";
		echo;
		return 1;
	fi

	dev_drive=$(echo "${DEVENV_ROOT}" | sed 's+/mnt/++');
	wdir=$(echo "${target}" | sed "s+${DEVENV_ROOT}+${dev_drive}\:+");

	echo "$wdir";
}

alias dkshell='dkbash';
alias code="'${DEVENV_APPROOT}/Microsoft VS Code/bin/code'";
alias sc='sc.exe';

[[ -d "${HOME}/.local/bin" ]] && export PATH="${PATH}:${HOME}/.local/bin";

# Checks for additional scripts
kuberc="${DEVENV_WSLROOT}/.kuberc";
[[ -f "${kuberc}" ]] && source "${kuberc}";

netshrc="${DEVENV_WSLROOT}/.netshrc";
[[ -f "${netshrc}" ]] && source "${netshrc}";

unset kuberc;
unset netshrc;

echo "Thank you for choosing zsh!";
