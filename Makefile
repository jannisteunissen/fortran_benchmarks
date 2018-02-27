FC 	:= gfortran
FFLAGS	:= -O3 -g -std=f2008 -Wall -Wextra

PROGS := intrinsics_benchmark select_case_benchmark procedure_pointer_benchmark	\
allocate_benchmark

.PHONY:	all test clean

all: 	$(PROGS)

clean:
	$(RM) $(PROGS)

# How to get executables from .f90 source files
%: %.f90
	$(FC) -o $@ $^ $(FFLAGS)

# How to get object files from .f90 source files
%.o: %.f90
	$(FC) -c -o $@ $^ $(FFLAGS)

# Dependencies
procedure_pointer_benchmark: m_simple_routines.o
