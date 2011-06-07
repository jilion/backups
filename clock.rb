require 'backup'

include Clockwork

every(6.hours, nil) do
  system 'bundle exec backup perform -t backup -c config.rb'
end
