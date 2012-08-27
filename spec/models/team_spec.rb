require 'spec_helper'

describe Team do
  describe 'validation:' do

    before(:all) do
      Team.create!(team_name: 'MIT')
    end

    before(:each) do
      @team = Team.new(team_name: 'HokkaidoU_Japan')
    end

    context 'with valid information' do
      it 'should be valid' do
        @team.should be_valid
      end
    end

    context 'without :team_name' do
      it 'should not be valid' do
        @team.team_name = nil
        @team.should_not be_valid
      end
    end

    context ':team_name is not unique' do
      it 'should not be valid' do
        @team.team_name = 'MIT'
        @team.should_not be_valid
      end
    end

  end
end
