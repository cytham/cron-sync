#!/usr/bin/env bash

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

/usr/bin/rsync -a --info=name --exclude-from="${SCRIPT_DIR}"/tmp/exclude-cp.txt --log-file="${SCRIPT_DIR}"/cron-sync.log --temp-dir="${SCRIPT_DIR}"/tmp/ ${1} ${2} | grep -v '/$' > "${SCRIPT_DIR}"/tmp/ex_tmp.txt

if [ -z "$3" ]; then
    cat "${SCRIPT_DIR}"/tmp/ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/exclude-cp.txt
else
    grep -v ${3} "${SCRIPT_DIR}"/tmp/ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/exclude-cp.txt
    grep -v ${3} "${SCRIPT_DIR}"/tmp/exclude-cp.txt > "${SCRIPT_DIR}"/tmp/exclude-cp.tmp
    mv "${SCRIPT_DIR}"/tmp/exclude-cp.tmp "${SCRIPT_DIR}"/tmp/exclude-cp.txt
fi
