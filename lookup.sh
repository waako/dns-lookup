#!/bin/bash
# Put all the domain names in domains.txt, one per line
# then run in the terminal: bash domains.sh
# this will print each domain in the terminal as it looks it up
# The result csv will contains the domain, IP & Nameservers in each column

# Give each column the relevant header titles
echo "Domain Name,IP Address,Nameserver,Nameserver,Nameserver,Nameserver,Nameserver" > domains.csv

while read domain
do
  # Get IP address defined in domain's root A-record
  ipaddress=`dig $domain +short`

  # Get list of all nameservers
  ns=`dig ns $domain +short| sort | tr '\n' ','`

  # Use the line below to extract any information from whois
  # ns=`whois $domain | grep "Name Server" | cut -d ":" -f 2 |  sed 's/ //' | sed -e :a -e '$!N;s/ \n/,/;ta'`

  echo "$domain"

  # Uncomment the following lines to output the information directly into the terminal
  # echo "IP Address:  $ipaddress"
  # echo "Nameservers: $ns"
  # echo " "
  
  # Prints all the values fetched into the CSV file
  echo -e "$domain,$ipaddress,$ns" >> domains.csv

# Defines the text file from which to read domain names
done < domains.txt
