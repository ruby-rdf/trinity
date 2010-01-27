require File.dirname(__FILE__) + '/spec_helper'

describe 'Content-type handling (using the hello dataset)' do

  include Rack::Test::Methods

  def app
    repository = RDF::Repository.load(fixture('hello.nt'))
    Trinity::Application.new(repository)
  end

  context "at the root" do

    before :all do
      get '/'
    end

    it "should be http 200 and application/xhtml+xml" do
      last_response.should be_ok_and_of_type 'application/xhtml+xml'
    end

  end

  context "/hello" do
    before :all do
      get '/hello'
    end

    it "should have a content type of application/xhtml+xml" do
      last_response.should be_ok_and_of_type 'application/xhtml+xml'
    end

  end

  context "/hello.txt" do

    before :all do
      get '/hello.txt'
    end

    it "should have a content-type of text/plain" do
      last_response.should be_ok_and_of_type 'text/plain'
    end

    it "should have 2 n-triple statements about hello" do
      last_response.should only_be_about "http://example.org:80/hello", 2
    end

  end

  context "/hello with an accept header of plain/text" do
    before :all do
      header 'Accept', 'text/plain'
      get '/hello'
    end
    it "should have a content-type of text/plain" do
      last_response.should be_ok_and_of_type 'text/plain'
    end
  end

  context "/hello with an accept header of text/html" do
    before :all do
      header 'Accept', 'text/html'
      get '/hello'
    end
    it "should have a content-type of text/html" do
      last_response.should be_ok_and_of_type 'text/html'
    end
  end

  context "/hello with an accept header of application/xhtml" do
    before :all do
      header 'Accept', 'application/xhtml'
      get '/hello'
    end
    it "should have a content-type of application/xhtml" do
      last_response.should be_ok_and_of_type 'application/xhtml'
    end
  end

  context "/hello with an accept header of application/xhtml+xml" do
    before :all do
      header 'Accept', 'application/xhtml+xml'
      get '/hello'
    end
    it "should have a content-type of application/xhtml+xml" do
      last_response.should be_ok_and_of_type 'application/xhtml+xml'
    end
  end


  context "a non-existent page" do
    before :all do
      get '/doesnt-exist'
    end

    it "should be a http 404" do
      last_response.status.should be 404
    end
  end

end

