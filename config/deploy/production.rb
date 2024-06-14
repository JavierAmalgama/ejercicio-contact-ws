set :branch, 'master'
set :rails_env, 'production'
server 'dev2.amazon',
	user: 'deploy',
	roles: %w{app db web},
	ssh_options: {
		keys: [ File.join( ENV[ 'HOME' ], '.ssh', 'dev2-amazon-deploy.pem' ) ]
	}
