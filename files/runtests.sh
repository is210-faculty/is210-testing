#!/bin/bash
# -*- coding: utf-8 -*-
#
# Testrunner for this repository.

# make sure the logdir exists
mkdir -p "${LOGDIR}"

# lint tests
find ./ -path "./tests" -prune -o -type f -iname "*.py" -print0 | while read -d $'\0' file
do
    if [ -z "${PYLINTRC}" ]
    then
        pylint "${file}" | tee -a "${LOGDIR}/pylint.log"
    else
        pylint --rcfile "${PYLINTRC}" "${file}" | tee -a "${LOGDIR}/pylint.log"
    fi
done

# unit tests
nosetests -d --with-xunit --xunit-file="${LOGDIR}/nosetest.xml" "${TESTDIR}"

