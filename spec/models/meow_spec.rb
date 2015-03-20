require 'rails_helper'

describe Meow do
  before(:each) { FactoryGirl.create(:meow) }

  it { should belong_to :user }
  it { should belong_to :post }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:post).when(Post.new) }
  it { should_not have_valid(:post).when(nil) }

  it { should validate_uniqueness_of(:post_id).scoped_to(:user_id)
  }

  describe "#meow_from" do
    context "User has a Meow for given Post" do
      it "returns that instance of Meow" do
        meow = FactoryGirl.create(:meow)
        post = meow.post
        user = meow.user

        expect(post.meow_from(user)).to eq meow
      end
    end

    context "User doesn't have a Meow for given Post" do
      it "returns nil" do
        user = FactoryGirl.create(:user)
        post = FactoryGirl.create(:post)

        expect(post.meow_from(user)).to eq nil
      end
    end
  end
end
