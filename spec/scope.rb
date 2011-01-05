require 'minitest/autorun'
require 'minitest/pride'

$:.unshift "lib"
require 'gem/scope'

describe Gem::Scope do
	before do
		@link = File.join(ENV['HOME'], ".gems/current")
		@oldpath = File.realpath @link
		@scope = Gem::Scope.new
		@scope.scope = "default"
	end

	it "exports the scope as an attribute" do
		refute_nil @scope.scope
		@scope.scope.must_equal "default"
	end

	it "should set GEM_HOME on #scope!" do
		@scope.scope!
		refute_nil ENV['GEM_HOME']
		ENV['GEM_HOME'].must_equal @scope.install
	end

	it "points 'current' to the current scope" do
		@scope.scope!
		File.realpath(@link).must_equal File.join(ENV['HOME'], ".gems/#{@scope.scope}")
	end

	# restore state
	after do
		FileUtils.rm_f @link
		FileUtils.ln_sf @oldpath, @link
	end
end
