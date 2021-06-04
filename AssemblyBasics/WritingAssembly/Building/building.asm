# Our main target is the 'soln' executable
all: soln

# When we have an object file from the assembly, link it with gcc
# We also must turn off the PIE security feature for our code to link
soln: soln.o
    gcc -o $@ $? -no-pie

# Compile all assembly files into objects files with nasm, and include
# debug information in the dwarf format
%.o: %.asm
    nasm -f elf64 -g -F dwarf $<

# A target to delete all of our object files and executables
clean:
    rm *.o soln
