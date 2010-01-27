$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..','lib')))

require 'trinity'
require 'rack/test'

def fixture(filename) 
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end

# a response should be an ntriples representation of a resource, with no other resources, and
# an optional expected number of resources
Spec::Matchers.define :only_be_about do |subject, expected_count|
  match do |actual|
    count = 0
    subject = RDF::URI.new subject
    RDF::NTriples::Reader.new(actual.body.to_s).each do |statement|
      statement.subject.should == subject
      count += 1
    end
    count.should == expected_count if expected_count
  end
end

# check content type of a response
Spec::Matchers.define :be_of_type do |expected_type|
  match do |actual|
    actual.headers['Content-type'].should == expected_type
  end
end

Spec::Matchers.define :be_ok_and_of_type do |expected_type|
  match do |actual|
    actual.status.should be 200
    actual.should be_of_type expected_type
  end
end

Spec::Matchers.define :redirect_to do |expected_location|
  match do |response|
    response.headers['Location'].should == expected_location
  end
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
