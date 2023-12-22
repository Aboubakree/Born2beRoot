#!/bin/bash

# Store command outputs into variables

#Get The architecture of your operating system and its kernel version.
architecture=$(uname -a )

#Get The number of physical processors.
cpu_physical=$(lscpu | grep "Socket(s)" | awk '{print $2}')

#Get The number of virtual processors.
vcpu=$(lscpu | grep "^CPU(s):" | awk '{print $2}')

#Get The current available RAM on your server and its utilization rate as a percentage.
memory_usage=$(free -m | grep "Mem" | awk '{printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2 * 100}')

#Get The current available disk storege on your server and its utilization rate as a percentage.
full_disk=$(df -B1G | grep "^/dev" | grep -v "/boot" | awk '{sum += $2} END {printf "%d",sum}')
used_disk=$(df -B1G | grep "^/dev" | grep -v "/boot" | awk '{sum += $3} END {printf "%d",sum}')
disk_usage=$(awk " BEGIN {printf \"%d/%dGb (%.2f%%)\", $used_disk, $full_disk, $used_disk/$full_disk * 100}")

#The current utilization rate of your processors as a percentage.
cpu_load=$(mpstat | grep all | awk '{printf("%.2f%%", 100 - $NF)}')

#The date and time of the last reboot.
last_boot=$(last reboot | awk 'NR==1 {print $5, $6, $7, $8}' | xargs -I{} date -d "{}" +"%Y-%m-%d %H:%M")

#Whether LVM is active or not.
lvm_state=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

#The number of active connections.
tcp_connections=$(netstat -n | grep -c ESTABLISHED)

#The number of users using the server.
user_log=$(who | awk '{printf $1}' | sort -u | wc -l)

#The IPv4 address of your server and its MAC (Media Access Control) address.
network_mac=$(echo "$(hostname -I) ($(ip link | awk '$1 == "link/ether" {print $2}'))")

#The number of commands executed with the sudo program.
sudo_commands=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)

# Construct the message template with captured outputs
message="
	#Architecture: $architecture
	#CPU physical : $cpu_physical
	#vCPU : $vcpu
	#Memory Usage: $memory_usage
	#Disk Usage: $disk_usage
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_state
	#Connections TCP : $tcp_connections ESTABLISHED
	#User log: $user_log
	#Network: IP $network_mac
	#Sudo : $sudo_commands cmd
"

# Using 'wall' command to broadcast the message to all users
wall "$message"

exit
