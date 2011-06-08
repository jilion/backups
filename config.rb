require './lib/backup/database/heroku_pgbackups'
require './lib/backup/database/freckle'

Backup::Model.new(:backup, 'Jilion Backup') do

  # =======================
  # = my.sublimevideo.net =
  # =======================
  database MongoDB do |db|
    db.name         = 'app182505'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_MYSUBLIME_PASSWORD']
    db.host         = 'swan.mongohq.com'
    db.port         = 27021
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end

  database Backup::Database::HerokuPgbackups do |db|
    db.name = 'mysublime'
  end

  # ====================
  # = sublimevideo.net =
  # ====================
  database Backup::Database::HerokuPgbackups do |db|
    db.name = 'sublime'
  end

  # =================
  # = aeliosapp.com =
  # =================
  database MongoDB do |db|
    db.name         = 'aelios'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_AELIOS_PASSWORD']
    db.host         = 'rose.mongohq.com'
    db.port         = 10046
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end

  # ==============
  # = jilion.com =
  # ==============
  database MongoDB do |db|
    db.name         = 'app275333'
    db.username     = 'backups'
    db.password     = ENV['MONGOHQ_JILION_PASSWORD']
    db.host         = 'flame.mongohq.com'
    db.port         = 27073
    db.lock         = false
    db.utility_path = 'bin/mongodump'
  end

  # ==========================
  # = jilion.letsfreckle.com =
  # ==========================
  database Backup::Database::Freckle do |db|
    db.name      = 'jilion'
    db.email     = 'thibaud@jilion.com'
    db.password  = ENV['FRECKLE_PASSWORD']
    db.from_date = '2009-09-01'
  end


  # ===================
  # = MacMini Storage =
  # ===================
  store_with SFTP do |server|
    server.username = 'backups'
    server.password = ENV['SFTP_PASSWORD']
    server.ip       = 'team.jime.com'
    server.port     = 22
    server.path     = '/Shared Items/Backups'
    server.keep     = 20
  end

  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

  # =====================
  # = Mail Notification =
  # =====================
  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_failure           = true
  #
  #   mail.from                 = 'backups@jilion.com'
  #   mail.to                   = 'zeno@jilion.com, thibaud@jilion.com'
  #   mail.address              = 'smtp.gmail.com'
  #   mail.port                 = 587
  #   mail.domain               = 'jilion.com'
  #   mail.user_name            = 'backups@jilion.com'
  #   mail.password             = ENV['GMAIL_PASSWORD']
  #   mail.authentication       = 'plain'
  #   mail.enable_starttls_auto = true
  # end

end
