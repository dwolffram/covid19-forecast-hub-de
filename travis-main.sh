#!/usr/bin/env bash

set -e

if [[ "$TRAVIS_COMMIT_MESSAGE" == "[TRAVIS] Autogenerated files from travis" ]]; then
    echo "This is an auto commit from travis. Not doing anything."
    exit 0
fi

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    echo "Not on master. Not doing anything else."
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`


echo "Running test script..."
npm install
sudo apt-get install python3-pandas
sudo apt install python3-pip
pip3 install --upgrade setuptools
pip3 install pymmwr click requests urllib3 selenium webdriver-manager pyyaml
pip3 install git+https://github.com/reichlab/zoltpy/
source ./travis/validate-data.sh
echo "build complete"
