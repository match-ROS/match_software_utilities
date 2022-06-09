## route throught Miranda-PC with iptables
### Example
panda: 192.168.13.90, client: 10.145.8.250:
```
sudo iptables -t nat -A PREROUTING -i enx0050b6ffe45f -p tcp --dport 443 -j DNAT --to-destination 192.168.13.90:443
sudo iptables -t nat -A PREROUTING -i enx0050b6ffe45f -p tcp --dport 80 -j DNAT --to-destination 192.168.13.90:80
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
```

All input on interface enx0050b6ffe45f at dport gets redirected to destination.
MASQUERADE: ip address of miranda is used (clients ip address is exchanged)

### info
To get the interface used for ip-address 10.145.8.250: ``` ip route get 10.145.8.250 ```.
Forwarding has to be enabled (default).

das Package iptables-persistent lädt die gespeicherten iptables beim Neustart. Hierfür die momentanen Regeln über folgenden Befehl speichern:
``` sudo sh -c "iptables-save > /etc/iptables/rules.v4" ```