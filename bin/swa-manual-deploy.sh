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

echo "Enter your SWA token: "  
read -s SWA_TOKEN

echo "Starting container..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
(cd $SCRIPT_DIR/.. && \
    docker run --entrypoint "///bin/staticsites/StaticSitesClient" \
        --volume "//$(pwd)"/dist/$APP_NAME://root/build \
        mcr.microsoft.com/appsvc/staticappsclient:stable \
        upload \
        --skipAppBuild true \
        --verbose true \
        --app //root/build \
        --apiToken $SWA_TOKEN \
)