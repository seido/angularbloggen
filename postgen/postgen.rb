require 'rubygems'
require 'Redcarpet'
require 'yaml'
require 'json'
require 'coderay'
require 'rssgen'
require 'postfile'
require 'fileutils'

postsDirPath="../_posts"
if ARGV.length > 0
	postsDirPath=ARGV[0]
end

destDirPath="../app/api"
if ARGV.length > 1
	destDirPath=ARGV[1]
end
$absoluteDestDir = File.expand_path(destDirPath)

$apiurl="/api/"
if ARGV.length > 2
	$apiurl=ARGV[2]
end
if !(/\/$/ =~ $apiurl)
	$apiurl<<'/'
end

escapehtmldir='../app/escaped-fragment/post'
if ARGV.length > 3
	escapehtmldir=ARGV[3]
end
$absoluteEscapeHtmlDir = File.expand_path(escapehtmldir)
FileUtils.mkdir_p($absoluteEscapeHtmlDir)

puts 'postsDirPath: ' + postsDirPath
puts 'destDirPath: ' + destDirPath
puts 'apiurl :' + $apiurl
puts 'absoluteEscapeHtmlDir :' + $absoluteEscapeHtmlDir

def convert(srcname, postid, postList)
	postfile = PostFile.new(srcname)

	if postfile.headers["date"]==nil
		#headers["date"]=File.mtime(srcname).strftime("%Y/%m/%d %H:%M:%S");
		postfile.headers["date"]=DateTime.parse(File.mtime(srcname).to_s).to_s
		postfile.write
	end
	htmlfile=postid+".html"

	postfile.generateHtmlFile(File.join($absoluteDestDir, htmlfile))
	postfile.generateEscapeHtmlFile(File.join($absoluteEscapeHtmlDir, htmlfile))

	headers = postfile.headers.clone;
	headers["postid"]=postid
	headers["url"]=$apiurl+htmlfile
	metafile=postid+".meta.json"
	headers["meta"]=$apiurl+metafile

	postList << headers

	metaJson = JSON.generate(headers)
	open(File.join($absoluteDestDir, metafile), "w"){|f| f.write metaJson}
end

def generateAllCategories(postList)
	result = Hash::new
	postList.each do |i|
		if i.has_key?('category') and i['category']!=nil
			i['category'].each do |c|
				if result.has_key?(c)
					result[c] += 1
				elsif
					result[c] = 1
				end
			end
		end
	end

	list = result.sort_by {|key, value| -value}
	list.map! do |i|
		{ 'name'=>i[0], 'count'=>i[1]}
	end
	
	categoriesJson = JSON.generate(list)
	open(File.join($absoluteDestDir, "categories.json"), "w"){|f| f.write categoriesJson}
end

postList = Array::new

Dir.glob(postsDirPath + "/*.markdown") do |f|
	destfile = File.basename(f, ".*")
	convert(f, destfile, postList)
end

#puts "postList: "+ Marshal.dump(postList)
postList.sort! {|a,b| (a["date"] <=> b["date"]) * -1}

postsJson = JSON.generate(postList)
open(File.join($absoluteDestDir, "posts.json"), "w"){|f| f.write postsJson}
generateAllCategories(postList)
FileUtils.mkdir_p(File.join($absoluteDestDir, "rss"))
generateRss(File.join($absoluteDestDir, "rss/posts.atom"), "http://seido.github.io", "seido.github.io all posts", postList, "seido")

