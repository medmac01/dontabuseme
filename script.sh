#!/bin/bash

if [ $1 = "-h" ]
then
    clear
    more README.md;
    exit
fi

if [ $1 = "-p" ]
then
    if [ $2 = "" ]
    then
        echo "You need to specify an IP Address , -h for help";
    else
        apiKey="$( cat config )"
        content=$(curl -G https://api.abuseipdb.com/api/v2/check \--data-urlencode "ipAddress=$2" \-d maxAgeInDays=90 \-d verbose \-H "Key: ${apiKey}" \-H "Accept: application/json")
        abuseScore=$( jq --compact-output '.data.abuseConfidenceScore' <<< "${content}");
        if [ "$abuseScore" -gt 25 ]
        then
            echo "> Your IP : $2 is suspecious"
            exit
        else
            echo "> Your IP : $2 is safe"
            exit
        fi
    fi
fi
clear
echo "";
echo "";

echo "   ██████╗  ██████╗ ███╗   ██╗████████╗ █████╗ ██████╗ ██╗   ██╗███████╗███████╗███╗   ███╗███████╗";
sleep .5;
echo "   ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝████╗ ████║██╔════╝";
sleep .5;
echo "   ██║  ██║██║   ██║██╔██╗ ██║   ██║   ███████║██████╔╝██║   ██║███████╗█████╗  ██╔████╔██║█████╗  ";
echo "   ██║  ██║██║   ██║██║╚██╗██║   ██║   ██╔══██║██╔══██╗██║   ██║╚════██║██╔══╝  ██║╚██╔╝██║██╔══╝  ";
sleep .5;
echo "   ██████╔╝╚██████╔╝██║ ╚████║   ██║   ██║  ██║██████╔╝╚██████╔╝███████║███████╗██║ ╚═╝ ██║███████╗";
echo "   ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝";
sleep .5;
echo "                                                                                                ";                                                                                                     
echo "                                              By: Mohammed Machrouh && Mohammed Elias Lakhmiri                     ";                                                                                             
sleep .5;
echo "                                              UEMF - EIDIA 2021";
echo "                                              github.com/medmac01/dontabuseme "; 
sleep .5;
echo "                                              Pr.Hicham Moad Safhi && Pr.Khawla Tadist ";  

echo "1. Check a log file for suspecious attacks";
echo "2. About Us";
echo "3. Exit";

read -p "Choose from the menu above :"

if [ ${REPLY} -eq 3 ]
then
    echo "Goodbye!";
    exit
elif [ ${REPLY} -eq 1 ]
then
    RED="\e[31m"
    ENDCOLOR="\e[0m"
    clear
    read -p "Path for log file :"
    cat ${REPLY} | cut -d ' ' -f 1 | tee out.txt
    clear
    apiKey="$( cat config )"
    testedIPCount=0
    blacklistedIPCount=0
    file="out.txt"
    while IFS= read line
    do
        # display $line or do something with $line
        content=$(curl -G https://api.abuseipdb.com/api/v2/check \--data-urlencode "ipAddress=${line}" \-d maxAgeInDays=90 \-d verbose \-H "Key: ${apiKey}" \-H "Accept: application/json")
        abuseScore=$( jq --compact-output '.data.abuseConfidenceScore' <<< "${content}");
        if [ "$abuseScore" -gt 25 ]
        then
            echo "> Suspecious IP detected :"
            echo -e "${line}" | tee -a blacklisted.txt;
            blacklistedIPCount=$((blacklistedIPCount+1));
        fi
        testedIPCount=$((testedIPCount+1));
    done <"$file"
    clear
    percentage=$((blacklistedIPCount*100/testedIPCount))
    echo "Scanning finished, found ${blacklistedIPCount} Suspecious IPs out of ${testedIPCount}. $percentage%" | tee -a report.txt
    echo "Do you want to block traffic from them ? [(Y)es/(N)o]"
    read rep

    if [ $rep = "" ] || [ $rep = "Y" ] || [ $rep = "y" ]
    then
        f="blacklisted.txt"
        while IFS= read l 
        do
	        sudo iptables -A INPUT -s "${l}" -j DROP
	        echo ">IP Address $l Blacklisted!" | tee -a report.txt;
        done <"$f"

    fi

    
    echo "Report generated in report.txt"


fi