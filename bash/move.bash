#! /bin/sh
########################################################################
#
#				move
#
########################################################################
#
# This script is an enhancement to mv that lets it accept wildcards. It
# uses the same syntax as mv.
#
########################################################################
 

############################################################################
#help text
give_help()
{
   cat <<THE_END
------------------------------------------------------------------------
usage: $NAME source_file_pattern dest_file_pattern

options:  NONE

Use "$wild" as a wildcard instead of "*"
example:  $NAME $wild.c $wild.g 
          would $NAME all files ending in .c to new names ending in .g
------------------------------------------------------------------------

THE_END
   exit
}



############################################################################
#initialize all variables
NAME=`echo $0|awk -F'/' '{print $NF}'`
arg=""

#->>initalize user varables
# for debugging, set debug to 1
debug=1
# initialize the wildcard character
wild="^"
#<<-end of initlaize user vairable


#filter out all options 
until [ $# = 0 ]
do
  case $1 in
   #->>place code for valid options here
   # EXAMPLE (shift once for each parameter used)
   #    -o) outfile=$2 ; shift ;;
   #-<<end of valid options

   -h*) give_help ;;
   -*)  echo "$1"' is an invalid option!!'
        give_help ;;
   #otherwise, store as an argument
   *)   arg="$arg $1";;
  esac
  shift
done
if [ "$arg" != "" ]
then
  set $arg
fi

#now all options are filtered out of the command line


###########################################################################
#main program

#if we don't have exactly two args
if [ $# -ne 2 ] 
then
  echo "You must provide eaxactly 2 arguments"
  give_help
fi
 
# create a valid file pattern for ls by changing ^ to *
ls_pattern=`echo $1 | sed -e 's/\^/\*/'`
 
# create a sed pattern for the source
#	1) hide periods
#	2) hide slashes
#	3) surround the fixed pattern with \( and \)
src_pattern=` echo $1   \
	| sed -e 's/\./\\\\./g'       \
	| sed -e 's/\//\\\\\//g'  \
	| sed -e 's/\^/\\\\(.*\\\\)/' \
`
 
# create a sed pattern for the destination
#	1) hide periods
#	2) hide slashes
#	3) substitute the fixed pattern
dest_pattern=`echo $2  \
	| sed -e 's/\./\\\\./g'       \
	| sed -e 's/\//\\\\\//g'  \
	| sed -e 's/\^/\\\\1/'        \
`
 
 
if [ $debug -eq 2 ]
then
	echo "WARNING!  Use this program at your own risk"
	echo "ls pattern   = $ls_pattern"
	echo "src pattern  = $src_pattern"
	echo "dest pattern = $dest_pattern"
fi

 
	if [ $debug -eq 1 ]
	then
	        echo "The following files will be manipulated:"
	fi
 
#tell the user what's about to happen
for src in `ls $ls_pattern`
do
	# evaluate destination path
	dest=`echo $src | sed -e "s/$src_pattern/$dest_pattern/"`
 
	if [ $debug -eq 1 ]
	then
		echo "source = $src, destination = $dest"
	fi
done

echo -n "Do you want to continue (Y/N)? "
read query
if [ "$query" != "y" -a  "$query" != "Y" ]
then
    echo "$NAME: aborted."
    exit
fi

#actually do it !
for src in `ls $ls_pattern`
do
   # evaluate destination path
   dest=`echo $src | sed -e "s/$src_pattern/$dest_pattern/"`

   case "$NAME" in
   move)
     mv $src $dest;;
   copy)
     cp $src $dest;;
   *)
     echo 'Error. Command must be named "move" or "copy"';;
   esac
done
 
echo "$NAME: completed."


