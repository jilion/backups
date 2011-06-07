##
# Backup
# Generated Template
#
# For more information:
#
# View the Git repository at https://github.com/meskyanichi/backup
# View the Wiki/Documentation at https://github.com/meskyanichi/backup/wiki
# View the issue log at https://github.com/meskyanichi/backup/issues
#
# When you're finished configuring this configuration file,
# you can run it from the command line by issuing the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]

Backup::Model.new(:backup, 'Jilion Backup') do

  ##
  # MongoDB [Database]
  #
  database MongoDB do |db|
    db.name               = "MySublime"
    db.username           = "backups"
    db.password           = ENV['MONGOHQ_MYSUBLIME_PASSWORD']
    db.host               = "swan.mongohq.com/app182505"
    db.port               = 5432
    db.lock               = false
  end

  ##
  # PostgreSQL [Database]
  #
  # database PostgreSQL do |db|
  #   db.name               = "my_database_name"
  #   db.username           = "my_username"
  #   db.password           = "my_password"
  #   db.host               = "localhost"
  #   db.port               = 5432
  #   db.socket             = "/tmp/pg.sock"
  #   db.skip_tables        = ['skip', 'these', 'tables']
  #   db.only_tables        = ['only', 'these' 'tables']
  #   db.additional_options = ['-xc', '-E=utf8']
  # end

  ##
  # SFTP (Secure File Transfer Protocol) [Storage]
  #
  store_with SFTP do |server|
    server.username = 'backups'
    server.password = ENV['SFTP_PASSWORD']
    server.ip       = 'team.jime.com'
    server.port     = 22
    server.path     = '/Shared Items/Backups'
    server.keep     = 20
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip do |compression|
    compression.best = true
    compression.fast = false
  end

  ##
  # Mail [Notifier]
  #
  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_failure           = true
  #
  #   mail.from                 = 'backup@jilion.com'
  #   mail.to                   = 'zeno@jilion.com'
  #   mail.address              = 'smtp.gmail.com'
  #   mail.port                 = 587
  #   mail.domain               = 'jilion.com'
  #   mail.user_name            = 'sender@email.com'
  #   mail.password             = ENV['GMAIL_PASSWORD']
  #   mail.authentication       = 'plain'
  #   mail.enable_starttls_auto = true
  # end

end
