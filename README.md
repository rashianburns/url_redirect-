This script is for semi-automating URL redirects for NYT4 via SVN, www/www-www.nytimes.com-301-map.txt. This script will perform the following tasks.

a) Convert requested URL Source to meet SVN process requirements [Upper Case to Lower Case, etc].

b) Removes current entries of requested URL Sources on www-www.nytimes.com-301-map.txt.

c) Appends all new and updated URL Sources at the bottom of the file.

d) Checks all new and updated URL Sources againsted SVN



Use the following steps to run the script.


1. Create a file called "batch.list" and place the requested URL source and destination as follows.

/<URL Source>
https://www.nytimes.com/<URL Destination>
/<URL Source>
https://www.nytimes.com/<URL Destination>
/<URL Source>
https://www.nytimes.com/<URL Destination>
/<URL Source>
https://www.nytimes.com/<URL Destination>
/<URL Source>
https://www.nytimes.com/<URL Destination>


2. Update the code variables to match your SVN_HOME and a WORK_HOME folders.


3. Run the script and review any errors


4. Check-in SVN changes, svn ci -m "BUG..."


