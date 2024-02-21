#!/usr/bin/env bash

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

if [ "${3}" -eq 0 ]; then
    DNAME=`basename "${1}"`
    if [ ! -f "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt ]; then
        touch "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
    fi
    /usr/bin/rsync -a --info=name --exclude-from="${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt --log-file="${SCRIPT_DIR}"/cron-sync.log --temp-dir="${SCRIPT_DIR}"/tmp/ ${1} ${2} | grep -v '/$' > "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt
    if [ -z "${4}" ]; then
        cat "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
    else
        grep -v ${4} "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
        grep -v ${4} "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt > "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.tmp
        mv "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.tmp "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
    fi
else
    cd "${1}"
    dirlist=(`find . -mindepth "${3}" -maxdepth "${3}" -type d`)
    for i in ${dirlist[*]};
        do  
            DNAME=`basename "${i}"`
            if [ ! -f "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt ]; then
                touch "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
            fi
            /usr/bin/rsync -aR --info=name --exclude-from="${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt --log-file="${SCRIPT_DIR}"/cron-sync.log --temp-dir="${SCRIPT_DIR}"/tmp/ ${i} ${2} | grep -v '/$' > "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt
            if [ -z "${4}" ]; then
                cat "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
            else
                grep -v ${4} "${SCRIPT_DIR}"/tmp/"${DNAME}"_ex_tmp.txt >> "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt
                grep -v ${4} "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt > "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.tmp  # Case for new regex additions
                mv "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.tmp "${SCRIPT_DIR}"/tmp/"${DNAME}"_exclude.txt  # Case for new regex additions
            fi
        done
fi