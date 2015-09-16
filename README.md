# FORTRAN_dep_Solver

This repo provides a solution for building FORTRAN code.

There are solutions on line but they are not good (at least for my case).
I modified the python codes for dependency resolve. 
The code is not very clean, but it works very well.


The Makefile will call the python scripts.

f90_mod_deps.py resolves the dependencies of the modules. 

f90_source_deps.py resolves the denpendencies of the source.

The two files are my modification for a solution of FORTRAN dependencies.

In building, 

1. Makefile will create a ******.d file, which is a text file for the dependency.
2. In the .d file both module dependencies and object dependencies are defined.
3. .d files will be included in the Makefile before compile. 
