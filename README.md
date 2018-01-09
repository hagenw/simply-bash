Simply Bash
===========

Bash scripts and libraries to make your life easier.


## Installation

As most of the scripts of this package source the included libraries, all files
of simply-bash have to be stored in the same folder. The easiest way to achieve
this is to clone the repository and add it to your `$PATH`:

```bash
git clone https://github.com/hagenw/simply-bash.git ~/git/simply-bash
echo 'PATH="${PATH}:${HOME}/git/simply-bash"' >> ~/.bashrc
```

Replace `~/git/simply-bash` with your desired directory.

Simply-bash depends on [is.sh], which must be installed as well by storing it in
the simply-bash folder or in another folder included in `$PATH`, e.g.

```bash
wget https://github.com/qzb/is.sh/raw/master/is.sh -O "${HOME}/.local/bin/is"
```

[is.sh]: https://github.com/qzb/is.sh


## Usage

### `pdf2png`

Generate a thumbnail of the given PDF file as a compressed PNG file.
Example:

```sh
$ pdf2png --max-size 400 --page 2 --output page2_400px.png input.pdf
```

### `pdfextract`

Extract pages from a PDF file.
Example:

```sh
$ pdfextract --pages "1 3-5" --output output.pdf input.pdf
```

### `pdfmerge`

Merge PDF files.
Example:

```sh
$ pdfmerge --output output.pdf input1.pdf input2.pdf input3.pdf
```

### `filesize`

Return the file size in bytes.
Example:

```sh
$ filesize $(which filesize)
47
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

Convert between pixels, points, and inches.

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
