class RegistriesController < ApplicationController
	
	before_filter :find_app
	skip_before_filter :authenticate_user!, :except => :destroy 

	def show
		@registry = @app.registry
		
		render :json => @registry
	end

  def create	
		@registry = @app.registry || @app.build_registry
		if @registry.update_attributes(:data => params[:data]) 
			render :json => { :success => true, :message => "Created Registry for #{@app.name}", :registry => @registry }
		else
			render :json => { :message => "Failed to create registry", :errors => @registry.errors }
     end
  end

  def destroy
		@registry = @app.registry
    @registry.destroy

		respond_to do |format|
			format.js   
			format.html { head 406} 
		end
  end
  
	protected
  
    def find_app
      @app = App.find(params[:app_id])

			# No need to check user authentication for registry posts, maybe a future /TODO/
    end
end
