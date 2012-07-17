require 'gmail'
require 'logger'
require 'fileutils'

namespace :db do
  desc "Import the eLocal stage database and send an email when it's done."
  task :import do
    HOME    = ENV['HOME']
    EMAIL   = ENV['EMAIL']   || "tubbo@psychedeli.ca"
    DRY_RUN = ENV['DRY_RUN'] || false

    puts "Writing logs to #{HOME}/log/tasklog"
    sh "cat /dev/null > #{HOME}/log/tasklog"
    logger = Logger.new("#{HOME}/log/tasklog")
    logger.formatter = proc do |severity, datetime, progname, msg|
      puts msg
      "#{severity}: #{msg}\n"
    end

    logger.info "Entering eLocal app directory"
    cd "#{HOME}/Code/elocal"

    logger.info "Importing stage database content"
    sh "bundle exec thor db:import:stage > /dev/null" unless DRY_RUN
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
    gmail = Gmail.new('elocal.leads.proxy', 'EMg4p2yE%7^Gp}dQ(8Um')
    gmail.deliver do
      to EMAIL
      subject "Stage Database Download Complete on 'playa'"
      text_part do
        body IO.read("#{HOME}/log/tasklog")
      end
    end

    puts "Delivered email notification to '#{EMAIL}'"
  end
end
