# munin-node-apache

Sample run:

```
docker run \
  -e MUNIN_APACHE_PORT=32080 \
  -e MUNIN_PORT=4949 \
  -e ALLOW="allow ^172\\.29\\.0\\.9\$" \
  --rm -it \
  --privileged \
  --net=host \
  -v /docker/munin:/var/lib/munin \
  -v /sys:/sys:ro \
  -v /:/rootfs:ro \
  bergerx/munin-node-apache
```

If you want slack notifications, also define these variables:

```
   -e SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
   -e SLACK_CHANNEL="#munin"
   -e SLACK_USERNAME="munin"
   -e SLACK_ICON_EMOJI=":munin:"
```
