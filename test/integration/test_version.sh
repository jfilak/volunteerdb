#!/usr/bin/env bash

set -o nounset

declare -r ERR_mktemp=3
declare -r ERR_startup=4
declare -r ERR_connect=5
declare -r ERR_data=5

declare -r TEST_PORT=54321

set -x
pushd $(mktemp -d -t volunteerdb.test_version.XXXXXX) || exit ${ERR_mktemp}

${PROJECT_BIN}/volunteerdb -port ${TEST_PORT} >stdout.log 2>stderr.log &
sleep 1

curl "http://localhost:${TEST_PORT}/version" | tee response.log
result=$?
kill %1

cat stdout.log
cat stderr.log

test "$result" == "0" || exit ${ERR_connect}

test "{ \"Query\": \"$(cat ${PROJECT_ROOT}/VERSION)\" }" == "$(cat response.log)" || exit  ${ERR_data}
