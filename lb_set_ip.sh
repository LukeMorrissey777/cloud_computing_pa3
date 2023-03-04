echo "Which load balancer is this?"
echo "Enter '1' for load balancer 1"
echo "Enter '2' for load balancer 2"

read server_num

if [ $server_num = '1' ]
then
    # Set ip in 192.168.100.x range
    sudo cp lb_config/lb1.yaml /etc/netplan/01-network-manager-all.yaml
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
    sudo cp lb_config/lb2.yaml /etc/netplan/01-network-manager-all.yaml
    sudo netplan apply
fi