require 'spec_helper'

describe RegistriesController do

  def mock_registry(stubs={})
    (@mock_registry ||= mock_model(Registry).as_null_object).tap do |registry|
      registry.stub(stubs) unless stubs.empty?
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created registry as @registry" do
        Registry.stub(:new).with({'these' => 'params'}) { mock_registry(:save => true) }
        post :create, :registry => {'these' => 'params'}
        assigns(:registry).should be(mock_registry)
      end

      it "redirects to the created registry" do
        Registry.stub(:new) { mock_registry(:save => true) }
        post :create, :registry => {}
        response.should redirect_to(registry_url(mock_registry))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved registry as @registry" do
        Registry.stub(:new).with({'these' => 'params'}) { mock_registry(:save => false) }
        post :create, :registry => {'these' => 'params'}
        assigns(:registry).should be(mock_registry)
      end

      it "re-renders the 'new' template" do
        Registry.stub(:new) { mock_registry(:save => false) }
        post :create, :registry => {}
        response.should render_template("new")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested registry" do
      Registry.should_receive(:find).with("37") { mock_registry }
      mock_registry.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the registries list" do
      Registry.stub(:find) { mock_registry }
      delete :destroy, :id => "1"
      response.should redirect_to(registries_url)
    end
  end

end
