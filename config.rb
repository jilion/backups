require './lib/backup/database/heroku_pgbackups'
require './lib/backup/database/freckle'

require './config_storage_and_notification'

# =======================
# = my.sublimevideo.net =
# =======================
Backup::Model.new(:mysublime_mongohq, 'MySublime MongoHQ') do
  database MongoDB do |db|
    db.name         = 'app182505'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_MYSUBLIME_PASSWORD']
    db.host         = 'swan.mongohq.com'
    db.port         = 27021
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end
  set_storage_and_notification
end

Backup::Model.new(:mysublime_pg, 'MySublime Postgresql') do
  database Backup::Database::HerokuPgbackups do |db|
    db.name = 'mysublime'
  end
  set_storage_and_notification
end

# ====================
# = sublimevideo.net =
# ====================
Backup::Model.new(:sublime_pg, 'Sublime Postgresql') do
  database Backup::Database::HerokuPgbackups do |db|
    db.name = 'sublime'
  end
  set_storage_and_notification
end

# ======================
# = data.aeliosapp.com =
# ======================
Backup::Model.new(:aelios_mongohq, 'Aelios MongoHQ') do
  database MongoDB do |db|
    db.name         = 'aelios'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_AELIOS_PASSWORD']
    db.host         = 'rose.mongohq.com'
    db.port         = 10046
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end
  set_storage_and_notification
end

# ==============
# = jilion.com =
# ==============
Backup::Model.new(:jilion_mongohq, 'Jilion MongoHQ') do
  database MongoDB do |db|
    db.name         = 'app275333'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_JILION_PASSWORD']
    db.host         = 'flame.mongohq.com'
    db.port         = 27073
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end
  set_storage_and_notification
end

# ==========================
# = jilion.letsfreckle.com =
# ==========================
Backup::Model.new(:jilion_freckle, 'Jilion Freckle') do
  database Backup::Database::Freckle do |db|
    db.name      = 'jilion'
    db.email     = 'thibaud@jilion.com'
    db.password  = ENV['FRECKLE_PASSWORD']
    db.from_date = '2009-09-01'
  end
  set_storage_and_notification
end