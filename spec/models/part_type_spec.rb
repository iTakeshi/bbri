require 'spec_helper'

describe PartType do
  describe 'validation:' do

    before(:all) do
      PartType.create!(type_name: 'promoter')
    end

    before(:each) do
      @type = PartType.new(type_name: 'terminator')
    end

    context 'with valid information' do
      it 'should be valid' do
        @type.should be_valid
      end
    end

    context 'without :type_name' do
      it 'should not be valid' do
        @type.type_name = nil
        @type.should_not be_valid
      end
    end

    context ':type_name is not unique' do
      it 'should not be valid' do
        @type.type_name = 'promoter'
        @type.should_not be_valid
      end
    end

  end
end
