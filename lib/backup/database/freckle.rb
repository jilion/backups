require 'mechanize'

module Backup
  module Database
    class Freckle < Base
      attr_accessor :name
      attr_accessor :email
      attr_accessor :password
      attr_accessor :from_date

      alias :subdomain :name

      def initialize(&block)
        instance_eval(&block)
        prepare!
      end

      def perform!
        log!

        agent = login_agent
        %w[html csv].each do |format|
          open("#{File.join(dump_path, subdomain)}.#{format}", 'w') do |f|
            f.puts agent.get_file(report_url(format))
          end
        end
      end

    private

      def login_agent
        agent = Mechanize.new
        agent.get("https://#{subdomain}.letsfreckle.com/signin")
        form          = agent.page.forms.first
        form.email    = email
        form.password = password
        form.submit
        agent
      end

      def report_url(format)
        "http://#{subdomain}.letsfreckle.com/time/report/from/#{from_date}/to/#{to_date}.#{format}"
      end

      def to_date
        @to_date ||= Date.today.to_s
      end

    end
  end
end
