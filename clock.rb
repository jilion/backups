require 'backup'

include Clockwork

# every(24.hours, nil) do
#   system 'bundle exec backup perform -t sublimevideo_stats_mongohq -c config.rb -l .'
# end

# every(6.hours, nil) do
#   %w[sublimevideo_pg aelios_mongohq jilion_mongohq jilion_freckle].each do |backup|
#     system "bundle exec backup perform -t #{backup} -c config.rb -l ."
#   end
# end

every(6.hours, nil) do
  system "bundle exec backup perform -t sublimevideo_pg -c config.rb -l ."
end
