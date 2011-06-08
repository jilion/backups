require 'heroku/command/pgbackups'

module Backup
  module Database
    class HerokuPgbackups < Base
      attr_accessor :name

      def initialize(&block)
        instance_eval(&block)
        prepare!
      end

      def perform!
        log!

        Heroku::Command::Pgbackups.new([], app: name, expire: true).capture
        backup_url = Heroku::Command::Pgbackups.new([], app: name).send(:pgbackup_client).get_latest_backup["public_url"]

        File.open("#{File.join(dump_path, name)}.pgdump", 'w') do |f|
          f.binmode
          f << Net::HTTP.get(URI.parse(backup_url))
        end
      end
    end
  end
end
