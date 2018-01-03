Simply Bash
===========

Bash scripts and libraries to make your life easier.


## Scripts

### `pdf2png`

Generate a thumbnail of the given PDF file as a compressed PNG file.
Example:

```sh
$ pdf2png --max-size 400 --page 2 --output page2_400px.png input.pdf
```

### `filesize`

Returns the file size in bytes.
Example:

```sh
$ filesize $(which filesize)
47
```

### `warning` and `error`

`warning` and `error` show the provided message and copy it to the stderr
with `>&2`. Examples:

```sh
$ warning "Problem"
Warning: Problem
$ echo $0
0
```

```sh
$ error "Failed"
Error: Failed
$ echo $?
1
```


## Libraries

### `math.sh`

Provide mathematical expressions for real valued calculations in your bash
scripts.

Usage:

```bash
source math.sh
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

Converting between pixels, points, and inches.

Usage:

```bash
source units.sh
res_in_ppi=300
units::pt_to_inch 300            # 4.16666666
units::inch_to_px 4 $res_in_ppi  # 1200
units::pt_to_px 20 $res_in_ppi   # 83.33333100
```

### `pyenvs.sh`

Manage python virtual environments in the folder `$HOME/.envs`. 

Usage:

```bash
source pyenvs.sh
create env_name python3  # create virtual `env_name` and activate it
envs                     # list available environments
activate env_name        # activate virtual environment `env_name`
```

Note: once you activated an virtual environment, it will provide you with the
command `deactivate` to stop it.
