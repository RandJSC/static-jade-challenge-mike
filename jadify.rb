#!/usr/bin/env ruby
#
# = Jadify:: Down and dirty Jade template includes

f = ARGV[0]
if FileTest.exist?(f)
	html_raw     = File.read(f)
	line_split   = html_raw.split("\n")
	output_lines = line_split.dup
	
	line_split.each do |line|
		# pre-match for a comment
		next unless line =~ /<!--/

		curr_line = line_split.index(line)

		# See if comment is an include
		m = line.match /\<!--\ ?\@(\w+)\ (.+)\ ?--\>/

		# Skip if we didn't correctly match processor and filename
		next unless m.length > 2

		processor = m[1].strip
		file      = m[2].strip
		fname     = File.join(File.dirname(f), "#{file}.#{processor}")

		if FileTest.exist?(fname)
			tmpl = File.read(fname)

			%x{which #{processor}}
			if $?.exitstatus == 0
				output = ""
				IO.popen(processor, 'r+') do |pipe|
					pipe.puts tmpl
					pipe.close_write

					while l = pipe.gets
						output << l
					end
				end

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

	puts output_lines.join("\n")
end

# vim: set ts=2 :
