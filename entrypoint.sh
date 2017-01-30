#!/bin/bash

# originally based on https://github.com/dinkel/docker-openldap

# When not limiting the open file descritors limit, the memory consumption of
# slapd is absurdly high. See https://github.com/docker/docker/issues/8231
ulimit -n 8192

set -e

WWW_DIR=/var/www/html
CONFIG=1

# check for required vars
if [[ -z "$CONFIG_REPO" ]]; then
    echo -n >&2 "Warning: no configuration repository is set "
    echo >&2 "Did you forget to add -e CONFIG_REPO=... ?"
    CONFIG=0
fi
if [[ -z "$CONFIG_USER" ]]; then
    echo -n >&2 "Warning: the user or team name is not set "
    echo >&2 "Did you forget to add -e CONFIG_USER=... ?"
    CONFIG=0
fi
if [[ -z "$CONFIG_PASS" ]]; then
    echo -n >&2 "Warning: the password or API key is not set "
    echo >&2 "Did you forget to add -e CONFIG_PASS=... ?"
    CONFIG=0
fi

if [[ CONFIG -eq 1 ]]; then
    # reset content directory
    rm -rf ${WWW_DIR}/*

    # clone the git repo
    echo "cloning config repository..."
    git clone https://${CONFIG_USER}:${CONFIG_PASS}@${CONFIG_REPO} /root/httpd-config

    # copy files to WWW_DIR
    echo "copying files to ${WWW_DIR}"
    cp -r /root/httpd-config/www/* ${WWW_DIR}/
fi

echo "starting the server"
exec "$@"