{%- if grains['os_family'] == 'Debian' %}
elasticsearch-repo-key:
  cmd.run:
    - name: wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
    - unless: apt-key list | grep 'Elasticsearch (Elasticsearch Signing Key)'

elasticsearch-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch Debian Repository
    - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
    - require:
      - cmd: elasticsearch-repo-key
{%- elif grains['os_family'] == 'RedHat' %}
elasticsearch-repo-key:
  cmd.run:
    - name:  rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - unless: rpm -qi gpg-pubkey-d88e42b4-52371eca

elasticsearch-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch repository for 2.x packages
    - baseurl: https://packages.elastic.co/elasticsearch/2.x/centos
    - gpgcheck: 1
    - gpgkey: https://packages.elastic.co/GPG-KEY-elasticsearch
    - enabled: 1
    - require:
      - cmd: elasticsearch-repo-key
{%- endif %}
