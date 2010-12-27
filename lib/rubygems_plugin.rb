require 'rubygems/command_manager'
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

Gem::Scope.new "shine", Gem::default_path # don't like this one
Gem::CommandManager.instance.register_command :scope
