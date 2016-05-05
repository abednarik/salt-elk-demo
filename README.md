# Setup Elasticsearch and Kibana with SaltStack

## Environment

This demo is based on 2 instances: **monitor** the central server
running Elasticsearch and Kibana in Ubuntu 14.04 LTS and
a **client** server running [filebeat](https://www.elastic.co/products/beats/filebeat)
in FreeBSD 10.

Both servers run SaltStack: **monitor** is running a salt master and minion and **client** is running a minion.

## Run Demo

- Start Vagrant boxes

  `vagrant up`

This step can take a while since we need to download 2 boxes on for Ubuntu and one for FreeBSD

- After both boxes are running, login to *monitor* box and check salt is running
in both instances

  `vagrant ssh monitor`

  `sudo salt \* test.ping`

You should see something like This

  ```yml
  monitor:
    True
  client:
    True
  ```

- Deploy *monitor* server using salt

  `sudo salt 'monitor' state.highstate`

- After salt completes server provisioning Elasticsearch and Kibana should be running.
Launch a Browser and go to **http://localhost:5601/status#/** to check Kibana status.
If you see *Status: Green* Kibana is ready to be configured. Once filebeat is up and
running we need to set the index pattern to make Kibana able to show logs. Will do
this later.

- Now we need to setup filebeat in **client** server. running

  `sudo salt client state.highstate`

Now we should have filebeat installed and running.

- Go back to Kibana and just enter *filebeat-** instead of *logstash-**.

Everything should be working now. If you want to generate some logs run a few commands
to install a few packages

  `sudo salt 'client' pkg.install vim`
