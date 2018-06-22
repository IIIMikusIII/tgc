#!/bin/sh

BRANCH="$1"

[[ "${BRANCH}" == "master" ]] && exit 0

#git remote set-branches --add origin master
#git fetch origin master

DIFF="$(git diff --name-status origin/master..origin/${BITBUCKET_BRANCH} database-migrations/sql/)"

if [[ -n "${DIFF}" ]]; then
    echo "database migration files are immutable, please move your updates to a new migration"

    if [[ -n "$(echo "${DIFF}" | grep -E "^D")" ]]; then
        echo "deleted files were detected, check whether you merged latest master changes into ${BITBUCKET_BRANCH}"
    fi

    echo "${DIFF}"

    exit 1
fi
