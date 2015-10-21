require 'socket'      # Sockets are in standard library

hostname = '140.113.194.85'
port = 49_169

s = TCPSocket.open(hostname, port)
while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
  if line.chop.eql? "3.Exit"
    puts "\n-----socket msg: entrance show done-----\n\n"
    break
  end
end

s.send("1\r\n", 0)    # send choice to start game

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
  if line.chop.eql? 'Choose the speed level(1-9):'
    puts "\n-----socket msg: speed option show done-----\n\n"
    break
  end
end

s.send("9\r\n", 0)    # send choice to start game

puts "\n-----socket msg: start game-----\n\n"

while line = s.gets   # Read lines from the socket
  if line[0].eql? "S"
    puts line.chop
    next
  end

  lines = line.chop.split('|')
  unless lines.size.eql? 4
    next
  end
  puts line.chop
  puts lines[2]
  s.send(lines[2] + "\r\n", 0)
end

s.close               # Close the socket when done
