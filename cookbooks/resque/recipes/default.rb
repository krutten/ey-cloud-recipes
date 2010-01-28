resque_host = node[:utility_instances].detect do |instance|
  instance[:name] == "resque"
end[:hostname]

resque_workers_count = begin
  total_memory_kb = nil
  File.open('/proc/meminfo', 'r') do |fh|
    total_memory_line = fh.grep(/^MemTotal/).first
    total_memory_kb = total_memory_line[/(\d+)/, 1].to_i
  end

  # MB / size of one worker times 4
  result = total_memory_kb / 1024 / 240
  result /= 2 if node[:instance_role] == 'solo'
  result
end

if node[:name] == 'resque' || node[:instance_role] == 'solo'
  require_recipe "god"
  require_recipe "redis"

  template "/etc/god/resque.rb" do
    owner 'root'
    group 'root'
    mode 0644
    source "resque.rb.erb"
    variables(:resque_workers_count => resque_workers_count)
  end

  directory "/var/log/resque" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
  end

  node[:applications].each do |app, data|
    # app-server specific recipes usually take care of this
    link "/data/#{app}/shared/log" do
      to "/var/log/resque"
    end
  end
end

if %w[solo app app_master util].include? node[:instance_role]
  node[:applications].each do |app, data|
    template "/data/#{app}/shared/config/resque.yml" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0655
      source "resque.yml.erb"
      variables(:resque_host => resque_host)
    end
  end
end

