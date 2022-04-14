
#############################################################
# THe most confusing ERROR in make 
#############################################################

# CASE 1: using targets WITHOUT wildcards (SENSIBLE ERROR)

> cat Makefile
temp.1: temp.2
	@echo Making $@ from $<

> touch temp.2
> make temp.1
Making temp.1 from temp.2

> rm temp.2
> make temp.1
make: *** No rule to make target 'temp.2', needed by 'temp.1'.  Stop.


# CASE 2: using targets WITH wildcards (CONFUSING ERROR)

> cat Makefile
%.1: %.2
	@echo Making $@ from $<
	
> touch temp.2
> make temp.1
Making temp.1 from temp.2

> rm temp.2
> make temp.1
make: *** No rule to make target 'temp.1'.  Stop.

# ^^^^ But the rule does exist. It's the prerequisite that doesn't exist!!!
# *************BEWARE*************



#############################################################
# be very careful with this one
# remove all executables
#############################################################
EXECUTABLES = $(shell find . -type f -executable)
cleanexec: FORCE
	@command rm -f $(EXECUTABLES)

#############################################################
# execute all commands of a recipe in one shell so that variables can be used
# need make v3.8.2 or later
#############################################################
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


#############################################################
# create an intermediate source file and then compile that file
#############################################################
%.o: %.cpp 
ifdef MATHQ_COPTS
	@\echo "#define MATHQ_COPTS 1" > $*.cpp__opts
	@\echo "char COMPILER_OPT_STR[] = "\"$(OPTIMIZE)\";" >> $*.cpp__opts
	@\cat $*.cpp >> $*.cpp__opts
	$(CPPC) $(CFLAGS) $(EXTRAS) -D"MATHQ_COPTS" -c $*.cpp__opts -o $@
else
	$(CPPC) $(CFLAGS) $(EXTRAS) -c $*.cpp -o $@
endif

#############################################################
# using styles in a bash echo command from a makefile
#############################################################
style:
# INCORRECT -> styles inside of quotes: get '\e[34m''\e[1m'
	@echo
	@echo "verbatim $(BLUE)$(BOLD)INCORRECT$(DEFCLR)$(NORMAL) hello world"
	@echo -e "verbatim $(BLUE)$(BOLD)INCORRECT$(DEFCLR)$(NORMAL) hello world"	
# CORRECT -> styles outside of quotes: get \e[34m\e[1m
	@echo
	@echo "verbatim "$(BLUE)$(BOLD)"CORRECT"$(DEFCLR)$(NORMAL)" hello world"
	@echo -e "verbatim "$(BLUE)$(BOLD)"CORRECT"$(DEFCLR)$(NORMAL)" hello world"

#############################################################
# run makefiles in all subdirectories that have makefiles
#############################################################
SUBMAKES := $(wildcard */Makefile)
SUBDIRS := $(dir $(SUBMAKES))
SUBDIRSCLEAN=$(addprefix clean_,$(SUBDIRS))

.PHONY: all $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean_%: FORCE
	$(MAKE) -C $* clean

cleansubs: $(SUBDIRSCLEAN)

# use this recipe to verify you got it right
test: FORCE
	@echo $(SUBMAKES)
	@echo $(SUBDIRS)
	@echo $(SUBDIRSCLEAN)

#############################################################
# ujsing filter-out
#############################################################
varglob := a1 a2 a3 a4 a5 a6 b7 b8 b-whatever
has-no-ticket := a3 b%  # a3 and all the b's didn't pay the ride
varglobelim := $(filter-out $(has-no-ticket),$(varglob))

test: FORCE
	@echo $(varglob)
	@echo $(has-no-ticket)
	@echo $(varglobelim)


#############################################################
# you can't use "%" more than once in prerequisites
# But with SECONDEXPANSION you can use $$* as a work-around
# CAVEAT: see make's most confusing ERROR above
#############################################################
.SECONDEXPANSION:
%.a: $$*.$$*.b
	echo Making $@ from $<
	
	
#############################################################
# Define a recipe multiple times
# Normally this causes issues, but if you use a double colon (::)
# you can define multiple times and then all of the recipes run
# in the order they are defined
#############################################################
cleanall:: cleansubs

cleanall::
	\rm -r *.o

