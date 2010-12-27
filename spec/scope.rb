require 'gem/scope'

include Gem

describe "The funny Scope" do
	before do
		@scope = Scope.new
	end

	it "should set GEM_HOME" do
		ENV['GEM_HOME'].should.not.be.empty
	end

	it "should use all Gems by default (as rubygems plugin)" do
		require_relative '../lib/rubygems_plugin.rb'
		ENV['GEM_PATH'].should.match /#{Regexp.escape Gem::default_path.join ':'}/
	end

	it "should set GEM_PATH to GEM_HOME otherwise" do
		ENV['GEM_PATH'].should.equal ENV['GEM_HOME']
	end

	it "should support specifying a scope on creation" do
		Scope.new("non-default").scope.should.equal "non-default"
	end

	it "should not find gems in empty scopes" do
		s = Scope.new "potentially-empty-scope"
		s.do { `gem list` }.should.equal "\n"
	end
end
