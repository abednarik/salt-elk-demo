kibana_install:
  archive.extracted:
    - name: /opt
    - source: {{ salt['pillar.get']('kibana:source') }}
    - source_hash: {{ salt['pillar.get']('kibana:source_hash') }}
    - archive_format: tar
    - tar_options: xf
    - user: logstash
    - group: logstash
    - if_missing: {{ salt['pillar.get']('kibana:dir') }}
    - failhard: True

kibana_symlink:
  file.symlink:
    - name: /opt/kibana
    - target: {{ salt['pillar.get']('kibana:dir') }}

kibana_init:
  file.managed:
    - name: /etc/init/kibana.conf
    - source: salt://kibana/files/kibana_upstart.conf

kibana_service:
  service.running:
    - name: kibana
    - enable: True
