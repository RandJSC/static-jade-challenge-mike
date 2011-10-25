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
				processor = m[1].strip
				file = m[2].strip
				fname = File.join(File.dirname(f), "#{file}.#{processor}")

				if FileTest.exist?(fname)
					tmpl = File.read(fname)

					%x{which #{processor}}

					if $?.exitstatus == 0
						output = `cat #{fname} | #{processor}`

						output_lines.insert(curr_line + 1, output)
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

	puts output_lines.join("\n")
end
