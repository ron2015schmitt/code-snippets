

# be very careful with this one
# remove all executables
EXECUTABLES = $(shell find . -type f -executable)
cleanexec: FORCE
	@command rm -f $(EXECUTABLES)

# execute all commands of a recipe in one shell so that variables can be used
# need make v3.8.2 or later
.ONESHELL:
test : FORCE 
	TEST=hello
	echo $${TEST}
	echo $$$$
	echo $$$$
