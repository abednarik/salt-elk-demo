logstash-forwarder-pkg:
  pkg.installed:
    - version: {{ pillar.logstash_forwarder_version }}

logstash-forwarder-svc:
  service.running:
    - name: {{logstash.svc}}
    - enable: true
    - require:
      - pkg: logstash-pkg
    - watch:
      - file: logstash-config-inputs
      - file: logstash-config-filters
      - file: logstash-config-outputs

logstash-config-outputs:
  file.managed:
    - name: /usr/local/etc/logstash/conf.d/03-outputs.conf
    - user: root
    - group: root
    - mode: 755
    - source: salt://logstash-forwarder/files/logstash_forwarder.conf
    - template: jinja
    - require:
      - pkg: logstash-forwarder-pkg
