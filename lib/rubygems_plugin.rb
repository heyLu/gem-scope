require 'rubygems/command_manager'

class Scope
	attr_reader :base, :env

	def initialize env="shine"
		@base = File.join ENV['HOME'], ".gems"
		@env = "shine"

		Dir.mkdir @base unless File.exist? @base
		Dir.mkdir cur unless File.exist? cur

		rescope
	end

	# recalculate the scope
	def rescope
		ENV['GEM_HOME'] = ENV['GEM_PATH'] = cur
		Gem::clear_paths
	end

	# @returns the path to the current environment
	def cur
		File.join @base, @env
	end
end

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
