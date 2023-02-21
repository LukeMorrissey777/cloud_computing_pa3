echo "Which server is this?"
echo "Enter '1' for webserver 1"
echo "Enter '2' for webserver 2"
echo "Enter '3' for db server 1"
echo "Enter '4' for db server 2"

read server_num

if [ $server_num = '1' ]
then
    # Set ip in 192.168.100.x range
    sudo cp ws1.yaml /etc/netplan/01-network-manager-all.yaml
    sudo netplan apply

    # Set up nat
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
    # Set ip in 192.168.100.x range
    sudo cp ws2.yaml /etc/netplan/01-network-manager-all.yaml
    sudo netplan apply
fi

if [ $server_num = '3' ]
then
    # Set ip in 192.168.100.x range
    sudo cp db1.yaml /etc/netplan/01-network-manager-all.yaml
    sudo netplan apply
fi

if [ $server_num = '4' ]
then
    # Set ip in 192.168.100.x range
    sudo cp db2.yaml /etc/netplan/01-network-manager-all.yaml
    sudo netplan apply
fi