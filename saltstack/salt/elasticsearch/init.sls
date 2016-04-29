{%- from 'elasticsearch/map.jinja' import elasticsearch with context %}

include:
  - .repo
  - .config

elasticsearch-pkg:
  pkg.{{elasticsearch.pkgstate}}:
    - name: {{elasticsearch.pkg}}
    - require:
      - pkgrepo: elasticsearch-repo

elasticsearch-svc:
  service.running:
    - name: {{elasticsearch.svc}}
    - enable: true
    - require:
      - pkg: elasticsearch-pkg
    - watch:
      - file: elasticsearch-config
