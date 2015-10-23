require 'socket'
require './ipconfig.rb'

# need to fill in basic info in ipconfig.rb
hostname = HOSTNAME
port = PORT

count = 0
played = 0
s = TCPSocket.open(hostname, port)
while line = s.gets
  # Read lines from the socket
  print line

  # send choice to start game
  # played not equal 0 means we have played once
  (line.chop.eql? '3.Exit') && (played == 0) && s.send("1\r\n", 0)
  # send speed setting
  (line.chop.eql? 'Choose the speed level(1-9):') && s.send("9\r\n", 0)

  # more than 3000 up
  if count >= 32
    played = 1 # just played once
    next
  end

  # get the word!
  lines = line.chop.split('|')
  if lines.size.eql? 4
    s.send(lines[2] + "\r\n", 0)
    count += 1
  end

end
s.close
