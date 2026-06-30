Reconfigure firewall to use systemd-resolved


`systemctl enable --now systemd-resolved`


`/etc/nssswitch.conf`

```none
hosts:    files resolve [!UNAVAIL=return] myhostname
```



## Name Resolution troubleshooting

My core firewall is running bind and being updated dynamically by {that thing we are running in kubernetes},

If we edit the zone manually the zone will no longer load correctly, giving the following error:

zone example.com/IN: journal rollforward failed: journal out of sync with zone
zone example.com/IN: not loaded due to errors.

To resolve this stop BIND, then remove the journal file for problem zone, these exist in the same directory as the zone files but end in ".jnl". Once the file has been deleted BIND can be restarted and all will be back to normal.

If you have dynamic zones it is best to "freeze" them first before editing and "thaw" them after to avoid this problem in the first place. The commands for this are:

```sh
rndc freeze zynthovian.xyz

<EDIT FILE>

rndc reload zynthovian.xyz
rndc thaw zynthovian.xyz
```