require 'rubygems/command_manager'
require 'rubygems/defaults'
require 'gem/scope'

# Dead simple `gem scope` command.
# See the {README} for usage.
class ScopeCommand < Gem::Command
	def initialize
		super 'scope', "Scoping for RubyGems."
		@scope = Gem::Scope.new
	end

	def usage; "[SCOPE] - a scope to operate in" end

	def description
		<<-EOD
Scoping adds the ability to RubyGems to `scope` gems. That is,
only making Gems availlable in a controlled environment.

list - List all scopes ('*' is current). Think `git branch`.
EOD
	end

	def execute
		args = options[:args]
		case args.first
		when 'list'
			scopes
		when /(.+)/
			change_or_create $1
		else
			scopes
		end
	end

	def scopes
		puts @scope.scopes.map { |s| s==@scope.scope ? " * #{s}" : "   #{s}" }
	end

	def change_or_create s
		@scope.create s if not @scope.scopes.include? s
		@scope.scope! s
	end
end

Gem::Scope.new # don't like this one
Gem::CommandManager.instance.register_command :scope
