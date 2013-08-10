require "rss"

def generateRss(path, baseurl, title, items, author)
	rss = RSS::Maker.make("atom") do |maker|
		maker.channel.author = author
		maker.channel.updated = items.max {|a,b| a["date"] <=> b["date"]}["date"]
		maker.channel.about = baseurl + path
		maker.channel.title = title

		items.each do |post|
			maker.items.new_item do |item|
				item.link = baseurl + "/#!/post/" + post["postid"] + "/"
				item.title = post["title"]
				item.updated = post["date"]
			end
		end
	end
	open(path, "w"){|f| f.write rss}
	puts path
	
end

