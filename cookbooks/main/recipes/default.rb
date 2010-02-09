# Testing lines, shows this Chef recipe running
#execute "testing" do
#  command %Q{
#    echo "i ran at #{Time.now}" >> /root/cheftime
#  }
#end

# uncomment if you want to run couchdb recipe
# require_recipe "couchdb"

# uncomment to turn use the MBARI ruby patches for decreased memory usage and better thread/continuationi performance
# require_recipe "mbari-ruby"

# uncomment to turn on thinking sphinx 
# require_recipe "thinking_sphinx"

# uncomment to turn on ultrasphinx 
# require_recipe "ultrasphinx"

# uncomment to turn on resque, redis and god
#require_recipe 'resque'

# uncomment to install parsley
#require_recipe 'parsley'

# Recipe:: default
#
 
#if (node[:instance_role] == 'db_master')
#  cron "ey-binlogs" do
#    minute '00'
#    hour '*/2'
#    day '*'
#    month '*'
#    weekday '*'
#    command "cd /root/eydba/binary_logs/ && date >> binlog.log && ./binary_log_purge.rb >> binlog.log && date >> binlog.log"
#  end
#end
