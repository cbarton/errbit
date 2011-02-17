require 'spec_helper'
require 'ruby-debug'

describe RegistriesController do

	describe "POST /apps/:id/registry" do
		before do
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:new).and_return(@app)
			Registry.stub(:new).and_return(@registry)
		end

		context "when the create is successful" do 
			it "should display success message" do
				post :create, :data => {"foo"=>"bar"}, :app_id => @app.id
				@registry = @app.reload.registry
				JSON.parse(response.body).should == {"success" => true, "message" => "Created Registry for #{@app.name}", "registry" => @registry.as_json} 
			end	
		end

		context "when the create is unsuccessful" do
			it "should display error message" do
				post :create, :data => false, :app_id => @app.id
				JSON.parse(response.body).should == {"message" => "Failed to create registry", "errors" => {"data" => "must be valid JSON."} } 
			end
		end

	end

	describe "GET /apps/:id/registry" do
		before do 
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:find).with(@app.id).and_return(@app)
		end

		it "should return the registry as JSON" do
			get :show, :app_id => @app.id
			JSON.parse(response.body).should == @registry.as_json
		end
	end

  describe "DELETE /apps/:id/registry" do
		before do
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:find).with(@app.id).and_return(@app)
		end

		it "should destroy the registry" do
			delete :destroy, :app_id => @app.id
			@app.reload.registry.should be_nil
		end

  end

end
