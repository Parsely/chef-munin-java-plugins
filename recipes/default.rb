#
# Cookbook Name:: munin-java-plugins
# Recipe:: default
#
# Copyright 2013, Parsely
#
# All rights reserved - Do Not Redistribute
#

include_recipe "munin"

# install munin-java plugins
%w{munin munin-java-plugins}.each do |pkg|
    package pkg
end

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
end
