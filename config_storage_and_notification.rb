module Backup
  class Model
    def set_storage_and_notification
      # ===================
      # = MacMini Storage =
      # ===================
      store_with Storage::SFTP do |server|
        server.username = 'backups'
        server.password = ENV['SFTP_PASSWORD']
        server.ip       = 'team.jime.com'
        server.port     = 22
        server.path     = '/Shared Items/Backups'
        server.keep     = 20
      end

      compress_with Compressor::Gzip do |compression|
        compression.best = true
        compression.fast = false
      end

      # =====================
      # = Mail Notification =
      # =====================
      notify_by Notifier::Mail do |mail|
        mail.on_success           = true
        mail.on_failure           = true

        mail.from                 = 'backups@jilion.com'
        mail.to                   = 'zeno@jilion.com, thibaud@jilion.com'
        mail.address              = 'smtp.gmail.com'
        mail.port                 = 587
        mail.domain               = 'jilion.com'
        mail.user_name            = 'backups@jilion.com'
        mail.password             = ENV['GMAIL_PASSWORD']
        mail.authentication       = 'plain'
        mail.enable_starttls_auto = true
      end
    end
  end
end
