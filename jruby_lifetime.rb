#!/usr/bin/ruby
require 'date'

created = {}
destroyed = {}

index = 0
ARGV.each do |file|
  puts "Processing #{file}"
  File.open(file) do |f|
    f.each_line do |line|
      if line =~ /^(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d),\d\d\d INFO .*? Creating JRubyInstance with id (\d+)/ then
        date = $1
        id = $2
        # If we find a create and there is already a destroy, then this is a duplication of the id.  Increase the index
        if destroyed.has_key?("#{id}.#{index}") then
            index += 1
        end
        created["#{id}.#{index}"] = date
      elsif line =~ /^(\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d),\d\d\d INFO .*? Cleaned up old JRubyInstance with id (\d+)/ then
        date = $1
        id = $2
        # If we find a destroyed, but there is no create, then this is an orphan at the start of the file.  Throw it out.
        if (!created.has_key?("#{id}.#{index}")) then
          next
        end
        destroyed["#{id}.#{index}"] = date
        destroyed[id] = date
      end
    end
  end
end

high = 0
low = 9999999999
total = 0
num = 0

destroyed.each do |k,v|
  next if !created.has_key?(k)
  delta = DateTime.parse(v) - DateTime.parse(created[k])
  dsec = (delta * 24 * 60 * 60).ceil
  if dsec > high then
    high = dsec
  end
  if dsec < low then
    low = dsec
  end
  total += dsec
  num += 1
  delta = DateTime.strptime(dsec.ceil.to_s, "%s").strftime("%H:%M:%S")
  puts "#{k} - Created at #{created[k]} and destroyed at #{v}, delta=#{delta}"
end

puts "Longest uptime: #{DateTime.strptime(high.to_s, "%s").strftime("%H:%M:%S")}  shortest uptime: #{DateTime.strptime(low.to_s, "%s").strftime("%H:%M:%S")}  average: #{DateTime.strptime((total/num).ceil.to_s,"%s").strftime("%H:%M:%S")}"
