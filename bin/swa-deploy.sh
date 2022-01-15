#!/usr/bin/env bash
APP_NAME="angular-static-web-app"

check_if_package_installed() {
    cmd=$1
    bold=$(tput bold)
    normal=$(tput sgr0)
    if ! command -v $cmd &> /dev/null
    then
        echo "Error: command ${bold}$cmd${normal} could not be found."
        exit 1
    fi
}

check_if_package_installed "npm"
check_if_package_installed "ng"
check_if_package_installed "docker"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
(cd $SCRIPT_DIR/.. && \
    docker run --entrypoint "///bin/staticsites/StaticSitesClient" \
        --volume "//$(pwd)"/dist/$APP_NAME:///root/build \
        mcr.microsoft.com/appsvc/staticappsclient:stable \
        upload \
        --skipAppBuild true \
        --app //root/build \
        --apiToken 0c140344b4a34a5b97b815931578ff6189d5ce28f4534a2ff85fed0a9a27132e1-48566991-104d-4b86-a648-6e073140eb5700359583
)