filebeat_install:
  file.managed:
    - name: /usr/local/bin/filebeat
    - source: https://beats-nightlies.s3.amazonaws.com/jenkins/filebeat/494-80d5de6ec0eeb890a1d426510c4c156fd43d4114/filebeat-freebsd-amd64
    - source_hash: md5=2037c88a577aa7ac8cb02d954dd8b563
    - user: root
    - group: wheel
    - mode: 750
    - if_missing: {{ salt['pillar.get']('filebeat:bin') }}
    - failhard: True

filebeat_config:
  file.managed:
    - name: /usr/local/etc/filebeat.yml
    - source: salt://filebeat/files/filebeat.yml.jinja
    - user: root
    - group: wheel
    - mode: 750
    - template: jinja
    - require:
      - file: filebeat_install

filebeat_init:
  file.managed:
    - name: /etc/rc.d/filebeat
    - source: salt://filebeat/files/filebeat.rc
    - user: root
    - group: wheel
    - mode: 550
    - if_missing: /etc/rc.d/filebeat
    - failhard: True
    - require:
      - file: filebeat_config

filebeat-svc:
  service.running:
    - name: filebeat
    - enable: true
    - sig: {{ salt['pillar.get']('filebeat:bin') }}
    - require:
      - file: filebeat_init
    - watch:
      - file: filebeat_config
