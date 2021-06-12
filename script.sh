#!/bin/bash
clear
echo "";
echo "";

echo "   ██████╗  ██████╗ ███╗   ██╗████████╗ █████╗ ██████╗ ██╗   ██╗███████╗███████╗███╗   ███╗███████╗";
echo "   ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝████╗ ████║██╔════╝";
echo "   ██║  ██║██║   ██║██╔██╗ ██║   ██║   ███████║██████╔╝██║   ██║███████╗█████╗  ██╔████╔██║█████╗  ";
echo "   ██║  ██║██║   ██║██║╚██╗██║   ██║   ██╔══██║██╔══██╗██║   ██║╚════██║██╔══╝  ██║╚██╔╝██║██╔══╝  ";
echo "   ██████╔╝╚██████╔╝██║ ╚████║   ██║   ██║  ██║██████╔╝╚██████╔╝███████║███████╗██║ ╚═╝ ██║███████╗";
echo "   ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝";
echo "                                                                                                ";                                                                                                     
echo "                                              By: Mohammed Machrouh && Mohammed Elias Lakhmiri                     ";                                                                                             
echo "                                              UEMF - EIDIA 2021";
echo "                                              github.com/medmac01/dontabuseme "; 
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
    
fi