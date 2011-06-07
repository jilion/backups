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
    db.name               = "my_database_name"
    db.username           = "my_username"
    db.password           = "my_password"
    db.host               = "localhost"
    db.port               = 5432
    db.ipv6               = false
    db.only_collections   = ['only', 'these' 'collections']
    db.additional_options = []
    db.lock               = false
  end

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = "my_database_name"
    db.username           = "my_username"
    db.password           = "my_password"
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
    db.skip_tables        = ['skip', 'these', 'tables']
    db.only_tables        = ['only', 'these' 'tables']
    db.additional_options = ['-xc', '-E=utf8']
  end

  ##
  # SFTP (Secure File Transfer Protocol) [Storage]
  #
  store_with SFTP do |server|
    server.username = 'my_username'
    server.password = 'my_password'
    server.ip       = '123.45.678.90'
    server.port     = 22
    server.path     = '~/backups/'
    server.keep     = 5
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
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_failure           = true

    mail.from                 = 'sender@email.com'
    mail.to                   = 'receiver@email.com'
    mail.address              = 'smtp.gmail.com'
    mail.port                 = 587
    mail.domain               = 'your.host.name'
    mail.user_name            = 'sender@email.com'
    mail.password             = 'my_password'
    mail.authentication       = 'plain'
    mail.enable_starttls_auto = true
  end

end
