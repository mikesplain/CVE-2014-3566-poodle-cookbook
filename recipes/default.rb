#
# Cookbook Name:: CVE-2014-3566-poodle
# Recipe:: default
#

# All rights reserved - Do Not Redistribute
#
# Check for poodle vulnerability

node['CVE-2014-3566-poodle']['ports'].each do |port|
  execute "CVE-2014-3566 test of port #{port}" do
    command "openssl s_client -connect localhost:443 -ssl3 < /dev/null"
    returns [1] # The grep should fail and exit with 1
  end
end
