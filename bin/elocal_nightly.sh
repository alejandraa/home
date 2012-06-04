# Download the latest database from stage.elocal.com and
# index the new data with Solr.

cd /Users/tom/Code/elocal/
thor db:import:stage
rake db:migrate
thor solr:index_accounts
thor solr:index_categories
thor solr:index_profiles
