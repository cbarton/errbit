Factory.define(:registry) do |r|
	r.app		{|r| r.association :app}
	r.data "{\"staging-locked\":true}"
end
