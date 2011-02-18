require 'spec_helper'

describe RegistriesController do

  it_requires_authentication :for => {
    :destroy => :delete
  },
  :params => {:app_id => 'dummyid', :id => 'dummyid'}

	describe "POST /apps/:id/registry" do
		before do
			@app = Factory(:app)
		end

		context "when the create is successful" do 
			it "should display success message" do
				post :create, :data => {"foo"=>"bar"}, :app_id => @app.id
				@registry = @app.reload.registry
				ActiveSupport::JSON.decode(response.body).should == {"success" => true, "message" => "Created Registry for #{@app.name}", "registry" => @registry.as_json} 
			end	
		end

		context "when the create is unsuccessful" do
			it "should display error message" do
				post :create, :data => "{not {{: }valid json}", :app_id => @app.id
				ActiveSupport::JSON.decode(response.body).should == {"message" => "Failed to create registry", "errors" => {"data" => "must be valid JSON."} } 
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
			ActiveSupport::JSON.decode(response.body).should == @registry.as_json
		end
	end

  describe "DELETE /apps/:id/registry" do
		before do
			@app = Factory(:app)
			@registry = Factory(:registry, :app => @app)
			App.stub(:find).with(@app.id).and_return(@app)
			sign_in Factory(:user)
		end

		it "should destroy the registry" do
			delete :destroy, :app_id => @app.id
			@app.reload.registry.should be_nil
		end

  end

end
