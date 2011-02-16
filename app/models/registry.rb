class Registry
  include Mongoid::Document
	
	field :data

	embedded_in :app, :inverse_of => :registry

	validate :check_json
	
	def check_json
		begin
			if self.data.is_a?(String)	
				self.data = JSON.parse(self.data.gsub(/=>/, ':'))
			else
				JSON.unparse(self.data)
			end
		rescue Exception 
			errors.add(:data, "must be valid JSON.") 
		end
	end

	def as_json(options={}) 
		data
	end

	def to_s
		data
	end
end
