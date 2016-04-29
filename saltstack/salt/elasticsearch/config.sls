{% from "elasticsearch/map.jinja" import elasticsearch with context %}
{% set config = salt['pillar.get']('elasticsearch:config') %}
{% if config %}
elasticsearch-config:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://elasticsearch/files//elasticsearch.yml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        config: {{ config }}
{% endif %}
