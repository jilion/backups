require 'backup'

include Clockwork

every(24.hours, nil) do
  system 'bundle exec backup perform -t sublimevideo_mongohq -c config.rb'
end

every(6.hours, nil) do
  system 'bundle exec backup perform -t sublimevideo_pg,aelios_mongohq,jilion_mongohq,jilion_freckle -c config.rb'
end
