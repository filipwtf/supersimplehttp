require 'supersimplehttp'

port = 5000
addr = 'localhost'

server = Supersimplehttp::Server.new(addr, port) { "[Supersimplehttp] running on #{addr}:#{port}" }