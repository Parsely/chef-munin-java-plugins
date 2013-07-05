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

Contributing
------------

License and Authors
-------------------
Authors: didier deshommes
