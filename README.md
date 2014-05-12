# IPLC: Simple IPOPT-Matlab interface for linearly constrained optimization

## Download and install IPOPT `mex` files

```sh
$ cd toolbox
$ make
```

## Setup Matlab path

Add `iplc` to the path once:

```
>>> cd [iplc directory]
>>> iplc_setup
```

To install `iplc_load.m` into Matlab's `userpath`:

```
>>> iplc_setup('install')
```

The default Matlab `userpath` is `~/Documents/MATLAB`.  After install it is
possible to add `iplc` to the Matlab path with the command:

```
>>> iplc_load
```

This may be executed from any directory.
