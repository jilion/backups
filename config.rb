class HerokuPGBackup
  # Hack to download last pgbackups on local storage so it can be archived.
  def self.download(app)
    "#{system("curl -s `heroku pgbackups:url -a #{app}` -o #{app}.pgdump") && "#{app}.pgdump"}"
  end
end

Backup::Model.new(:jilion_backups, "All Jilion's databases") do
  archive :sv_my_pgdump do |archive|
    archive.root Dir.pwd
    archive.add HerokuPGBackup.download('sv-my')
  end
  archive :sv_videos_pgdump do |archive|
    archive.root Dir.pwd
    archive.add HerokuPGBackup.download('sv-videos')
  end

  database MongoDB, :sv_my_mongohq do |db|
    db.name     = 'app1790997'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_SUBLIMEVIDEO_MY_PASSWORD']
    db.host     = 'penny.mongohq.com'
    db.port     = 10079
    db.lock     = false
  end
  database MongoDB, :sv_stats_mongohq do |db|
    db.name     = 'app13829477'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_SUBLIMEVIDEO_STATS_PASSWORD']
    db.host     = 'candidate.5.mongolayer.com'
    db.port     = 10061
    db.lock     = false
  end
  database MongoDB, :sv_docs_mongohq do |db|
    db.name     = 'app3367763'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_SUBLIMEVIDEO_DOCS_PASSWORD']
    db.host     = 'alex.mongohq.com'
    db.port     = 10040
    db.lock     = false
  end
  database MongoDB, :sv_scout_mongohq do |db|
    db.name     = 'app5169288'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_SUBLIMEVIDEO_SCOUT_PASSWORD']
    db.host     = 'claire.mongohq.com'
    db.port     = 10083
    db.lock     = false
  end
  database MongoDB, :aelios_mongohq do |db|
    db.name     = 'aelios'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_AELIOS_PASSWORD']
    db.host     = 'rose.mongohq.com'
    db.port     = 10046
    db.lock     = false
  end
  database MongoDB, :jilion_www_mongohq do |db|
    db.name     = 'app7493976'
    db.username = 'backups'
    db.password = ENV['MONGOHQ_JILION_PASSWORD']
    db.host     = 'alex.mongohq.com'
    db.port     = 10033
    db.lock     = false
  end

  compress_with Gzip

  # # MacMini Storage
  # store_with SFTP do |server|
  #   server.username = 'backups'
  #   server.password = ENV['SFTP_PASSWORD']
  #   server.ip       = 'team.jime.com'
  #   server.port     = 22
  #   server.path     = '/Shared Items/Backups'
  #   server.keep     = 60
  # end

  store_with S3 do |s3|
    s3.access_key_id      = ENV['S3_ACCESS_KEY_ID']
    s3.secret_access_key  = ENV['S3_SECRET_ACCESS_KEY']
    s3.region             = 'us-east-1'
    s3.bucket             = 'jilion-backups'
    s3.path               = 'backups'
    s3.keep               = 60
  end

  notify_by Mail do |mail|
    mail.on_success = false
    mail.on_warning = false
    mail.on_failure = true

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

  notify_by Campfire do |campfire|
    campfire.on_success = true
    campfire.on_warning = true
    campfire.on_failure = true

    campfire.api_token = ENV['CAMPFIRE_TOKEN']
    campfire.subdomain = 'jilion'
    campfire.room_id   = 448517 # SV Dev
  end
end

Backup::Utilities.configure do
  mongo     'bin/mongo'
  mongodump 'bin/mongodump'
end
