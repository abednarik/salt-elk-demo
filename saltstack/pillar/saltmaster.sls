---
logstash:
  inputs:
    -
      plugin_name: file
      path:
        - /var/log/syslog
        - /var/log/auth.log
      type: syslog

kibana:
  source: https://download.elastic.co/kibana/kibana/kibana-4.4.2-linux-x64.tar.gz
  source_hash: sha1=6251dbab12722ea1a036d8113963183f077f9fa7
  dir: /opt/kibana-4.4.2-linux-x64
