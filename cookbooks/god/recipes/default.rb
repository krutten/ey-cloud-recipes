gem_package "god" do
  action :install
end

directory "/etc/god" do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
end

template "/etc/god/config" do
  owner "root"
  group "root"
  mode 0644
  source "config.erb"
end

template "/tmp/god-inittab" do
  owner "root"
  group "root"
  mode 0644
  source "god-inittab.erb"
end

execute "make init work with god" do
  command "cat /tmp/god-inittab >>/etc/inittab"
  not_if "grep '# god config' /etc/inittab"
end

file "/tmp/god-inittab" do
  action :delete
end
