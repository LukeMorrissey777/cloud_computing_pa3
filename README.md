Repo url: https://github.com/LukeMorrissey777/cloud_computing_pa3

# High Availabilty

For this assignment we have 2 master-master replicating database servers and 3 webservers behind 2 load balancers. This readme will explain how to set it up:

### Prereqs
- 1 dns server vm that has 1 network (1 facing the internet)
- 2 load balancer server vms that have 2 networks (1 facing the internet and 1 local network)
- 3 webserver vms that have 1 network (only local network)
- 2 db vms that have 1 network (only local network)

### Step 1: Setting up a NAT to give dbs and wbs internet

In this repo there is a file for what the `/etc/netplan/01-network-manager-all.yaml` should be on each machine. This sets the ip for the machine and the correct gateway and dns information. For the load balancer servers you can simply clone this repo and run: 
```bash
sudo bash set_ip.sh
```
On the first load balancer this also sets up the NAT.

For the database and web servers, you cannot clone the repo since they are not connected to the internet yet. Thus you have to do this manually. Replace the contents of `/etc/netplan/01-network-manager-all.yaml` on each machine with the corresponding yaml file (`db_config/dbX.yaml` or `ws_config/wsX.yaml`). And run
```bash
sudo netplan apply
```

Now the databases and webservers should be connected to the internet.

### Step 2: Set up first db step

First we need to install mariadb and set up some intial settings necissary for replication. On the each of the dbs clone this repo and then run:
```bash
sudo bash db_part1.sh
```

### Step 3: Set up webservers
The first webserver will migrate all the data to db1. The rest will just set up the other necisarry parts.

Simply run:
```bash
bash web_server.sh
```

### Step 4: Set up database replication
We set the databases up so they are using master-master replication. To make use of this on the webservers we randomly choose to use either db1 or db2 using the db_router.

First copy all data from db1 to db2. On db1 run:
```bash
sudo mysqldump --databases myproject > dump.sql
mysql -u root -h 192.168.100.102 -p'password' < dump.sql
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

On db1 run:
```
sudo mysql -e "SHOW MASTER STATUS;"
```

On db2 run:
```
sudo bash db_part2.sh
```

### Step 5: Set up load balancers
The load balancers are just using apache to load balance between the webservers.

Simply run:
```bash
bash load_balancer.sh
```

### Step 6: Set up DNS Server
The DNS server has the 2 ips of the load balancer corresponding to the domain: `lukemorrisseycc.com`.

Simply run:
```bash
bash dns_server.sh
```

Now by specifying the dns server and the search url `lukemorrisseycc.com` you should be able to access the django cms.