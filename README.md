# REXX to OS/2 executable wrapper

This repository cointains a set of tools for converting REXX scripts to OS/2 executables originally written by Veit Kannegieser (veit@kannegieser.net).

The repository was started by importing a binary distribution of version 2006.4.10 of the tools from http://hobbes.nmsu.edu/download/pub/os2/dev/rexx/rexx_exe.zip with the following modifications:

- All .EXE files generated from the corresponding .CMD files were removed.
- README.md (this file) was added.

Note that there are also original author's archives in ARJ format for both the binaries and the sources for the stub programs on the author's page:

- http://kannegieser.net/veit/programm/rexx_exe.arj
- http://kannegieser.net/veit/quelle/rexx_exe_src.arj

We didn't import the sources for the stubs as they are in Pascal and our build environment doesn't support Pascal at the moment.
