FILE="example.tar.gz"

# example
echo "${FILE%%.*}"

# example.tar
echo "${FILE%.*}"

# tar.gz
echo "${FILE#*.}"

# gz
echo "${FILE##*.}"
