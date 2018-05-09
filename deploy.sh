#!/bin/bash

set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)

cd build

git clone -b gh-pages https://github.com/Ai-Thinker-Open/GPRS_C_SDK_DOC.git ./old

mv ./old/en ./en

rm -rf ./old

git initgit config user.name $GIT_NAME

git config user.email $GIT_EMAIL

git remote add upstream "https://$GITHUB_TOKEN@github.com/Ai-Thinker-Open/GPRS_C_SDK_DOC.git"

git fetch upstream && git reset upstream/gh-pages

# echo "gprs.ai-thinker.com" > CNAME

git add -A

git commit -m "rebuild pages at ${rev}"

git push --force -q upstream HEAD:gh-pages
