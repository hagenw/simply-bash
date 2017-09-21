# Units library

source "math.sh"

# $1 - value in pt
units::pt_to_inch() {
    local pt="$1"
	local inch
    inch=$(math::divide ${pt} 72)
	echo ${inch}
}

# $1 - value in inch
# $2 - resolution in ppi
units::inch_to_px() {
	local inch="$1"
	local res="$2"
	local px
	px=$(math::multiply ${inch} ${res})
	echo ${px}
}

# $1 - value in pt
# $2 - resolution in ppi
units::pt_to_px() {
    local pt="$1"
    local res="$2"
    local inch
    local px
    inch=$(units::pt_to_inch ${pt})
    px=$(units::inch_to_px ${inch} ${res})
    echo ${px}
}
