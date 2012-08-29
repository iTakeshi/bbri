require 'spec_helper'

describe User do
  before(:all) do
    Team.create!(team_name: 'alberta')

    Team.select(:id).group_by{|team| team.id}.map{|k,v| k}
    user = Team.first.users.new(
      user_name: 'foo',
      user_email: 'bar@foo.bar',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
    user.generate_auth_token
    user.user_status = 1
    user.save!
  end

  describe 'relationship:' do
    it 'a user belongs to a team' do
      User.first.team.should be_instance_of Team
    end

    it 'a team has many users' do
      Team.first.users.first.should be_instance_of User
    end
  end

  describe 'validation:' do
    before(:each) do
      @user = Team.first.users.new(
        user_name: 'hoge',
        user_email: 'fuga@hoge.fuga',
        password: 'hogefuga',
        password_confirmation: 'hogefuga'
      )
      @user.generate_auth_token
      @user.user_status = 1
    end

    context 'with valid information' do
      it 'should be valid' do
        @user.should be_valid
      end
    end

    context 'without :team_id' do
      it 'should not be valid' do
        @user.team_id = nil
        @user.should_not be_valid
      end
    end

    context 'belongs to unexistent team' do
      it 'should not be valid' do
        @user.team_id = 1000000
        @user.should_not be_valid
      end
    end

    context 'without :user_name' do
      it 'should not be valid' do
        @user.user_name = nil
        @user.should_not be_valid
      end
    end

    context 'with too long or short :user_name' do
      it 'should not be valid' do
        @user.user_name = 'a'
        @user.should_not be_valid
        @user.user_name = 'abcdefghijklmnopqrstuvwxyz'
        @user.should_not be_valid
      end
    end

    context ':user_name is not unique' do
      it 'should not be valid' do
        @user.user_name = 'foo'
        @user.should_not be_valid
      end
    end

    context 'without :user_email' do
      it 'should not be valid' do
        @user.user_email = nil
        @user.should_not be_valid
      end
    end

    context ':user_email has invalid format' do
      it 'should not be valid' do
        @user.user_email = 'fuga@@hoge.fuga'
        @user.should_not be_valid
      end
    end

    context ':user_email is not unique' do
      it 'should not be valid' do
        @user.user_email = 'bar@foo.bar'
        @user.should_not be_valid
      end
    end

    context 'without :user_auth_token' do
      it 'should not be valid' do
        @user.user_auth_token = nil
        @user.should_not be_valid
      end
    end

    context ':user_auth_token is not unique' do
      it 'should not be valid' do
        @user.user_auth_token = User.first.user_auth_token
        @user.should_not be_valid
      end
    end

    context 'without :user_status' do
      it 'should not be valid' do
        @user.user_status = nil
        @user.should_not be_valid
      end
    end

    context ':user_status is out of [0, 1, 2]' do
      it 'should not be valid' do
        @user.user_status = 3
        @user.should_not be_valid
      end
    end

    context 'without :password on creating' do
      it 'should not be valid' do
        @user.password = nil
        @user.should_not be_valid
      end
    end

    context 'withoug :password on updateing' do
      it 'should be valid' do
        user = User.first
        user.password = nil
        user.should be_valid
      end
    end

    context ':password_confirmation doesnt match' do
      it 'should not be valid' do
        @user.password_confirmation = 'a'
        @user.should_not be_valid
      end
    end
  end
end
