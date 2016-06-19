#!/bin/bash -e

# Auto merge only in PR
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
  printf 'Automerging is just allowed in pull requests\n'
else
  printf 'TRAVIS_BRANCH=%s, PR=%s, BRANCH=%s\n' "$TRAVIS_BRANCH" "$PR" "$BRANCH"

  printf 'Automerging...\n'

  : "${GITHUB_SECRET_TOKEN?}" "${TRAVIS_REPO_SLUG?}"

  # Since Travis does a partial checkout, we need to get the whole thing
  repo_temp=$(mktemp -d)
  git clone "https://github.com/$TRAVIS_REPO_SLUG" "$repo_temp"

  # shellcheck disable=SC2164
  cd "$repo_temp"

  printf 'Checking out %s\n' "$TRAVIS_BRANCH"
  git checkout "$TRAVIS_BRANCH"

  git config user.name "Travis CI"
  git config user.email travis@ci.com

  printf 'Merging %s\n' "$BRANCH"
  git merge --no-ff --no-edit origin/"$BRANCH"

  push_uri="https://$GITHUB_SECRET_TOKEN@github.com/$TRAVIS_REPO_SLUG"

  printf 'Pushing to %s\n' "$TRAVIS_BRANCH"
  git push "$push_uri" "$TRAVIS_BRANCH"

  printf 'Deleting branch %s\n' "$BRANCH"
  git push "$push_uri" :"$BRANCH"

fi
