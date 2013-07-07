require 'rubygems'
require 'Redcarpet'
require 'yaml'
require 'json'
require 'coderay'

dirpath="_posts"
if ARGV.length > 0
	dirpath=ARGV[0]
end

destdirpath="app/api"
if ARGV.length > 1
	destdirpath=ARGV[1]
end
$absoluteDestDir = File.expand_path(destdirpath)

$apiurl="api/"
if ARGV.length > 2
	$apiurl=ARGV[2]
end
if !(/\/$/ =~ $apiurl)
	$apiurl<<'/'
end

def parseHeaderLine(items, line)
	item = YAML.load(line)
	items.merge!(item)
end

class HTMLwithCoderay < Redcarpet::Render::HTML
  def block_code(code, language)
    language = (language==nil or language.size==0) ? "text" : language
    CodeRay.scan(code, language).div
  end
end

def generateMarkdown(text)
	coder = HTMLwithCoderay.new(:filter_html => false, :hard_wrap => true)
	renderer = Redcarpet::Markdown.new(coder, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true)
	renderer.render(text)
end

def convert(srcname, postid, postList)
	markdown = ""
	separaters = 0
	headers = Hash::new
	IO.foreach(srcname) do |line|
		if separaters >= 2 
			markdown << line
		end
		if line.start_with?('---')	
			separaters += 1
		elsif separaters == 1
			parseHeaderLine(headers, line)
		end
	end

	if headers["date"]==nil
		headers["date"]=File.mtime(srcname).strftime("%Y/%m/%d %H:%M:%S");
	end
	if headers["category"]==nil
		headers["category"]=headers["categories"]
		headers.delete("categories")
	end
	if headers["category"]!=nil and headers["category"].is_a?(String)
		headers["category"]=headers["category"].split(" ")
		headers["category"].each {|s| s.strip!}
	end

	headers["postid"]=postid
	htmlfile=postid+".html"
	headers["url"]=$apiurl+htmlfile
	metafile=postid+".meta.json"
	headers["meta"]=$apiurl+metafile

	postList << headers

	html = generateMarkdown(markdown)
	open(File.join($absoluteDestDir, htmlfile), "w"){|f| f.write html}

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

Dir.chdir(dirpath)
Dir.glob("*.markdown") do |f|
	destfile = File.basename(f, ".*")
	convert(f, destfile, postList)
end

postList.sort! {|a,b| (a["date"] <=> b["date"]) * -1}

postsJson = JSON.generate(postList)
open(File.join($absoluteDestDir, "posts.json"), "w"){|f| f.write postsJson}
generateAllCategories(postList)

