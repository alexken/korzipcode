#!/usr/bin/env ruby

######################################################
puts <<XML_HEAD
<?xml version="1.0" encoding="UTF-8"?>
<d:dictionary 	xmlns="http://www.w3.org/1999/xhtml" 
				xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
XML_HEAD


class File
	def File.open_and_process(*args)
		f = File.open(*args)
		yield f
		f.close
	end
end

File.open_and_process(ARGV[0],'r') do |file|
	while line = file.gets
		line.gsub(/\s+/,' ').scan(/^(\S+)\s+(.*)\s+(\d+)\s+$/).each{ |zip,index,id|
			puts "<d:entry d:title='#{index}' id='#{id}' from=''>"
			index.split(' ').each{ |x|
				puts "\t<d:index d:value='#{x}'/>"
#				ruby 한글 매칭이 잘 동작하지 않아 포기
#				if x =~/(.*)[시군구읍면동리]$/ then   
#					puts "\t<d:index d:value='#{$1[]}'/>"
#				end
			}
			puts "<section><b>#{zip}</b> #{index}</section>"
			puts "</d:entry>"
		}
	end
end

puts <<XML_TAIL
</d:dictionary>
XML_TAIL