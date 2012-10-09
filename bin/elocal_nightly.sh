#!/bin/zsh
#
# Nightly database import script for eLocal.com.

# Download the latest database from our backup server
cd /Users/tom/Code/elocal/
bundle exec thor db:import:production

# Index the new data with Solr
#bundle exec thor solr:index_accounts
#bundle exec thor solr:index_profiles
#bundle exec thor solr:index_categories

# Send a confirmation email when everything is done
EMAIL="tubbo@psychedeli.ca"
SUBJECT="Imported the production database to playa."
MESSAGE="db:import:production has been run, and the database has been delivered to your local development machine."
echo "To: $EMAIL\nSubject:$SUBJECT\nContent-Type:text/plain;charset="us-ascii"\n\n$MESSAGE" | sendmail -t
