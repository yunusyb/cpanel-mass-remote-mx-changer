#!/bin/bash

##############################################
# Script to mass update MX records to a remote
# mail exchange server on a cPanel/WHM server
# 
# Date 05/04/2014 - Yunus Bookwala (bookwalayunus at gmail dot com)
##############################################

#set -x
remotemxserver='your.remote.mx'

cd /var/named
for file in `ls *.db`
do
dom=`echo ${file} | rev | cut -c 3- | rev`
echo ${dom}
sed -i '/\sMX\s/d' ${file}
sed -i '/mail\s/d' ${file}
sed -i '/webmail\s/d' ${file}
echo "${dom}	600	IN	MX	0	${remotemxserver}." >> ${file}
echo "mail	600	IN	CNAME	${remotemxserver}." >> ${file}
echo "webmail	600	IN	CNAME	${remotemxserver}." >> ${file}
done

/scripts/checkalldomainsmxs  --yes
