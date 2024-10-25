# SSID=dlink-C329
SSID=NTUSECURE
sudo nmcli device wifi connect $SSID
nmcli connection show --active