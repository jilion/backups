require 'heroku/command/pgbackups'
require 'mechanize'

module Backup
  module Database
    class HerokuPgbackups < Base
      attr_accessor :name

      def initialize(model, &block)
        super(model)

        instance_eval(&block) if block_given?
      end

      def perform!
        super

        Heroku::Command::Pgbackups.new([], app: name, expire: true).capture
        backup_url = Heroku::Command::Pgbackups.new([], app: name).send(:pgbackup_client).get_latest_backup["public_url"]

        agent = Mechanize.new
        File.open("#{File.join(Config.tmp_path, name)}.pgdump", 'w') do |f|
          f.binmode
          f << agent.get_file(backup_url)
        end
      end
    end
  end
end
