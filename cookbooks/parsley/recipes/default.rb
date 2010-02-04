#
# Cookbook Name:: parsley
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

    directory "/var/cache/src" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    execute "install_parsley" do
      command %Q{
        cd /var/cache/src && git clone git://github.com/krutten/parsley.git
        cd parsley && ./build_install.sh
      }
    end
end
