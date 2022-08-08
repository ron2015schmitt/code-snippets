FILE="example.tar.gz"

# example
echo "${FILE%%.*}"

# example.tar
echo "${FILE%.*}"

# tar.gz
echo "${FILE#*.}"

# gz
echo "${FILE##*.}"


# remove one or more trailing slashes
DIR="test/"
echo ${DIR%%+(/)}

DIR="test//"
echo ${DIR%%+(/)}
