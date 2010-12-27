require 'rubygems/command_manager'

# Adjust GEM_HOME and GEM_PATH to support scoping.
#
# @todo Accept things from standard paths, too?
class Scope
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

	# The path to the currently used scope directory.
	# @return The path in which all availlable gems are
	def cur
		File.join @base, @scope
	end
end

# Dead simple `gem scope` command support.
class ScopeCommand < Gem::Command
	def initialize
		super 'scope', "Scoping for RubyGems."
		@scope = Scope.new
	end

	def usage; "[SCOPE] - a scope to operate in" end

	def description
		<<-EOD
Scoping adds the ability to RubyGems to `scope` gems. That is,
only making Gems availlable in a controlled environment.
EOD
	end

	def execute
		args = options[:args]
		case args.first
		when ''
		when 'list'
			puts Dir["#{@scope.base}/*"]
		when /.*/
			puts $1
		end
	end
end

Scope.new # don't like this one
Gem::CommandManager.instance.register_command :scope
