
# date and time
import datetime
today = datetime.datetime.now().strftime("%d %B %Y")
#print(today)


# command line argument processing
import sys
usage="""
USAGE: python3 {} filename
""".format(sys.argv[0])
n = len(sys.argv)
if n != 2:  # script.py is sys.argv[0]
    print("Invalid number of command line arguments ({})\n".format(n) + usage)
    sys.exit(1)

scriptname = sys.argv[0]
filename = sys.argv[1]


# check to see if a file exists and then delete it if so, regardless of write permissions (as long as owner)
def delete(fname):
  if os.path.exists(fname):  
    os.chmod(fname, 0o777)
    os.remove(fname)


# current working directory.  this will be where script was called from not script location
print(os.getcwd())
