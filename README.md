<h1>Bonus 3 : </h1>
--> Set up a service of your choice that you think is useful (NGINX / Apache2 excluded!). During the defense, you will have to justify your choice.

<h1>Fail2Ban tool:</h1>
"To enhance the security of SSH and prevent unauthorized access attempts."
<h3>I_ Installation :</h3>
    $ sudo apt-get update
    $ sudo apt-get install fail2ban
<h3>II_ Configuration:</h3>
    $ cd /etc/fail2ban/<br>
    $ sudo nano jail.local<br>
    --> Add or modify the SSH section to define the rules inside jail.local:<br>
    [ssh]<br>
    enabled = true<br>
    port = ssh  # Use the actual SSH port if it's different from default<br>
    filter = sshd<br>
    logpath = /var/log/auth.log<br>
    maxretry = 3  # Number of failed login attempts allowed before banning<br>
    bantime = 3600  # Ban duration in seconds (adjust as needed)<br>
<h3>III_ Restart Fail2Ban:</h3>
    $ sudo systemctl restart fail2ban
