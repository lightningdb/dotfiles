#!/usr/bin/ruby
# Can be used to do a frequency count for used commands
# usage:
# cat ~/.zsh_history | ./frequency.rb | sort -rn | head

counts = {}
STDIN.each_line do |line|
  line.chomp!
  cmd = line.split(/;/)[1]
  counts[cmd] = counts[cmd] ? ( counts[cmd] + 1 ) : 1
end

counts.each do |key, value|
  puts "#{value} #{key}"
end
