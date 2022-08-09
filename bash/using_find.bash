
# recursively delete all files with a specific extension
# https://unix.stackexchange.com/questions/116389/recursively-delete-all-files-with-a-given-extension
find . -type f -name '*.o' -delete

# or
find . -type f -name '*.o' -exec rm {} +

