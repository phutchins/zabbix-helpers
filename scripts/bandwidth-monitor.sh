#!/bin/bash
# Current month total bandwidth in MB
iface=$1
rxtx=$2
time=$3

case "$rxtx" in
        ttl)
                case "$time" in
                        d)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $6 }')
                                ;;
                        m)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $11 }')
                                ;;
                esac
                ;;
        rx)
                case "$time" in
                        d)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $4 }')
                                ;;
                        m)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $9 }')
                                ;;
                esac
                ;;
        tx)
                i=$(vnstat -i $iface -$time --oneline | awk -F\; '{ print $10 }')
                case "$time" in
                        d)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $5 }')
                                ;;
                        m)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $b | awk -F\; '{ print $10 }')
                                ;;
                esac
                ;;
        *)
                case "$time" in
                        d)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $i | awk -F\; '{ print $6 }')
                                ;;
                        m)
                                b=$(vnstat -i $iface -$time --oneline)
                                i=$(echo $i | awk -F\; '{ print $11 }')
                                ;;
                esac
                ;;
esac

bandwidth_number=$(echo $i | awk '{ print $1 }')
bandwidth_unit=$(echo $i | awk '{ print $2 }')
case "$bandwidth_unit" in
KiB)    bandwidth_number_MB=$(echo "$bandwidth_number/1024" | bc)
    ;;
MiB)    bandwidth_number_MB=$bandwidth_number
    ;;
GiB)     bandwidth_number_MB=$(echo "$bandwidth_number*1024" | bc)
    ;;
TiB)    bandwidth_number_MB=$(echo "$bandwidth_number*1024*1024" | bc)
    ;;
esac
echo $bandwidth_number_MB

