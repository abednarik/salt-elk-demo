base:
  '*':
    - common

  'saltmaster*':
    - logstash
    - elasticsearch
    - kibana
