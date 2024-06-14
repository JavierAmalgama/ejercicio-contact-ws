lock '3.4.0'

set :application, 'contacts'
set :repo_url, 'git@git.theamalgama.com:amalgama-ejercicios/contacts-ws.git'
set :deploy_to, '/srv/rails/contacts'
set :linked_files, fetch( :linked_files, [] ).push( 'config/database.yml', 'config/secrets.yml' )
set :linked_dirs, fetch( :linked_dirs, [] ).push( 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads' )
set :keep_releases, 2
