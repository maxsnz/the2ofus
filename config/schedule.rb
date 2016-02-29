env :MAILTO, 'gmaxsnz@gmail.com'

set :output, { standard: 'log/cron.log' }

every '0 * 19,20,21 6 *' do
  runner 'ImportPhotos.call'
end

# every '15,30,45,59 * * 4,5,6 *' do
#   runner 'UpdateRatingsByDate.call(Date.today)'
# end
