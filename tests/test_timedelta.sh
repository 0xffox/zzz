#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../zzz > /dev/null



testTimedelta_OnlySeconds() {
    local seconds=($(delta2seconds 30s))
    assertEquals "Only seconds should parse correctly" '30' "$seconds"
}

testTimedelta_OnlyMinutes() {
    local seconds=($(delta2seconds 30m))
    assertEquals "Only minutes should parse correctly" '1800' "$seconds"
}

testTimedelta_OnlyHours() {
    local seconds=($(delta2seconds 3h))
    assertEquals "Only hours should parse correctly" '10800' "$seconds"
}

testTimedelta_OnlyDays() {
    local seconds=($(delta2seconds 3d))
    assertEquals "Only days should parse correctly" '259200' "$seconds"
}

testTimedelta_MinutesSeconds() {
    local seconds=($(delta2seconds 1m30s))
    assertEquals "Minutes and seconds should parse correctly" '90' "$seconds"
}

testTimedelta_SecondsMinutes() {
    local seconds=($(delta2seconds 30s1m))
    assertEquals "Only seconds should parse correctly" '90' "$seconds"
}

testTimedelta_BigSeconds(){
    local seconds=($(delta2seconds 3000s))
    assertEquals "Big seconds should parse correctly" '3000' "$seconds"
}
testTimedelta_BigMinutesBigSeconds(){
    local seconds=($(delta2seconds 80m3000s))
    assertEquals "Big minutes and big seconds should parse correctly" '7800' "$seconds"
}

. shunit2
