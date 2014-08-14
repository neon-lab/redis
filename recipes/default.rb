#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright (C) 2013 Julian Tescher
# 
# License: MIT
#

# Install the python dependencies
include_recipe 'build-essential'
include_recipe 's3cmd::default'

# Install Redis
# https://neon-dependencies.s3.amazonaws.com/redis-2.8.4.ubuntu.12.04_amd64.deb
remote_file "/tmp/redis-installer.deb" do
  source "{#node[:redis][:redis_pkg_link]}"
  mode 0644
end

dpkg_package "redis" do
  source "/tmp/redis-installer.deb"
  action :install
end

# Create Redis user
user node[:redis][:user] do
  home node[:redis][:install_dir]
  comment 'Redis Administrator'
  supports :manage_home => false
  system true
end

# Own install directory
directory node[:redis][:install_dir] do
  owner node[:redis][:user]
  group node[:redis][:group]
  recursive true
end

# Create Redis configuration directory
directory node[:redis][:conf_dir] do
  owner 'root'
  group 'root'
  mode '0755'
end

# Create Redis database directory
directory node[:redis][:db_dir] do
  owner node[:redis][:user]
  mode '0750'
end

# Write config file and restart Redis
template '/etc/init.d/redis' do
  source 'redis_init_script.erb'
  mode '0744'
end

# Write config file and restart Redis
template "#{node[:redis][:conf_dir]}/#{node[:redis][:port]}.conf" do
  source 'redis.conf.erb'
  mode '0644'
end

# Write redis backup script 
template '/etc/init.d/redis-backup' do
  source 'redis-backup.erb'
  mode '0755'
end
  
# Set up redis service
service 'redis' do
  supports :reload => false, :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

# Ensure change notifies redis to restart (Comes after resource decliration for OpsWorks chef ~ 9.15) :(
template "#{node[:redis][:conf_dir]}/#{node[:redis][:port]}.conf" do
  notifies :restart, resources(:service => 'redis')
end

# Setup the cronjob to run the redis backup
cron "redis_backup_cron" do
    action :create
    user "redis"
    hour "12"
    day "*"
    minute "00"
    mailto "ops@neon-lab.com"
    command "/etc/init.d/redis-backup"
end


