task :default => :test

desc "Create the gem. Ready for deploying"
task :gem do
	`gem build gem-scope.gemspec`
end

desc "Run the testsuite"
task :test do
	require 'bacon' # uh, could we name it better, pleas?

	Dir["spec/*.rb"].each do |f|
		puts `bacon -Ilib #{f}`
	end
end

desc "Clean all generated files"
task :clobber do
	require 'fileutils'
	FileUtils.rm_rf Dir["gem-scope-*.gem"]
end
