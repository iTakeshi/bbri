require 'spec_helper'

describe Part do

  before(:all) do
    Team.create!(team_name: 'unknown')
    PartType.create!(type_name: 'cds')

    Part.create!(
      team_id: 1,
      part_type_id: 1,
      part_year: 2004,
      part_identifier: 'BBa_R0040'
    )
  end

  before(:each) do
    @part = Part.new(
      team_id: 1,
      part_type_id: 1,
      part_year: 2004,
      part_identifier: 'BBa_I0500'
    )
  end

  describe 'relationship:' do
    it 'a team has many parts' do
      Team.all.first.parts.first.part_identifier.should eql 'BBa_R0040'
    end

    it 'a part_type has many parts' do
      PartType.all.first.parts.first.part_identifier.should eql 'BBa_R0040'
    end

    it 'a part belongs to a team' do
      @part.team.should be_instance_of Team
    end

    it 'a part belongs to a part_type' do
      @part.part_type.should be_instance_of PartType
    end
  end

  describe 'validation:' do
    context 'with valid information' do
      it 'should be valid' do
        @part.should be_valid
      end
    end

    context 'without :team_id' do
      it 'should not be valid' do
        @part.team_id = nil
        @part.should_not be_valid
      end
    end

    context 'without :part_type_id' do
      it 'should not be valid' do
        @part.part_type_id = nil
        @part.should_not be_valid
      end
    end

    context 'without :part_year' do
      it 'should not be valid' do
        @part.part_year = nil
        @part.should_not be_valid
      end
    end

    context 'without :part_identifier' do
      it 'should not be valid' do
        @part.part_identifier = nil
        @part.should_not be_valid
      end
    end

    context ':part_identifier is not unique' do
      it 'should not be valid' do
        @part.part_identifier = 'BBa_R0040'
        @part.should_not be_valid
      end
    end

    context ':part_identifier has invalid format' do
      it 'should not be valid' do
        @part.part_identifier = 'BBA_i0500'
        @part.should_not be_valid
      end
    end
  end

end
