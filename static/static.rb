require 'webrick'

port = ARGV.first
current_dir = File.expand_path(File.dirname(__FILE__))

puts "Serving static directory #{current_dir} on port #{port}"

WEBrick::HTTPServer.new(Port: port, DocumentRoot: current_dir).start
