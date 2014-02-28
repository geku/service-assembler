require 'webrick'

port = 3000

WEBrick::HTTPServer.new(Port: port, DocumentRoot: Dir.pwd).start
