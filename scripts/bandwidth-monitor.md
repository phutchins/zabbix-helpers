# Bandwidth Monitor Usage

## Add UserParameter
`UserParameter=net.bandwidth[*],/usr/local/bin/bandwidth_monitor.sh $1 $2 $3`

## Add Item
  + Type: Zabbix Agent type
  + Key: `net.bandwidth[eth1,rx,d]`
  + Type of information: Numeric (float)
  + Units: MB
