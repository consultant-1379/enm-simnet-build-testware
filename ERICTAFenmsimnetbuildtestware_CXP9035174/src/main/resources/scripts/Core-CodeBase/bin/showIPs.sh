LOCALIPADDRESS=`hostname | nslookup | grep -i Address | grep -v '#' | awk -F: '{print $2}' | tr -d ' '`;
if [ -f /etc/centos-release ]
then
    LOCAL_IP_ADDRESS=`hostname -i`
    
   ifconfig -a | grep -i "inet " | awk '{print $2}' | grep -Ev "127.0.0.1|172.17" | grep -v "^$LOCAL_IP_ADDRESS$" > dat/ipListIPv4.txt
  
   ifconfig -a | grep -i "inet6 " | awk '{print $2}' | sort -u | awk -F\/ '{print $1}' | grep -v -w "::1" > dat/ipListIPv6.txt
else
   ifconfig -a | grep -i "inet " | awk '{print $2}' | awk -F: '{print $2}' | sort -ut. -k1,1 -k2,2n -k3,3n -k4,4n | grep -v "127.0.0.1" | grep -v "^$LOCALIPADDRESS$" > dat/ipListIPv4.txt

   ifconfig -a | grep -i "inet6 " | awk '{print $3}' | sort -ut: | grep -v "::1/128"> dat/ipListIPv6.txt
fi
