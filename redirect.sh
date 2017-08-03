#!/bin/bash

##
## Place requested URLs in a file called batch.list
## Format should be:
##
## Source: /your link
## Destination: https://www.nytimes.com/
##


## Declare SVN and Working Folders

SVN_HOME=/Users/208115/svn/www
WORK_HOME=/Users/208115/URL


## Pull Latest www file

rm $SVN_HOME/www-www.nytimes.com-301-map.txt
/usr/bin/svn up $SVN_HOME/


## Clean up old mess

rm $WORK_HOME/output.txt
rm $WORK_HOME/ww*


## Copy WWW File to Work Home

cp $SVN_HOME/www-www.nytimes.com-301-map.txt $WORK_HOME

cd $WORK_HOME
count=`cat batch.list|wc -l|awk '{print $1}'`


for (( c=1; c<=$count; c++ ))
        do
            if [ $((c % 2)) != 0 ]; then
                  FRONT=`sed "$c!d" batch.list | sed 's/www.nytimes.com//g' | sed 's/nytimes.com//g'| tr '[:upper:]' '[:lower:]'| awk '{print $1}'`
                  END=`sed "$((c+1))!d" batch.list`
                  sed -i -e "\,$FRONT,d" www-www.nytimes.com-301-map.txt
                  echo $FRONT $END >> www-www.nytimes.com-301-map.txt
                  echo $FRONT $END >> output.txt
            fi
        done

# SVN Check
newchanges=`wc -l output.txt|awk '{print $1}'`

echo ".."
echo "Checking against SVN.."
echo ""

cp $WORK_HOME/www-www.nytimes.com-301-map.txt $SVN_HOME
cd $SVN_HOME
result=`/usr/bin/svn diff | grep "^\+"|grep -v "^++"|wc -l`
if [ $result != $newchanges ];then
      echo "Check Entries for Errors"
    else
      echo "URLs Are Ready for Check-in"
fi


## Push changes to SVN then run Jenkins job on www24.prd.sea1.nytimes.com. Finally use the command below to test against www24.prd.sea1.nytimes.com.

## for i in `awk '{print $1}' output.txt`; do echo $i;curl -I -H 'Host:www.nytimes.com' http://www24.prd.sea1.nytimes.com$i | grep Location | awk '{print $2}';done > results.check; diff batch.list results.check
