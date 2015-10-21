require 'socket'
require './ipconfig.rb'

# need to fill in basic info in ipconfig.rb
hostname = HOSTNAME
port = PORT

s = TCPSocket.open(hostname, port)
while line = s.gets
  # Read lines from the socket
  puts line.chop

  # send choice to start game
  (line.chop.eql? '3.Exit') && s.send("1\r\n", 0)
  # send speed setting
  (line.chop.eql? 'Choose the speed level(1-9):') && s.send("9\r\n", 0)

  # get the word!
  lines = line.chop.split('|')
  (lines.size.eql? 4) && s.send(lines[2] + "\r\n", 0)
end
s.close
