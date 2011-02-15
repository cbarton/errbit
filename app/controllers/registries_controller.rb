class RegistriesController < ApplicationController
	
	before_filter :find_app

  def create
    @registry = Registry.new(params[:registry])

    respond_to do |format|
      if @registry.save
        format.html { redirect_to(@registry, :notice => 'Registry was successfully created.') }
        format.xml  { render :xml => @registry, :status => :created, :location => @registry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registries/1
  # DELETE /registries/1.xml
  def destroy
    @registry = Registry.find(params[:id])
    @registry.destroy

    respond_to do |format|
      format.html { redirect_to(registries_url) }
      format.xml  { head :ok }
    end
  end
  
	protected
  
    def find_app
      @app = App.find(params[:id])

			# No need to check user authentication for registry posts, maybe a future /TODO/
    end
end
