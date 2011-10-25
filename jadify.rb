#!/usr/bin/env ruby
#
# = Jadify:: Parse HTML documents and insert Haml or Jade templates

require 'rubygems'
require 'hpricot'

f = ARGV[0]

if FileTest.exist?(f)
	html_raw = File.read(f)
	line_split = html_raw.split("\n")
	output_lines = line_split.dup
	
	line_split.each do |line|
		curr_line = line_split.index(line)

		if line =~ /<!--/
			m = line.match /\<!--\ ?\@(\w+)\ (.+)\ ?--\>/

			if m.length == 3
				processor = m[1].trim
				file = m[2].trim

				if FileTest.exist?(file)
					tmpl = File.read(file)

					%x{which #{processor}}

					if $?.existatus == 0
						output = `#{processor} #{file}`

						output_lines.insert(curr_line, output)
					else
						puts "Cannot find processor #{processor} in your $PATH"
						exit 2
					end
				else
					puts "Cannot find file #{file}.#{processor}"
					exit 1
				end
			end
		end
	end
end
