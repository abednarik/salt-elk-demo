---
logstash:
  inputs:
    -
      plugin_name: file
      path:
        - /var/log/syslog
        - /var/log/auth.log
      type: syslog
