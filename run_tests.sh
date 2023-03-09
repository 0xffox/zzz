#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/tests
for test in test*.sh; do
    echo "Running tests from $test..."
    bash "$test"
done
