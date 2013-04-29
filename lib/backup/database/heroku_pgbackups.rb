require 'heroku/command/pgbackups'
require 'mechanize'

module Backup
  module Database
    class HerokuPgbackups < Base
      attr_accessor :name

      def initialize(model, database_id = nil, &block)
        super(model, database_id)

        instance_eval(&block) if block_given?
      end

      def perform!
        super

        dump_ext = 'pgdump'

        begin
          Heroku::Command::Pgbackups.new([], app: name, expire: true).capture

          backup_url = Heroku::Command::Pgbackups.new([], app: name).send(:pgbackup_client).get_latest_backup["public_url"]
        rescue RestClient::ServiceUnavailable, RestClient::InternalServerError
        end

        if backup_url
          agent = Mechanize.new
          File.open("#{File.join(@dump_path, name)}.#{dump_ext}", 'w') do |f|
            f.binmode
            f << agent.get_file(backup_url)
          end
        end
      end
    end
  end
end
