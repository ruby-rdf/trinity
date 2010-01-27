require File.dirname(__FILE__) + '/spec_helper'

describe 'The Alias-Redirect dataset' do

  include Rack::Test::Methods

  def app
    repository = RDF::Repository.load(fixture('alias_redirect.nt'))
    Trinity::Application.new(repository)
  end

  context "at the root" do

    before :all do
      get '/'
    end

    it "should be http 200" do
      last_response.status.should == 200
    end

  end

  context "/hello" do
    before :all do
      get '/hello'
    end
    
    it "should be http 200" do
      last_response.status.should == 200
    end

  end

  context "/hello/alias" do

    before :all do
      get '/hello/alias'
    end

    it "should be http 200" do
      last_response.status.should == 200
    end
    
    it "should be the same as /hello" do
      alias_body = last_response.body
      get '/hello'
      last_response.body.should == alias_body
    end

  end

  context "/hello/redirect" do
    before :all do
      get '/hello/redirect'
    end

    it "should be http 301" do
      last_response.status.should == 301 
    end

    it "should redirect to /hello" do
      last_response.should redirect_to 'http://example.org:80/hello'
    end
  end

  context "/hello/two-redirects" do
    before :all do
      get '/hello/two-redirects'
    end

    it "should be http 301" do
      last_response.status.should == 301
    end

    it "should redirect to /hello" do
      last_response.should redirect_to 'http://example.org:80/hello'
    end
  end

  context "/hello/two-aliases" do
    before :all do
      get '/hello/two-aliases'
    end

    it "should be http 200" do
      last_response.status.should == 200
    end

    it "should be the same as /hello" do
      alias_body = last_response.body
      get '/hello'
      last_response.body.should == alias_body
    end
  end

  context "/hello/alias-loop" do
    before :all do
      get '/hello/alias-loop'
    end

    #FIXME: this is maybe not what we want?  should we merge results?
    it "should return http 500" do
      last_response.status.should == 500
    end
  end

  context "/hello/redirect-loop" do
    before :all do
      get '/hello/redirect-loop'
    end

    it "should return http 500" do
      last_response.status.should == 500
    end
  end

end

