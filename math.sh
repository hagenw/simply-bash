# Math library

[ -v "PI" ] || PI='3.14159265358979323846264338327950288'; declare -r PI
BC_PRECISSION=8

# $1 - math expression to be performed by bc
_bc() {
    local expression=$1
    echo "scale=${BC_PRECISSION}; ${expression}" | bc -lq
}

# $1 + $2
math::plus() {
    local x1=$1
    local x2=$2
    _bc "${x1} + ${x2}"
}

# $1 - $2
math::minus() {
    local x1=$1
    local x2=$2
    _bc "${x1} - ${x2}"
}

# $1 / $2
math::divide() {
    local x1=$1
    local x2=$2
    _bc "${x1} / ${x2}"
}

# $1 * $2
math::multiply() {
    local x1=$1
    local x2=$2
    _bc "${x1} * ${x2}"
}

# $1 ^ $2
math::power() {
    local x=$1
    local n=$2
    _bc "${x} ^ ${n}"
}
         
# sqrt($1)
math::sqrt() {
    local x=$1
    _bc "sqrt(${x})"
}

# exp($1)
math::exp() {
    local x=$1
    _bc "e(${x})"
}

# sin($1)
math::sin() {
    local x=$1
    _bc "s(${x})"
}

# cos($1)
math::cos() {
    local x=$1
    _bc "c(${x})"
}

# tan($1)
math::tan() {
    local x=$1
    _bc "x = ${x}
         c = c(x)
         if(c == 0) { c = A^-scale }
         s(x) / c"
}

# floor($1)
math::floor() {
    local x=$1
    _bc "scale = 0; x = ${x}
         xx = x / 1
         if(xx > x) { .= xx-- }
         xx"
}

# ceil($1)
math::ceil() {
    local x=$1
    _bc "scale = 0; x = ${x}
         if (x > 0) {
           x / 1 + 1
         } else {
           x / 1
         }"
}

# round($1)
math::round() {
    local x=$1
    _bc "scale = 0; x = ${x}
         if (x > 0) {
           xx = x + 0.5
         } else if (x < 0) {
           xx = x - 0.5
         }
         xx / 1"
}

# abs($1)
math::abs() {
    local x=$1
    _bc "x = ${x}
         if (x < 0) {
            -x
         } else {
            x
         }"
}
