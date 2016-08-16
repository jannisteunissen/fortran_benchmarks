FC 	:= gfortran
FFLAGS	:= -O3 -g -std=f2008 -Wall -Wextra

PROGS	:= intrinsics_benchmark select_case_benchmark

.PHONY:	all test clean

all: 	intrinsics_benchmark select_case_benchmark

clean:
	$(RM) $(PROGS)

# How to get executables from .f90 source files
%: %.f90
	$(FC) -o $@ $^ $(FFLAGS)
