require 'rubygems/defaults'
require 'fileutils'

# Adds 'scoping' to RubyGems by means of adjusting
# GEM_HOME and GEM_PATH to only detect the gems in
# the desired directories.
#
# @note `GEM_HOME` is the default install directory,
#   whereas `GEM_PATH` is searched for gems.
# @todo Accept things from standard paths, too?
class Gem::Scope
	attr_reader :base, :searched
	attr_accessor :scope

	# Use a new scope.
	#
	# @param scope
	#   The scope to use.
	# @note If there is a `current` symlink in the {#base}
	#   path, that one will be used instead of {#scope}.
	#   So that parameter might go away soonish.
	def initialize scope="shine", searched=[]
		@base = File.join ENV['HOME'], ".gems"
		@scope = if File.exist? File.join(@base,"current")
			File.basename File.realpath(cur_link)
		else
			scope
		end
		@searched ||= searched

		Dir.mkdir @base unless File.exist? @base
		Dir.mkdir install unless File.exist? install
		FileUtils.ln_sf install+'/', cur_link unless File.exist? cur_link

		scope!
	end

	# Reinitialize the scope
	def scope! another=@scope
		return if @scope == "all" && another == "all"

		@scope = another
		ENV['GEM_HOME'] = install
		ENV['GEM_PATH'] = if @searched.empty?
			install
		else
			[@searched,install].flatten.join ':'
		end
		Gem::clear_paths

		return if fine?
		puts "Changing scope to #{another}" #if $DEBUG

		FileUtils.rm_f cur_link # required?
		FileUtils.ln_sf install+'/', cur_link
	end

	# create a new scope
	def create s
		Dir::mkdir File.join @base, s
		@scope = s
	end

	# @return A list of the scopes that exist currently.
	def scopes
		Dir["#{@base}/*"].map{ |s|
			File.basename s unless File.basename(s)=="current"
		}.compact
	end

	# Execute a {Proc#call} in the context of this scope. Not really
	# for the big things. Just for scripts and all that.
	#
	# @param block What you want to do.
	def do &block
		scope!
		if block_given?
			block.call
		else
			`#{block}` # uh-oh
		end
	end

	# The path to which Gems are installed currently. This is
	# where most Gems should be.
	# If you want to use more than one scope, use {#add} and
	# `GEM_PATH` respectively.
	#
	# @return The path in which all availlable gems are
	def install
		File.join @base, @scope
	end

	# Add an additional scope to the search path (`GEM_PATH`).
	def add scope
		@searched += scope
		scope!
	end
	alias :+ :add

 private

	def cur_link; File.join @base, "current" end

	def fine?
		if @scope==File.basename(File.realpath cur_link )
			true
		else
			false
		end
	end
end
