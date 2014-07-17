#
# Cookbook Name:: munin-java-plugins
# Recipe:: default
#
# Copyright 2013, Parsely
#
# All rights reserved - Do Not Redistribute
#

include_recipe "munin::client"

# install munin-java plugins
package 'munin'
if node['platform'] == "ubuntu" && node['platform_version'] >= "14.04"
  package 'munin-plugins-java'
else
  package 'munin-java-plugins'
end

# Capture all Java processes running JMX, making sure we exclude the grep
java_processes =  `ps aux | grep [j]mxremote`
regex_matches = /jmxremote\.port=(\d+)/.match(java_processes) if java_processes
jmx_port = regex_matches[1] if regex_matches

if jmx_port
  # Create file in /etc/munin/plugin-conf.d/ to be read after munin-node (alphabetically read)
  template "/etc/munin/plugin-conf.d/munin-node-jmx" do
    source 'munin-node-jmx.erb'
    mode   '0644'
    variables({
      :port => jmx_port
    })
    notifies :restart, resources(:service => "munin-node"), :delayed
  end

  # Create munin plugin links
  bash 'configure Munin JMX plugin' do
    code <<-EOH
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ClassesLoaded
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ClassesLoadedTotal
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_CurrentThreadCpuTime
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_CurrentThreadUserTime
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_GCCount
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_GCTime
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_MemoryAllocatedHeap
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_MemoryAllocatedNonHeap
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_emorySurvivorPeak
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_MemorySurvivorUsage
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_Threads
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ThreadsDaemon
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ThreadsDeadlocked
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ThreadsPeak
sudo ln -s /usr/share/munin/plugins/jmx_ /etc/munin/plugins/jmx_ThreadsStartedTotal
EOH
    not_if { ::File.exists?("/etc/munin/plugins/jmx_ClassesLoaded") }
    notifies :restart, resources(:service => "munin-node"), :delayed
  end
end
