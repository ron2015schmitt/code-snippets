

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
	echo $$$$  #PID
	echo $$$$
	if [[ $${TEST} == hello ]] 
	then
	echo "test is hello"
	else
	echo "test is not hello"
	fi


# create an intermediate source file and then compile that file
%.o: %.cpp 
ifdef MATHQ_COPTS
	@\echo "#define MATHQ_COPTS 1" > $*.cpp__opts
	@\echo "char COMPILER_OPT_STR[] = "\"$(OPTIMIZE)\";" >> $*.cpp__opts
	@\cat $*.cpp >> $*.cpp__opts
	$(CPPC) $(CFLAGS) $(EXTRAS) -D"MATHQ_COPTS" -c $*.cpp__opts -o $@
else
	$(CPPC) $(CFLAGS) $(EXTRAS) -c $*.cpp -o $@
endif

# using styles in a bash echo command from a makefile
style:
# INCORRECT -> styles inside of quotes: get '\e[34m''\e[1m'
	@echo
	@echo "verbatim $(BLUE)$(BOLD)INCORRECT$(DEFCLR)$(NORMAL) hello world"
	@echo -e "verbatim $(BLUE)$(BOLD)INCORRECT$(DEFCLR)$(NORMAL) hello world"	
# CORRECT -> styles outside of quotes: get \e[34m\e[1m
	@echo
	@echo "verbatim "$(BLUE)$(BOLD)"CORRECT"$(DEFCLR)$(NORMAL)" hello world"
	@echo -e "verbatim "$(BLUE)$(BOLD)"CORRECT"$(DEFCLR)$(NORMAL)" hello world"


