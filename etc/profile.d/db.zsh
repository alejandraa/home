# Configure the MySQL prompt to show more information.
MYSQL_PS1="\R:\m:\s \h> "

# PostgreSQL config
ARCHFLAGS='-arch x86_64'
PGDATA=/usr/local/var/postgres

# Hack to get around PostgreSQL not always being socket-connectable
#export PGHOST='localhost'
