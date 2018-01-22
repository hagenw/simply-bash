#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd -P )
RES_IN_PPI=300

source "${DIR}/simply-bash.sh"
source "${DIR}/tests/assert.sh"

# assert <command> <expected stdout> [stdin]

# math.sh
include "math.sh"
assert "math::plus 1 2" "3"
assert "math::minus 3 2" "1"
assert "math::divide 6 2" "3.00000000"
assert "math::multiply 3 2" "6"
assert "math::power 2 3" "8"
assert "math::sqrt 9" "3.00000000"
assert "math::exp 0" "1.00000000"
assert "math::sin ${PI}" "0"
assert "math::cos ${PI}" "-1.00000000"
assert "math::tan ${PI}" "0"
assert "math::floor 0.1" "0"
assert "math::ceil 0.1" "1"
assert "math::round 0.5" "1"
assert "math::abs -1" "1"

# units.sh
include "units.sh"
assert "units::pt_to_inch 300" "4.16666666"
assert "units::inch_to_px 4 ${RES_IN_PPI}" "1200"
assert "units::pt_to_px 20 ${RES_IN_PPI}" "83.33333100"

# end of tests
assert_end
