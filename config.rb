# require './lib/backup/database/heroku_pgbackups'
require './lib/backup/database/freckle'

require './config_storage_and_notification'

# ================
# = SublimeVideo =
# ================
Backup::Model.new(:sublimevideo_stats_mongohq, 'SublimeVideo Stats MongoHQ') do
  database MongoDB do |db|
    db.name         = 'sublimevideo-stats'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_SUBLIMEVIDEO_STATS_PASSWORD']
    db.host         = 'sublimevideo.member0.mongolayer.com'
    db.port         = 27017
    db.lock         = false
    db.mongodump_utility = 'bin/mongodump'
  end
  set_storage_and_notification
end

Backup::Model.new(:sublimevideo_pg, 'SublimeVideo Postgresql') do
  database PostgreSQL do |db|
    db.name               = "dcftn9e5gvbo4"
    db.username           = "u3h1mmhdcv07su"
    db.password           = ENV['HEROKU_SUBLIMEVIDEO_PG_PASSWORD']
    db.host               = "ec2-107-20-139-83.compute-1.amazonaws.com"
    db.port               = 5592
  end
  set_storage_and_notification
end

# ==========
# = Aelios =
# ==========
Backup::Model.new(:aelios_mongohq, 'Aelios MongoHQ') do
  database MongoDB do |db|
    db.name         = 'aelios'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_AELIOS_PASSWORD']
    db.host         = 'rose.mongohq.com'
    db.port         = 10046
    db.lock         = false
    db.mongodump_utility = 'bin/mongodump'
  end
  set_storage_and_notification
end

# ==========
# = Jilion =
# ==========
Backup::Model.new(:jilion_mongohq, 'Jilion MongoHQ') do
  database MongoDB do |db|
    db.name         = 'app275333'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_JILION_PASSWORD']
    db.host         = 'flame.mongohq.com'
    db.port         = 27073
    db.lock         = false
    db.mongodump_utility = 'bin/mongodump'
  end
  set_storage_and_notification
end

Backup::Model.new(:jilion_freckle, 'Jilion Freckle') do
  database Backup::Database::Freckle do |db|
    db.name      = 'jilion'
    db.email     = 'thibaud@jilion.com'
    db.password  = ENV['FRECKLE_PASSWORD']
    db.from_date = '2009-09-01'
  end
  set_storage_and_notification
end
