module Backup
  class Model
    def set_storage_and_notification

      Backup::Utilities.configure do
        # Database Utilities
        mongo       'bin/mongo'
        mongodump   'bin/mongodump'
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
    end
  end
end
