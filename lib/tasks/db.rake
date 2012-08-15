require 'logger'
require 'fileutils'

namespace :db do
  HOME    = ENV['HOME']
  EMAIL   = ENV['EMAIL']   || "tubbo@psychedeli.ca"
  DRY_RUN = ENV['DRY_RUN'] || false
  RAILS_ENV = ENV['RAILS_ENV'] || "stage"

  desc "Import the eLocal stage database and send an email when it's done."
  task :import do
    puts "Writing logs to #{HOME}/log/tasklog"
    sh "cat /dev/null > #{HOME}/log/tasklog"
    logger = Logger.new("#{HOME}/log/tasklog")
    logger.formatter = proc do |severity, datetime, progname, msg|
      puts msg
      "#{severity}: #{msg}\n"
    end

    logger.info "Entering eLocal app directory"
    cd "#{HOME}/Code/elocal"

    logger.info "Importing #{RAILS_ENV} database content"
    sh "bundle exec thor db:import:#{RAILS_ENV} > /dev/null" unless DRY_RUN
    logger.info "..done"

    logger.info "Migrating database structure"
    sh "bundle exec rake db:migrate > log/tasklog" unless DRY_RUN
    logger.info "..done"

    logger.info "Database import complete."

    logger.info "Indexing accounts"
    sh "bundle exec thor solr:index_accounts > /dev/null" unless DRY_RUN
    logger.info "..done"

    logger.info "Indexing categories"
    sh "bundle exec thor solr:index_categories > /dev/null" unless DRY_RUN
    logger.info "..done"

    logger.info "Indexing profiles"
    sh "bundle exec thor solr:index_profiles > /dev/null" unless DRY_RUN
    logger.info "..done"

    logger.info "Solr index complete."

    puts "Building email notification to '#{EMAIL}'"
    raw_log = IO.read("#{HOME}/log/tasklog")
    logs = "<code><pre>#{raw_log}</pre></code>"
    subject = "#{RAILS_ENV.capitalize} database import succeeded."
    body = "<p>Successfully imported the eLocal #{RAILS_ENV} database to playa.</p><p>#{logs}</p>"
    sh %x(echo 'To: tubbo@psychedeli.ca\nSubject: #{subject}\nContent-Type: text/html;charset="us-ascii"\n\n<html><body>#{body}</body></html>' | sendmail -t)
    puts "Delivered email notification to '#{EMAIL}'"
  end
end
