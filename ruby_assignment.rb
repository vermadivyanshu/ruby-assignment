class QueryMatching
	def initialize
		@pages, @queries, @n, @m = [],[],0,5
	end

	def getPagesForQuery
		readInput()
		getResult()
	end

	def readInput
		file = File.open("input.txt", "r")
		@n = file.readline.chomp.to_i
		while !file.eof?
			data = file.readline.chomp
			data_array = data.split(" ")
			@pages.push(data_array.drop(1).take(@n).map &:downcase) if data_array[0] == "P"
			@queries.push(data_array.drop(1).take(@n).map &:downcase) if data_array[0] == "Q"
		end
	end

	def printResult(pHash, index)
		print "Q#{index+1}: "
		if !pHash.empty?
			pHash.keys.take(@m).each do |num|
				print "P#{num+1} "
			end
		end
		print "\n"
	end

	def getPages(q, index)
		sum = 0
		pHash = {}
		@pages.each do |page|
			j = @pages.index(page)
			sum = 0
			q.each do |val|
				i = q.index(val)
				if page.index(val)
					sum += (@n - i)*(@n - (page.index(val)))
				end
			end
			pHash[j] = sum if sum!=0
		end
		pHash = (pHash.sort {|a,b| b[1]<=>a[1]}).to_h
		printResult(pHash, index)
		end

	def getResult
		@queries.each do |query|
			i = @queries.index(query)
			getPages(query, i)
		end
	end
end

QueryMatching.new.getPagesForQuery