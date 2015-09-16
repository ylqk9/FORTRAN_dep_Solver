FC=/shared/opt/mpich-3.1.4-intel/bin/mpif90
FCFLAGS=-O2 -fpp
LINKFLAGS=-mkl
VPATH = ../src:../tools

OBJS=control.o converge.o exception.o fftw.o hamiltonian.o iceage.o initialize.o \
io.o kpoints.o extraion.o main.o marsaglia.o measure.o mixing.o moldynamics.o order.o parallel.o \
parameters.o parser.o pseudopotential.o rad.o screen.o subs.o timedependent.o wavefunc.o IndexRotation.o \
OSEnvironment.o eigensolver.o lanczos.o\

parallel:
parallel: FCFLAGS += -D"USEMPI"

%.d: %.f90
	@python f90_mod_deps.py $< > $@
	@python f90_source_deps.py $< >> $@

-include $(OBJS:.o=.d)

%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

serial: $(OBJS)
	$(FC) -o periodic_dft $(OBJS) $(LINKFLAGS)
	yes | cp -rf ../db/database ./

parallel: $(OBJS)
	$(FC) -o periodic_dft_MPI $(OBJS) $(LINKFLAGS)
	yes | cp -rf ../db/database ./

.PHONY: clean cleaner
clean:
	-rm -rf *.o *.mod *.d
cleaner: clean
	-rm -rf periodic_dft periodic_dft_MPI
