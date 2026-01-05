# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Default Commands
# set :bundle_command, ""
# set :job_template, "bash -c ':job'"
set :output, "~/crontab.txt"

# job_type :command, ":task :output"
# job_type :rake,    "cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output"
# job_type :script,  "cd :path && :environment_variable=:environment :bundle_command script/:task :output"
# job_type :runner,  "cd :path && :bundle_command :runner_command -e :environment ':task' :output"

job_type :delayed_runner, "sleep 15 && cd :path && :bundle_command :runner_command -e :environment ':task' :output"

every 1.minute do
  runner "Notification.orcish_notification"
end

every 1.minute do
  delayed_runner "Notification.clean_orcish_notification_list"
end

# Learn more: http://github.com/javan/whenever
