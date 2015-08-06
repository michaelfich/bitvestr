# To start the cronjob, execute the following UNIX command
# $ whenever --set environment=development --update-crontab
every 1.minute do
  rake "bitcoin:get"
end