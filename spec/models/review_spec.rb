require 'spec_helper'

describe Review do

  before(:all) do
    Part.create!(
      team_id: 1,
      part_year: 2004,
      part_type_id: 1,
      part_identifier: 'BBa_R0010'
    )

    User.create!({
      team_id: 1,
      user_name: 'Lasseter',
      user_email: 'lasseter.pixar@hoge.fuga',
      user_auth_token: SecureRandom.urlsafe_base64(20),
      user_status: 0,
      password: 'hoge',
      password_confirmation: 'hoge'
    }, without_protection: true
    )

    Review.create!(
      part_id: 1,
      user_id: 1,
      review_title: 'This is awesome!',
      review_text: 'Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.'
    )
  end

  before(:each) do
    @review = Review.new(
      part_id: 1,
      user_id: 1,
      review_title: 'This is fantastic!',
      review_text: 'Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.'
    )
  end

  describe 'relationship:' do
    it 'a part has many reviews' do
      Part.all.first.reviews.first.review_title.should eql 'This is awesome!'
    end

    it 'a user has many reviews' do
      User.all.first.reviews.first.review_title.should eql 'This is awesome!'
    end

    it 'a review belongs to a part' do
      @review.part.should be_instance_of Part
    end

    it 'a review belongs to a user' do
      @review.user.should be_instance_of User
    end
  end

  describe 'validation:' do
    context 'with valid information' do
      it 'should be valid' do
        @review.should be_valid
      end
    end

    context 'without :part_id' do
      it 'should not be valid' do
        @review.part_id = nil
        @review.should_not be_valid
      end
    end

    context 'without :user_id' do
      it 'should not be valid' do
        @review.user_id = nil
        @review.should_not be_valid
      end
    end

    context 'without :review_title' do
      it 'should not be valid' do
        @review.review_title = nil
        @review.should_not be_valid
      end
    end

    context 'without :review_text' do
      it 'should not be valid' do
        @review.review_text = nil
        @review.should_not be_valid
      end
    end
  end


end
