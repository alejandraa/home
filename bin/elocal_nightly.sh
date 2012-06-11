# Download the latest database from stage.elocal.com and
# index the new data with Solr.

cd /Users/tom/Code/elocal/
bundle exec thor db:import:stage
bundle exec rake db:migrate
bundle exec thor solr:index_accounts
bundle exec thor solr:index_categories
bundle exec thor solr:index_profiles
