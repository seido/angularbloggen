require 'test/unit'
require 'postfile'
require "tempfile"

class PostFileTest < Test::Unit::TestCase
	def setup
		@obj = PostFile.new('test.markdown')
	end

	def test_category
		assert_not_nil(@obj)
		assert_equal(['test', 'test2'], @obj.headers['category'])

		obj2 = PostFile.new('test2.markdown')
		assert_not_nil(obj2)
		assert_equal(['test', 'test2'], obj2.headers['category'])

		obj3 = PostFile.new('test3.markdown')
		assert_not_nil(obj3)
		assert_equal(['test', 'test2'], obj3.headers['category'])
	end

	def test_write
		file = Tempfile.new('foo')
		path = File.expand_path(file.path)
		file.close(true)
		path="writeresult.txt"
		@obj.writeTo path
		assert File.exists? path
		assert FileUtils.compare_file(path, 'testpostresult.txt')
		File.delete path
	end

	def test_generateHtmlFile
		file = Tempfile.new('foo')
		path = File.expand_path(file.path)
		file.close(true)
		path = 'result.txt'

		obj2 = PostFile.new('test2.markdown')
		obj2.generateHtmlFile path
		assert FileUtils.compare_file(path, 'testmarkdown.html')
	end

	def test_title
		obj2 = PostFile.new('test2.markdown')
		assert_equal("日本語", obj2.headers['title'])
	end

end
