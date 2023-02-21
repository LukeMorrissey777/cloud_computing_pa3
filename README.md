# High Availablity

For this assignment we have 2 master-master replicating database servers and 2 webservers. This readme will explain how to set it up:

### Prereqs
- 2 webserver vms that have 2 networks (1 facing the internet and 1 local network)
- 2 db vms that have 1 network (only local network)

### Step 1: Setting up a NAT to give dbs internet

In this repo there is a file for what the `/etc/netplan/01-network-manager-all.yaml` should be on each machine. This sets the ip for the machine and the correct gateway and dns information. For the web servers you can simply clone this repo and run: 
```bash
sudo bash set_ip.sh
```
On the first webserver this also sets up the NAT.

For the database servers, you cannot clone the repo since they are not connected to the internet yet. Thus you have to do this manually. Replace the contents of `/etc/netplan/01-network-manager-all.yaml` on each machine with the corresponding yaml file (`db1.yaml` or `db2.yaml`). And run
```bash
sudo netplan apply
```

Now the databases should be connected to the internet.

### Step 2: Set up master-master db replication

First we need to install mariadb and set up some intial settings necissary for replication. On the each of the dbs clone this repo and then run:
```bash
sudo bash db_part1.sh
```

Now we will set up master-slave replication from 1 to 2.

On db2 run:
```
sudo mysql -e "SHOW MASTER STATUS;"
```

On db1 run:
```
sudo bash db_part2.sh
```

Last we will set up master-slave replication from 2 to 1.

On db2 run:
```
sudo mysql -e "SHOW MASTER STATUS;"
```

On db1 run:
```
sudo bash db_part2.sh
```