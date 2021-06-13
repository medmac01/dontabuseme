#!/bin/bash
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

read -s -p "Choose from the menu above :"

if [ ${REPLY} -eq 3 ]
then
    echo "Goodbye!";
    exit
elif [ ${REPLY} -eq 1 ]
then
    RED="\e[31m"
    ENDCOLOR="\e[0m"
    clear
    read -s -p "Path for log file :"
    cat ${REPLY} | cut -d ' ' -f 1 | tee out.txt
    clear
    apiKey="4d96b3a082572eecd3c693dd235699d47f164bd471e29a19831dac4b06c76b08fba12b3148e755c7"
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
    echo "Scanning finished, found ${blacklistedIPCount} Suspecious IPs out of ${testedIPCount}." | tee -a report.txt
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