#!/usr/bin/ruby
require 'pp'

##
# Apply patches from OBS in order they are listed in YAML project file

yaml = Dir['*.yaml']
if yaml.size == 1
	yaml = yaml.first
	puts "YAML file found: #{yaml}"
	
	state = :none
	IO.readlines(yaml).each do |line|
		case state
		when :patches
			if line =~ /\s+\-\s+(.+)/
				patch = $1
				puts "\t#{patch}"
				`git apply #{patch}`
			else
				break
			end
		else
			if line =~ /^Patches:/
				state = :patches
			end
		end
	end
	
else
	puts 'YAML file not found'
end
