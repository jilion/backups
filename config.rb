require './lib/backup/database/heroku_pgbackups'
require './config_storage_and_notification'

# ================
# = SublimeVideo =
# ================
Backup::Model.new(:sublimevideo_stats_mongohq, 'SublimeVideo Stats MongoHQ') do
  database MongoDB, :sublimevideo_stats_mongohq do |db|
    db.name         = 'sublimevideo-stats'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_SUBLIMEVIDEO_STATS_PASSWORD']
    db.host         = 'sublimevideo.member0.mongolayer.com'
    db.port         = 27017
    db.lock         = false
  end
  set_storage_and_notification
end

Backup::Model.new(:my_sublimevideo_pg, 'My SublimeVideo Postgresql') do
  database Backup::Database::HerokuPgbackups, :my_sublimevideo_pg do |db|
    db.name = 'sv-my'
  end
  set_storage_and_notification
end

Backup::Model.new(:videos_sublimevideo_pg, 'Videos SublimeVideo Postgresql') do
  database Backup::Database::HerokuPgbackups, :videos_sublimevideo_pg do |db|
    db.name = 'sv-videos'
  end
  set_storage_and_notification
end

# ==========
# = Aelios =
# ==========
Backup::Model.new(:aelios_mongohq, 'Aelios MongoHQ') do
  database MongoDB, :aelios_mongohq do |db|
    db.name         = 'aelios'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_AELIOS_PASSWORD']
    db.host         = 'rose.mongohq.com'
    db.port         = 10046
    db.lock         = false
  end
  set_storage_and_notification
end

# ==========
# = Jilion =
# ==========
Backup::Model.new(:jilion_mongohq, 'Jilion MongoHQ') do
  database MongoDB, :jilion_mongohq do |db|
    db.name         = 'app7493976'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_JILION_PASSWORD']
    db.host         = 'alex.mongohq.com'
    db.port         = 10033
    db.lock         = false
  end
  set_storage_and_notification
end
