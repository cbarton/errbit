require 'spec_helper'

describe RegistriesController do

	describe "POST /apps/:id/registry" do
		before do
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:new).and_return(@app)
			Registry.stub(:new).and_return(@registry)
		end

		context "when the create is successful" do 
			before do 
				@registry.should_receive(:save).and_return(true)
			end

			it "should display a message" do
				post :create, :data => "{\"foo\":\"bar\"}"
				request.should include("Success")
			end	
		end

	end

	describe "GET /apps/:id/registry" do
		before do 
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:find).with(@app.id).and_return(@app)
			Registry.stub(:find).with(@registry.id).and_return(@registry)
		end

		it "should return the registry as JSON" do
			get :show, :app_id => @app.id
			response.should include @registry.as_json
		end
	end

  describe "DELETE /apps/:id/registry" do
		before do
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:find).with(@app.id).and_return(@app)
			Registry.stub(:find).with(@registry.id).and_return(@registry)
		end

		it "should find the app and registry" do
			delete :destroy, :app_id => @app.id
			assigns(:registry).should == @registry
		end

		it "should destroy the registry" do
			@registry.should_receive(:destroy)
			delete :destroy, :app_id => @app.id
		end

  end

end
