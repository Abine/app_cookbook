#
# Cookbook Name:: app
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Updating project code repository"
# See cookbooks/app_<providers>/providers/default.rb for the "code_update" action.
app "default" do
  destination node[:app][:destination]
  action :code_update
end

log "  Restarting application server"
# See cookbooks/app_<providers>/providers/default.rb for the "restart" action.
app "default" do
  action :restart
end
