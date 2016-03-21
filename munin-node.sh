#! /usr/bin/env bash
set -eu

chown -R munin. /var/lib/munin

# Try to get host hostname or use docker's hostname
# expects "-v /:/rootfs:ro" volume definition while runnig docker
hostname=$(cat /rootfs/etc/hostname || hostname)
sed -i \
  -e "s/localhost.localdomain/$hostname/g" \
  /etc/munin/munin.conf

sed -i \
  -e "s/#host_name localhost.localdomain/host_name $hostname/" \
  -e "s/^port .*/port $MUNIN_PORT/" \
  /etc/munin/munin-node.conf

if [ -n "$ALLOW" ]; then
  echo "$ALLOW" >> /etc/munin/munin-node.conf;
fi

munin-node-configure --remove --shell | sh
rm -vf /etc/munin/plugins/squeezebox_*
exec /usr/sbin/munin-node --config /etc/munin/munin-node.conf
