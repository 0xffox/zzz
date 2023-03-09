#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../zzz > /dev/null

testTags_FilterPlusTags() {
    local tags=($(filterTags + "hello from +tag world+hell +work"))
    assertEquals "Tag have to be in tags" 'tag' "${tags[0]}"
    assertEquals "work have to be in tags" 'work' "${tags[1]}"
    # TODO: vvv Why this test doesn't work?!
    # assertEquals "Tags length have to be 2" '2' "${#tags}"
}

testTags_FilterMinusTags() {
    local tags=($(filterTags - "hello from -tag world-hell -work"))
    assertEquals "Tag have to be in tags" 'tag' "${tags[0]}"
    assertEquals "work have to be in tags" 'work' "${tags[1]}"
    assertEquals "Tags length have to be 2" '2' "${#tags[@]}"
}

testTags_AppendPlusAsTagSign() {
    local sign_tags=($(appendSignToTags + "hello world"))
    assertEquals "+hello have to be in sign tags" '+hello' "${sign_tags[0]}"
    assertEquals "+world have to be in sign tags" '+world' "${sign_tags[1]}"
}

testTags_AppendMinusAsTagSign() {
    local sign_tags=($(appendSignToTags - "hello world"))
    assertEquals "-hello have to be in sign tags" '-hello' "${sign_tags[0]}"
    assertEquals "-world have to be in sign tags" '-world' "${sign_tags[1]}"
}

# ============================================================================

testTags_MatchNoneTags() {
    local task="Answer email +work +email"
    assertEquals "Should match without anytags" "OK" "`matchTags "$task"`"
}

testTags_MatchOnlyPositiveTags() {
    local task="Answer email +work +email"
    assertEquals "Should match work tag" "OK" "`matchTags "$task" "+work"`"
    assertEquals "Should match email tag" "OK" "`matchTags "$task" "+email"`"
    assertEquals "Should match both work and email tag" "OK" \
        "`matchTags "$task" "+work +email"`"
    assertEquals "Shouldn't match hobby tag" "" "`matchTags "$task" "+hobby"`"
}

testTags_MatchOnlyNegativeTags() {
    local task="Answer email +work +email"
    assertEquals "Should match hobby tag" "OK" "`matchTags "$task" "" "+hobby"`"
    assertEquals "Shouldn't match work tag" "" "`matchTags "$task" "" "+work"`"
    assertEquals "Shouldn't match email tag" "" "`matchTags "$task" "" "+email"`"

}

testTags_MatchPositiveAndNegativeTags() {
    local task="Answer email +work +email"
    assertEquals "Should match work tag" "OK" \
        "`matchTags "$task"  "+work" "+hobby"`"
    assertEquals "Should match email tag" "OK" \
        "`matchTags "$task" "+email" "+hobby"`"
    assertEquals "Should match both work and email tag" "OK" \
        "`matchTags "$task" "+work +email"`"
    assertEquals "Shouldn't match by negative email tag" "" \
        "`matchTags "$task" "+work" "+email"`"
    assertEquals "Shouldn't match by negative work tag" "" \
        "`matchTags "$task" "+email" "+work"`"
}

. shunit2
