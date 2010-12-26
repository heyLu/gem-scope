require 'buh'

describe "The funny Buh environment" do
	before do
		@buh = Buh.new
	end

	it "should allow #current= and change the environment" do
		@buh.current=("bleh").should.equal "bleh"
	end

	it "should execute Procs" do
		@buh.do(Proc.new { "blaah" }).should.equal "blaah"
	end

	it "should execute strings" do
		@buh.do("echo 'bleh'").chomp.should.equal "bleh"
	end

	it "should set GEM_HOME and GEM_PATH" do
		@buh.do(Proc.new { ENV['GEM_HOME'] }).should.equal @buh.current_path
	end
end
