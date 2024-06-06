## Make configuration changes

`ls` into the `/etc/netplan` directory.

If you do not see any files, you can create one. The name could be anything, but by convention, it should start with a number like 01- and end with .yaml. The number sets the priority if you have more than one configuration file.

Once there, replace the default settings with the following:

```yml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
  version: 2
  renderer: networkd
  wifis:
    wlan0:
      dhcp4: false
      addresses: [DESIRED_STATIC_IP_HERE/CIDR]
      routes:
        - to: default
          via: GATEWAY_HERE
      access-points:
        WIFI_NAME_HERE:
          password: WIFI_PASSWORD_HERE
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
      optional: true
```

Test the changes first before permanently applying them using this command:

```shell
sudo netplan try
```

If there are no errors, reboot.
