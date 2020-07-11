#!/bin/sh

BRANCH=$(git symbolic-ref --short HEAD)

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git checkout -b $BRANCH
  git add ./*/result/ *.*
  git commit --message "[skip ci] Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin https://${GH_TOKEN}@github.com/TRAVIS_REPO_SLUG.git > /dev/null 2>&1
  git push --quiet --set-upstream origin $BRANCH
}

setup_git
commit_website_files
upload_files
