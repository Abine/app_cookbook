#
# Cookbook Name:: app
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

# Set ip address that the application service is listening on.
# If instance has no public ip's first private ip will be used.
# User will be notified.
public_ip = node[:cloud][:public_ips][0]
private_ip = node[:cloud][:private_ips][0]

# See cookbooks/rightscale/libraries/helper.rb for the "is_valid_ip?" method.
if node[:app][:backend_ip_type] == "public" &&
  RightScale::Utils::Helper.is_valid_ip?(public_ip)
  node[:app][:ip] = public_ip
elsif RightScale::Utils::Helper.is_valid_ip?(private_ip)
  node[:app][:ip] = private_ip
else
  raise "No valid public/private IP found for the server."
end


# Let others know we are an appserver
# See http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/Chef_Resources#RightLinkTag
# for the "right_link_tag" resource.
right_link_tag "appserver:active=true"
right_link_tag "appserver:listen_ip=#{node[:app][:ip]}"
right_link_tag "appserver:listen_port=#{node[:app][:port]}"
