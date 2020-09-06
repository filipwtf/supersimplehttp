class Response
	def initialize(code: , body: "")
		@response = 
			"HTTP/1.1 #{code}\r\n" +
			"Content-Length: #{body.size}\r\n" +
			"\r\n" +
			"#{body}\r\n"
	end

	def send(client)
		client.write(@response)
	end
end

class RequestParser
	REPLACEMENTS = [['%2e', '.'], ['%2f', '/'], ['%5c', ''], ['%255c', ''], ['.',''], [':', ':.'], ['=/', '']]

	def initialize(request)
		@request = request
	end

	def parse
		method, path, version = @request.lines[0].split
		path = normalize_path(path)

		if path.include? '?'
			query = path.split('?')[1]
			path = path.split('?')[0]
			query = parse_query(query)
		end

		headers = parse_headers(@request)

		body = nil
		if headers.has_key?(:"content-type")
			body = @request.split(/\n\r\n/)[1]
		end

		{
			method: method,
			version: version,
			path: path,
			query: query,
			headers: headers,
			body: body
		}
	end

=begin
	splits http headers and creates key values pairs
=end
	def parse_headers(headers_string)
		headers = {}
		headers_string.lines[1..-1].each do |line|
			return headers if line == "\r\n"
			header, value = line.split
			header = normalize(header)
			headers[header] = value
		end
	end

=begin
	This method parses url params
	https://developer.mozilla.org/en-US/docs/Web/API/URL/searchParams

	parameter = name=Jonathan%20Smith&age=18
	returns
	{
		:name=>"Jonathan Smith",
		:age=>"18"
	}

=end
	def parse_query(query_string)
		params = query_string.split('&')
		queries = {}
		params.each do |param|
			param, value = param.split('=')
			param, value = remove_encoded_space(param, value)
			param = normalize(param)
			queries[param] = value
		end 
		return queries
	end

	def normalize(data)
		data.gsub(":","").downcase.to_sym
	end

  # Remove url encoded space %20
	def remove_encoded_space(*args)
		index = 0;
		args.each do |arg|
			if arg.nil? == false
				args[index] = arg.gsub("%20", " ")
				index += 1
			end
		end
		
		return args
	end

	# Normalizes this URI's path. Not very clean but hopefully does the trick
	# https://owasp.org/www-community/attacks/Path_Traversal
	# https://docs.oracle.com/javase/7/docs/api/java/net/URI.html#normalize()
	def normalize_path(path)
		# Removes . any number
		# path.gsub!(/\.+/, ".")
		REPLACEMENTS.each do |replacement|
			path.gsub!(replacement[0], replacement[1])
		end
		return path
	end
end