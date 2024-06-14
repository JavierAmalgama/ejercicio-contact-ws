class Cors
	def initialize( app )
		@app = app
	end

	def call( env )
		if env[ 'REQUEST_METHOD' ] != 'OPTIONS'
			status, headers, body = @app.call env
		else
			body = self # Responds to each
			headers = { 'Content-Length' => '0' }
			status = 200
		end

		set_headers headers

		[ status, headers, body ]
	end

	def set_headers( headers )
		headers[ 'Access-Control-Allow-Origin' ] = '*' # Allow from ALL origins (dangerous).
		headers[ 'Access-Control-Allow-Credentials' ] = 'true' # Allow Authorization header, cookies, etc.
		headers[ 'Access-Control-Max-Age' ] = (3600 * 24 * 30).to_s # Cache the OPTIONS result (these headers) for a month
		headers[ 'Access-Control-Allow-Methods' ] = 'GET, HEAD, POST, PUT, DELETE, PATCH, OPTIONS' # Allow all methods
		headers[ 'Access-Control-Allow-Headers' ] = 'accept, authorization, content-type' # Allow these headers
	end

	def each
	end
end
