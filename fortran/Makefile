# Compiler and flags
FC = gfortran
FFLAGS = -O2 -Wall -Wextra -fcheck=all

# Source files
SRCS = format_data.f90 \
       set_params.f90 \
       load_data.f90 \
       calc_bc.f90 \
       calc_grid.f90 \
       plot_results.f90 \
       calc_volume.f90 \
       print_results.f90 \
       main.f90

# Object files
OBJS = $(SRCS:.f90=.o)

# Executable name
EXEC = openExcav

# Default target
all: $(EXEC)

# Linking
$(EXEC): $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

# Compilation
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

# Clean
clean:
	rm -f $(OBJS) $(EXEC) *.mod

# Dependencies
main.o: format_data.o set_params.o load_data.o calc_bc.o calc_grid.o plot_results.o calc_volume.o print_results.o 