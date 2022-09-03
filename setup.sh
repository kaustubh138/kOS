#!/bin/bash

if ! [ $(id -u) = 0 ]
then
	echo "[ERROR] This script must be run ad root!"
	exit 1
else
	REAL_USER=$SUDO_USER
fi

echo "[INFO] Installing dependencies"

DEP="dpkg build-essential nasm qemu-system-x86"
apt install -y ${DEP}