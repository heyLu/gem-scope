# Adds 'scoping' to RubyGems by means of adjusting
# GEM_HOME and GEM_PATH to only detect the gems in
# the desired directories.
#
# @todo Accept things from standard paths, too?
class Gem::Scope
	attr_reader :base, :env

	# Use a new scope.
	#  @attr scope the scope to use
	def initialize scope="shine"
		@base = File.join ENV['HOME'], ".gems"
		@scope = scope

		Dir.mkdir @base unless File.exist? @base
		Dir.mkdir cur unless File.exist? cur

		rescope
	end

	# recalculate the scope
	def rescope
		ENV['GEM_HOME'] = ENV['GEM_PATH'] = cur
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

	# The path to the currently used scope directory.
	# @return The path in which all availlable gems are
	def cur
		File.join @base, @scope
	end
end
