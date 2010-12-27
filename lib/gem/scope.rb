require 'rubygems/defaults'

# Adds 'scoping' to RubyGems by means of adjusting
# GEM_HOME and GEM_PATH to only detect the gems in
# the desired directories.
#
# @note `GEM_HOME` is the default install directory,
#   whereas `GEM_PATH` is searched for gems.
# @todo Accept things from standard paths, too?
class Gem::Scope
	attr_reader :base, :scope, :searched

	# Use a new scope.
	#  @attr scope the scope to use
	def initialize scope="shine", searched=[]
		@base = File.join ENV['HOME'], ".gems"
		@scope = scope
		@searched ||= searched

		Dir.mkdir @base unless File.exist? @base
		Dir.mkdir install unless File.exist? install

		rescope
	end

	# recalculate the scope
	def rescope
		ENV['GEM_HOME'] = install
		ENV['GEM_PATH'] = if @searched.empty?
			install
		else
			[@searched,install].flatten.join ':'
		end
		Gem::clear_paths
	end

	def do &block
		rescope
		if block_given?
			block.call
		else
			`#{block}`
		end
	end

	# The path to which Gems are installed currently. This is
	# where most Gems should be.
	# If you want to use more than one scope, use {#add} and
	# `GEM_PATH` respectively.
	# @return The path in which all availlable gems are
	def install
		File.join @base, @scope
	end

	# Add an additional scope to the search path (`GEM_PATH`).
	def add scope
		@searched += scope
		rescope
	end
	alias :+ :add
end
