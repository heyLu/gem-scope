Gem::Specification.new do |s|
	s.name = "gem-scope"
	s.version = "0.0.1"

	s.summary = "Add gem `scoping` to RubyGems"
	s.description = <<-EOD
`Scoping` is the ability to use gems only in special environments
(called scopes as there is already 'gem environment').
It is similar in spirit to [rip](https://github.com/defunkt/rip)
although designed to be a drop-in beauty.
Simple, less features, whatever. Enjoy if you like :)

It has *no* dependencies :) (other than rubygems, admittedly)
EOD

	s.authors = "Lucas Stadler"
	s.homepage = "https://github.com/anapple/gem-scope"

	s.license = "GPLv3+"

	s.files = %w(README) + Dir["lib/*.rb"] + Dir["lib/**/*.rb"]

	s.add_dependency "rubygems"
end
