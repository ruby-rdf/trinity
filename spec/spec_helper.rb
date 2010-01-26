$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..','lib')))

require 'trinity'
require 'rack/test'

def fixture(filename) 
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end

describe 'The helpers' do

  context 'the fixture helper' do
    it "should create a filename based on a fixture name" do
      fixture('hello.nt').should include 'fixtures/hello.nt'
    end

    it "should find the file for a known fixture" do
      File.exists?(fixture 'hello.nt').should == true
    end
  end

end
