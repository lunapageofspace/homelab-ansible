# Wazuh

## Rules

```xml
<group name="local,syslog,sshd,">
  <!--
  Dec 10 01:02:02 host sshd[1234]: Failed none for root from 1.1.1.1 port 1066 ssh2
  -->
  <rule id="100001" level="5">
    <if_sid>5716</if_sid>
    <srcip>1.1.1.1</srcip>
    <description>sshd: authentication failed from IP 1.1.1.1.</description>
    <group>authentication_failed,pci_dss_10.2.4,pci_dss_10.2.5,</group>
  </rule>
</group>

<group name="syslog,named,">
  <!--
  Aug 28 13:48:55 host named[828]: REFUSED unexpected RCODE resolving './DNSKEY/IN': 198.97.190.53#53
  -->
  <rule id="200001" level="0">
    <if_sid>12105</if_sid>
    <match>REFUSED</match>
    <description>BIND: record resolution refused (Silenced)</description>
  </rule>
</group>

<group name="rootcheck">
  <!--
  Silence alerts generated from podman/docker overlay filesystems (world 7, but owned by root).
  -->
  <rule id="100002" level="0">
    <if_sid>510</if_sid>
    <match>/var/lib/containers/storage/overlay/</match>
    <description>Rootcheck HIDS Anomaly (rootcheck, Silenced)</description>
  </rule>
</group>
```