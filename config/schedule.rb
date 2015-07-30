# To start the cronjob, execute the following UNIX command
# $ whenever --set environment=development --update-crontab
var minutes = 0.2
every minutes.minute do
  rake "bitcoin:get"
end