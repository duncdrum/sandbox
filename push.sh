#!/bin/sh
# https://www.vinaygopinath.me/blog/tech/commit-to-master-branch-on-github-using-travis-ci/
BRANCH=$(git rev-parse --abbrev-ref HEAD)

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_files() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  git checkout shell-push
  git add ./*/result/ *.*
  git commit --message "[skip ci] Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add new-origin https://duncdrum:${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git > /dev/null 2>&1
  git push new-origin shell-push --quiet
}

setup_git
commit_files
upload_files
