require 'spec_helper'

describe Registry do
	
	context 'validations' do
		it 'requires valid JSON as data' do
			registry = Factory.build(:registry, :data => "{foo:bar}")
			registry.should_not be_valid
			registry.errors[:data].should include("must be valid JSON.")
		end
	end

	context 'being updated' do
		it 'should not retain the previous value' do

		end

		it 'should check valid JSON as data' do
			new_value = "{\"foo\": \"bar}"
			registry = Factory(:registry)
			registry.update_attribute(:data, new_value)
			registry.should_not be_valid
			registry.errors[:data].should include("must be valid JSON.")
		end
	end 
end
