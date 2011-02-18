class Registry
  include Mongoid::Document
	
	field :data

	embedded_in :app, :inverse_of => :registry

	validate :check_json, :if => Proc.new { data.present? }
	
	def check_json
		begin
			if self.data.is_a?(String)	
				self.data = ActiveSupport::JSON.decode(self.data.gsub(/=>/, ':'))
			else
				ActiveSupport::JSON.encode(self.data)
			end
		rescue StandardError
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
