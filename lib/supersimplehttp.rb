require 'socket'
require 'pp'
require "supersimplehttp/version"
require_relative 'http'

module Supersimplehttp
  class Error < StandardError; end
  class Server
    def initialize(addr, port)
      @server = TCPServer.new(addr, port)
      run
    end
  
    def run
      puts "Server is running"
      loop do
        Thread.start(@server.accept) do |client|
          request = client.readpartial(2048)
          
          request = RequestParser.new(request).parse
  
          # Pretty print request
          STDERR.puts PP.pp(request, $>, 40)
  
        Response.new(code: 200, body: "Hello").send(client)
        client.close 
        end
      end
    end
  end
end
