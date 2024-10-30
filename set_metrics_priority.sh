wlan_connection_name=dlink-C329
eth_connection_name=WiredConnection

wlan_metric=200
eth_metric=100
# smaller means higher priority

sudo nmcli connection modify $wlan_connection_name ipv4.route-metric $wlan_metric
sudo nmcli connection modify $eth_connection_name ipv4.route-metric $eth_metric

sudo nmcli connection down $wlan_connection_name
sudo nmcli connection up $wlan_connection_name
sudo nmcli connection down $eth_connection_name
sudo nmcli connection up $eth_connection_name
