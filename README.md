Bonus 3 : 
--> Set up a service of your choice that you think is useful (NGINX / Apache2 excluded!). During the defense, you will have to justify your choice.
Fail2Ban tool:
"To enhance the security of SSH and prevent unauthorized access attempts."
I_ Installation :
    $ sudo apt-get update
    $ sudo apt-get install fail2ban
II_ Configuration:
    $ cd /etc/fail2ban/
    $ sudo nano jail.local
    --> Add or modify the SSH section to define the rules inside jail.local:
    [ssh]
    enabled = true
    port = ssh  # Use the actual SSH port if it's different from default
    filter = sshd
    logpath = /var/log/auth.log
    maxretry = 3  # Number of failed login attempts allowed before banning
    bantime = 3600  # Ban duration in seconds (adjust as needed)
III_ Restart Fail2Ban:
    $ sudo systemctl restart fail2ban
