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

echo "1. Check an IP Address";
echo "2. About Us";
echo "3. Exit";

read -s -p "Choose from the menu above :"

if [ ${REPLY} -eq 3 ]
then
    echo "Goodbye!";
    exit
elif [ ${REPLY} -eq 2 ]
then
    clear
    read -s -p "Path for log file :"
    cat ${REPLY} | cut -d ' ' -f 1 | tee out.txt
    clear
    apiKey="4d96b3a082572eecd3c693dd235699d47f164bd471e29a19831dac4b06c76b08fba12b3148e755c7"
    file="out.txt"
    while IFS= read line
    do
        # display $line or do something with $line
        curl -G https://api.abuseipdb.com/api/v2/check \--data-urlencode "ipAddress=${line}" \-d maxAgeInDays=90 \-d verbose \-H "Key: ${apiKey}" \-H "Accept: application/json" | tee -a report.txt;
    done <"$file"
    clear
    echo "Test Succeeded ! Report generated in report.txt"


fi