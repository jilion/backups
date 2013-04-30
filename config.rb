Backup::Model.new(:jilion_backups, "All Jilion's databases") do

  database PostgreSQL, :sv_videos do |db|
    db.name               = "dcftn9e5gvbo4"
    db.username           = "u3h1mmhdcv07su"
    db.password           = ENV['SV_VIDEOS_PG_PASSWORD']
    db.host               = "ec2-54-235-124-104.compute-1.amazonaws.com"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
  end

  # ===================
  # = MacMini Storage =
  # ===================
  store_with Storage::SFTP do |server|
    server.username = 'backups'
    server.password = ENV['SFTP_PASSWORD']
    server.ip       = 'team.jime.com'
    server.port     = 22
    server.path     = '/Shared Items/Backups'
    server.keep     = 60
  end

  compress_with Compressor::Gzip

  # =====================
  # = Mail Notification =
  # =====================
  notify_by Notifier::Mail do |mail|
    mail.on_success           = false
    mail.on_warning           = false
    mail.on_failure           = true

    mail.from           = 'backups@jilion.com'
    mail.to             = 'zeno@jilion.com, thibaud@jilion.com'
    mail.address        = 'smtp.gmail.com'
    mail.port           = 587
    mail.domain         = 'jilion.com'
    mail.user_name      = 'backups@jilion.com'
    mail.password       = ENV['GMAIL_PASSWORD']
    mail.authentication = 'plain'
    mail.encryption     = :starttls
  end

  # =========================
  # = Campfire Notification =
  # =========================
  notify_by Notifier::Campfire do |campfire|
    campfire.on_success = true
    campfire.on_warning = true
    campfire.on_failure = true

    campfire.api_token = ENV['CAMPFIRE_TOKEN']
    campfire.subdomain = 'jilion'
    campfire.room_id   = "SV+Dev"
  end

  # ===========================
  # = Utilities Configuration =
  # ===========================
  Backup::Utilities.configure do
    # Database Utilities
    mongo       'bin/mongo'
    mongodump   'bin/mongodump'
  end

end

# require './lib/backup/database/heroku_pgbackups'
# require './config_storage_and_notification'

# # ================
# # = SublimeVideo =
# # ================
# Backup::Model.new(:sublimevideo_stats_mongohq, 'SublimeVideo Stats MongoHQ') do
#   database MongoDB, :sublimevideo_stats_mongohq do |db|
#     db.name         = 'sublimevideo-stats'
#     db.username     = 'backups'
#     db.password     = ENV['MONGOHQ_SUBLIMEVIDEO_STATS_PASSWORD']
#     db.host         = 'sublimevideo.member0.mongolayer.com'
#     db.port         = 27017
#     db.lock         = false
#   end
#   set_storage_and_notification
# end

# Backup::Model.new(:my_sublimevideo_pg, 'My SublimeVideo Postgresql') do
#   database Backup::Database::HerokuPgbackups, :my_sublimevideo_pg do |db|
#     db.name = 'sv-my'
#   end
#   set_storage_and_notification
# end

# Backup::Model.new(:videos_sublimevideo_pg, 'Videos SublimeVideo Postgresql') do



#   database Backup::Database::HerokuPgbackups, :videos_sublimevideo_pg do |db|
#     db.name = 'sv-videos'
#   end
#   set_storage_and_notification
# end

# # ==========
# # = Aelios =
# # ==========
# Backup::Model.new(:aelios_mongohq, 'Aelios MongoHQ') do
#   database MongoDB, :aelios_mongohq do |db|
#     db.name         = 'aelios'
#     db.username     = 'backups'
#     db.password     = ENV['MONGOHQ_AELIOS_PASSWORD']
#     db.host         = 'rose.mongohq.com'
#     db.port         = 10046
#     db.lock         = false
#   end
#   set_storage_and_notification
# end

# # ==========
# # = Jilion =
# # ==========
# Backup::Model.new(:jilion_mongohq, 'Jilion MongoHQ') do
#   database MongoDB, :jilion_mongohq do |db|
#     db.name         = 'app7493976'
#     db.username     = 'backups'
#     db.password     = ENV['MONGOHQ_JILION_PASSWORD']
#     db.host         = 'alex.mongohq.com'
#     db.port         = 10033
#     db.lock         = false
#   end
#   set_storage_and_notification
# end
