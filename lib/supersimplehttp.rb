require 'socket'
require 'pp'
require "supersimplehttp/version"
require_relative 'http'

module Supersimplehttp
  class Error < StandardError; end
  class Server
    def initialize(addr, port, &block)
      @server = TCPServer.new(addr, port)
      if block
        puts block.call()
      end
      run
    end

    def run
      loop do
        Thread.start(@server.accept) do |client|
          request = client.readpartial(2048)
          
          request = RequestParser.new(request).parse
          response = ResponsePreparer.new.prepare_response(request)
          puts "[#{Time.now.strftime("%H:%M:%S")}] #{client.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"
          # Pretty print request
          # STDERR.puts PP.pp(request, $>, 40)
          response.send(client)
          client.close 
        end
      end
    end
  end
end
