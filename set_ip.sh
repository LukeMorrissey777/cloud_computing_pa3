echo "Which server is this?"
echo "Enter '1' for webserver 1"
echo "Enter '2' for webserver 2"
echo "Enter '3' for db server 1"
echo "Enter '4' for db server 2"

read server_num

if [ $server_num = '1' ]
then
    sudo ifconfig ens192 192.168.100.11 netmask 255.255.255.0
    sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
    sudo sysctl -p
    sudo apt install iptables-persistent -y
    sudo iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE
    sudo iptables -A FORWARD -i ens192 -j ACCEPT
    sudo sh -c "iptables-save > /etc/iptables/rules.v4"
    sudo service iptables restart
fi

if [ $server_num = '2' ]
then
    sudo ifconfig ens192 192.168.100.12 netmask 255.255.255.0
fi

if [ $server_num = '3' ]
then
    sudo ifconfig ens160 192.168.100.101 netmask 255.255.255.0
    sudo ip route add default via 192.168.100.11 dev ens160
    sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi

if [ $server_num = '4' ]
then
    sudo ifconfig ens160 192.168.100.1012 netmask 255.255.255.0
    sudo ip route add default via 192.168.100.11 dev ens160
    sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi