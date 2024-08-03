# frozen_string_literal: true

require 'socket'

# this is the documentation
class YourRedisServer
  def initialize(port)
    @port = port
  end

  def start
    Socket.tcp_server_loop(@port) do |sock, _|
      Thread.new do
        handle_event(sock)
        sock.close
      end
    end
  end

  private

  def handle_event(client)
    while event = client.gets&.chomp
      p event
      case event
      when 'PING'
        client.puts("+PONG\r")
      end
    end
  end
end

YourRedisServer.new(6379).start
