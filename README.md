munin-java-plugins Cookbook
===========================
Installs and configures munin java plugins

Requirements
------------

#### packages
- `munin` - munin-java-plugins needs the munin recipe

Attributes
----------

Usage
-----
#### munin-java-plugins::default

Just include `munin-java-plugins` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[munin-java-plugins]"
  ]
}
```

The munin java plugins leverage JMX to communicate to the JVM about the state of 
your application.

The recipe will automatically detect any running java processes in your ps tree and
find the JMX port it is using. It will specifically look for `jmxremote.port=(\d+)`,

Example JVM argument: `-Dcom.sun.management.jmxremote.port=7199` 

If it finds the port, which in this case is 7199, the recipe will create a plugin
configuration file (generally located in /etc/munin/plugin-conf.d). Munin reads
these files alphabetically and takes the last configuration block. Thus
munin-node-jmx will be read after munin-node (package installed file), and if 
you need any further configuration, create a file in this directory to be read 
after munin-node-jmx.

If no port is found, the munin java plugins will be installed but not setup to run
(i.e. no symlink from /etc/munin/plugins to the plugin)

*Note*: This recipe is written for only 1 JMX per host. Further improvement is 
needed to support more than one per host.

Contributing
------------

License and Authors
-------------------
Authors: didier deshommes
