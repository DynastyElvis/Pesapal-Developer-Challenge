# This implementation uses Ruby's TCPServer to create a TCP server that listens on a specified port. The start method starts a new thread that listens for incoming connections and assigns them the next available rank. The handle_connection method assigns the rank to the client and starts a new thread to listen to messages from the client. The listen_to_client method listens to the client's messages and executes commands if the client has the necessary rank. If a client disconnects, the rescue block in the listen_to_client method closes the connection, removes the client from the list of connected clients, and adjusts the ranks. The `


require 'socket'

class Server
  attr_reader :server, :clients, :max_clients
  attr_accessor :ranks

  def initialize(port, max_clients)
    @server = TCPServer.new(port)
    @clients = []
    @ranks = {}
    @max_clients = max_clients
  end

  def start
    Thread.start do
      loop do
        client = server.accept
        handle_connection(client)
      end
    end
  end

  def handle_connection(client)
    rank = next_rank
    if rank.nil?
      client.puts "Server is full, try again later."
      client.close
      return
    end
    clients << client
    ranks[client] = rank
    client.puts "You have been assigned rank #{rank}."
    listen_to_client(client, rank)
  end

  def listen_to_client(client, rank)
    Thread.start do
      loop do
        message = client.gets.chomp
        parts = message.split
        command = parts[0].downcase
        case command
        when 'execute'
          target_rank = parts[1].to_i
          if target_rank > rank
            client.puts "You cannot execute command for rank #{target_rank}."
            next
          end
          target_client = client_by_rank(target_rank)
          if target_client
            target_client.puts "Rank #{rank} has executed your command."
          else
            client.puts "Rank #{target_rank} is not connected."
          end
        else
          client.puts "Unknown command: #{command}."
        end
      end
    rescue IOError, SystemCallError
      client.close
      clients.delete(client)
      ranks.delete(client)
      adjust_ranks
    end
  end

  def next_rank
    (0...max_clients).each do |rank|
      return rank if !ranks.value?(rank)
    end
    nil
  end

  def client_by_rank(rank)
    ranks.key(rank)
  end

  def adjust_ranks
    rank = 0
    ranks.keys.sort_by { |client| ranks[client] }.each do |client|
      ranks[client] = rank
      rank += 1
    end
  end
end

server = Server.new(3000, 5)
server.start
puts "Server is running on port 3000."

