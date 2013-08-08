require 'bundler/setup'
require 'Redcarpet'
require 'coderay'
require 'yaml'
require 'erb'
require 'ya2yaml'

def templateValues(headers, html)
	return binding()
end

class HTMLwithCoderay < Redcarpet::Render::HTML
  def block_code(code, language)
    language = (language==nil or language.size==0) ? "text" : language
    CodeRay.scan(code, language).div
  end
end

class PostFile
	attr_reader :headers

	def initialize(filepath)
		@filepath = filepath
		@markdown = ""
		separaters = 0
		@headers = Hash::new
		yaml_text = "";
		IO.foreach(filepath) do |line|
			if separaters >= 2 
				@markdown << line
			end
			if line.start_with?('---')	
				separaters += 1
			elsif separaters == 1
				yaml_text << line
			elsif separaters == 2
				parseHeaderLine(@headers, yaml_text)
			end
		end
		if @headers["category"]==nil
			@headers["category"]=@headers["categories"]
			@headers.delete("categories")
		end
		if @headers["category"]!=nil and @headers["category"].is_a?(String)
			@headers["category"]=@headers["category"].split(" ")
			@headers["category"].each {|s| s.strip!}
		end
	end

	def parseHeaderLine(items, line)
		item = YAML.load(line)
		items.merge!(item)
	end

	def write
		writeTo(@filepath)
	end
	
	def writeTo(filepath)
		$KCODE='utf8'
		open(filepath, "w"){|f|
			f.write @headers.ya2yaml
			f.write "---\n"
			f.write @markdown
		}
	end

	def generateHtml(text)
		coder = HTMLwithCoderay.new(:filter_html => false, :hard_wrap => true)
		renderer = Redcarpet::Markdown.new(coder, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true)
		renderer.render(text)
	end
	
	def generateEscapeHtmlFile(filepath)
		html = generateHtml(@markdown)
		template = ERB.new(File.read('posttemplate.erb'))
		open(filepath, "w"){|f|
			f.write template.result(templateValues(@headers, html))
		}
	end

	def generateHtmlFile(filepath)
		html = generateHtml(@markdown)
		open(filepath, "w"){|f|
			f.write html
		}
	end
end
