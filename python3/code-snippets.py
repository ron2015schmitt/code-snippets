
# date and time
import datetime
today = datetime.datetime.now().strftime("%d %B %Y")
#print(today)


# command line argument processing
import sys
usage="""
USAGE: python3 filename 
"""
n = len(sys.argv)
if n != 1:
    print("Invalid number of command line arguments ({})\n".format(n) + usage)
    sys.exit(1)

filename = sys.argv[1]
