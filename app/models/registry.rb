class Registry
  include Mongoid::Document
	
	field :value, :type => String

	referenced_in :app

	validate :check_json_validity
	
	def check_json_validity
		begin
			self.value = YAML.load(self.value.gsub(/,[ ]*/, "\n")).to_json
		rescue Exception => e
			errors.add(:json, "Registry must be valid JSON") 
		end
	end

	def to_json
		JSON.parse(value)
	end
end
