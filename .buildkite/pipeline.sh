#!/usr/bin/env bash
set +x

GITHUB_ORGANIZATION=${BUILDKITE_REPO#*:}
GITHUB_ORGANIZATION=${GITHUB_ORGANIZATION%/*}

RELEASE_NAME=$(buildkite-agent meta-data get release-name || echo "n/a")
CONFIRMATION=$(buildkite-agent meta-data get confirmation || echo "n/a")
DAY_OF_WEEK=$(date +%u)
RELEASE_SERVICE="ecr-cleaner-lambda"

# Define deploy hint based on the day of week
if [[ $DAY_OF_WEEK == "5" ]]; then
read -r -d '' deploy_hint << EOF
Hey, it's Friday... No one likes deploying on a Friday. But if you really need to, that's OK, but you gotta take responsibility! If it breaks, you gotta fix it!
EOF
else
read -r -d '' deploy_hint << EOF
With great power comes great responsibility!
EOF
fi

# Define release hint for Github release
read -r -d '' release_hint << EOF
It’s common practice to prefix your version names with the letter v. Some good tag names might be v1.0 or v2.3.4.
If the tag isn’t meant for production use, add a pre-release version after the version name. Some good pre-release versions might be v0.2-alpha or v5.9-beta.3.
EOF

set -e

# Master banch before Github release
if [ "$BUILDKITE_BRANCH" == 'master' ]  &&  [ "$GITHUB_ORGANIZATION" == 'bandsintown' ]; then

# Run Create releases and Deploy to ops
if [ "$CONFIRMATION" == "n/a" ]  &&   [ "$RELEASE_NAME" == "n/a" ]; then
cat <<EOF
steps:
  - label: ':hammer: Release package'
    command: .buildkite/release.sh
EOF
exit 0
fi
fi