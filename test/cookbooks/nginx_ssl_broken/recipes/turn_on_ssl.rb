#
# Cookbook Name:: installnginx
# Recipe:: turn_on_ssl
#
# Copyright (C) 2014 PayPal, Inc.
#
# All rights reserved - Do Not Redistribute
#

template "#{node['nginx']['dir']}/sites-available/test" do
  source 'test-site.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :immediately
end

%w{
  server.crt
  server.key
}.each do |file|
  cookbook_file file do
    path "/etc/nginx/#{file}"
    action :create
  end
end

nginx_site 'test' do
  enable true
end

service "nginx" do
  action :restart
end
