base:

  'monitor':
    - logstash
    - elasticsearch
    - elasticsearch.config
    - kibana

  'client':
    - filebeat
