# Simply Bash [![Build][travis-image]][travis-url]

Bash scripts and libraries to make your life easier.

[travis-image]: https://img.shields.io/travis/hagenw/simply-bash.svg?branch=master
[travis-url]: https://travis-ci.org/hagenw/simply-bash


## Installation with package manager

The easiest way to install [simply-bash] is via [basher]:

```bash
$ basher install hagenw/simply-bash
```

Afterwards all binaries are directly available and libraries can be included via

```bash
include hagenw/simply-bash lib/math.sh
```


## Installation from repository

To manually install it from this repository, clone it with:

```bash
git clone https://github.com/hagenw/simply-bash.git ~/git/simply-bash
```

Replace `~/git/simply-bash` with your desired directory.

In order to use it you have to source the `simply-bash.sh` file:

```bash
source ~/git/simply-bash/simply-bash.sh
```

To automate this, add it to your `.bashrc`.  Afterwards the libraries can be
included with:

```bash
include lib/math.sh
```

[simply-bash]: https://github.com/hagenw/simply-bash
[basher]: https://github.com/basherpm/basher


## Usage

Every script comes with a help message explaining all of it options, e.g. `is
--help`. In the following only short examples are shown to demonstrate the main
purpose of the scripts. The included functions of the libraries are all shown.

### `is`

Replacement for test command, included from [is.sh].
Example:
```sh
var=123

if is equal $var 123.0; then
    echo "it just works"
fi

if is not a substring $var "foobar"; then
    echo "and it's easy to read"
fi
```

[is.sh]: https://github.com/qzb/is.sh

### `filesize`

Return the file size in bytes.
Example:

```sh
$ filesize $(which filesize)
47
```

### `randomstring`

Return a random alphanumeric string.
Example:

```sh
$ randomstring --length 8
75v4dvoH
```

### `tmpfile`

Create a temp file and return its name.
Example:

```sh
$ tmpfile --basename myprog
/tmp/myprog-Gsfg6p
```

### `warning` and `error`

Show the provided message and copy it to stderr with `>&2`.
Examples:

```sh
$ warning "Problem"
Warning: Problem
$ echo $?
0
```

```sh
$ error "Failed"
Error: Failed
$ echo $?
1
```

### `math.sh`

Provide mathematical expressions for real valued calculations in your bash
scripts.

Usage:

```bash
source lib/math.sh
math::plus 1 2      # 3
math::minus 3 2     # 1
math::divide 6 2    # 3.00000000
math::multiply 3 2  # 6
math::power 2 3     # 8
math::sqrt 9 3      # 3.00000000
math::exp 0         # 1.00000000
math::sin $PI       # 0
math::cos $PI       # -1.00000000
math::tan $PI       # 0
math::floor 0.1     # 0
math::ceil 0.1      # 1
math::round 0.5     # 1
math::abs -1        # 1
```

### `units.sh`

Convert between pixels, points, and inches.

Usage:

```bash
source lib/units.sh
res_in_ppi=300
units::pt_to_inch 300            # 4.16666666
units::inch_to_px 4 $res_in_ppi  # 1200
units::pt_to_px 20 $res_in_ppi   # 83.33333100
```

### `pyenvs.sh`

Manage python virtual environments with `virtualenv` in the folder
`$HOME/.envs`. Or with `conda` in the folder `$HOME/.conda/envs`.

Usage:

```bash
source lib/pyenvs.sh
envs tool                # see if virtualenv or conda is used
envs size                # disk size of environments
envs location            # dir where environments are stored
envs conda               # switch to use conda
envs virtualenv          # switch to use virtualenv
create env_name 2.7      # create `env_name` with python2.7 and activate it
envs                     # list available environments
activate env_name        # activate virtual environment `env_name`
deactivate               # deactivate the current active environment
delete env_name          # delete virtual environment `env_name`
```

You can change the folder where the environments are stored by exporting the
following variables:

```bash
export PYENVS_DIR_VIRTUALENV="${HOME}/.envs"
export PYENVS_DIR_CONDA="${HOME}/.conda/envs"
```

Just change the paths to the desired ones.
