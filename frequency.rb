#!/usr/bin/ruby

counts = {}
STDIN.each_line do |line|
  line.chomp!
  cmd = line.split(/;/)[1]
  counts[cmd] = counts[cmd] ? ( counts[cmd] + 1 ) : 1
end

counts.each do |key, value|
  puts "#{value} #{key}"
end
