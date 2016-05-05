filebeat-install:
  file.managed:
    - name:  /usr/local/bin/filebeat
    - source:  https://beats-nightlies.s3.amazonaws.com/jenkins/filebeat/494-80d5de6ec0eeb890a1d426510c4c156fd43d4114/filebeat-freebsd-amd64
    - source_hash: md5=2037c88a577aa7ac8cb02d954dd8b563
    - user: root
    - group: wheel
    - mode: 750
    - if_missing: /usr/local/bin/filebeat
    - failhard: True

filebeat-config:
  file.managed:
    - name: /usr/local/etc/filebeat.yml
    - source: salt://filebeat/files/filebeat.yml.jinja
    - user: root
    - group: wheel
    - mode: 750
    - template: jinja
    - require:
      - file: filebeat-install

filebeat-init:
  file.managed:
    - name: /usr/local/etc/rc.d/filebeat
    - source: salt://filebeat/files/filebeat.rc
    - user: root
    - group: wheel
    - mode: 550
    - if_missing: /etc/rc.d/filebeat
    - failhard: True
    - require:
      - file: filebeat-config

filebeat-svc:
  service.running:
    - name: filebeat
    - enable: true
    - init_delay: 10
    - require:
      - file: filebeat-init
    - watch:
      - file: filebeat-config
