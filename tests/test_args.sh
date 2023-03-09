#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../zzz > /dev/null

testArgs_NoAction() {
    local args=($(parseArgs))
    assertEquals "Without arguments get no action" 'no-action' "${args[0]}"
}

testArgs_DefTask() {
    local args=($(parseArgs 10s))
    assertEquals "With single interval argument action is def-task" 'def-task' "${args[0]}"
    assertEquals "With single interval argument seconds should parse correctly" '10' "${args[1]}"
    assertEquals "With single interval argument task name is <no-task>" '<no-task>' "${args[@]:2}"
}

testArgs_IndefTask() {
    local args=($(parseArgs hello))
    assertEquals "With single string arguemnt action is indef-task" 'indef-task' "${args[0]}"
    assertEquals "With single string arguemnt seconds should be zero" '0' "${args[1]}"
    assertEquals "With single string argument task name should parse correctly" 'hello' "${args[@]:2}"
}

testArgs_DefStats() {
    local args=($(parseArgs 30s --stats hello world))
    local task_name="${args[@]:2}"
    assertEquals "With interval and --stats argument action should be def-stats" 'def-stats' "${args[0]}"
    assertEquals "With interval and --stats argument seconds should parse correctly" '30' "${args[1]}"
    assertEquals "With interval and --stats argument task name should pass correctly" "hello world" "$task_name"
}

testArgs_IndefStats() {
    local args=($(parseArgs --stats hello world))
    local task_name="${args[@]:2}"
    assertEquals "With single --stats argument action should be indef-stats" 'indef-stats' "${args[0]}"
    assertEquals "With single --stats argument seconds should be zero" '0' "${args[1]}"
    assertEquals "With single --stats argument task name should parse correctly" 'hello world' "$task_name"
}

. shunit2
