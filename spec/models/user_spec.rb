require 'rails_helper'

RSpec.describe User, type: :model do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:meows).dependent(:destroy)}


    describe "#password" do
      it { should have_valid(:password).when("abcd1234"), "asd^2jk@%111"}
      it { should_not have_valid(:password).when("abcd123", nil, "")}
    end

    describe "#password_confirmation" do
      subject { FactoryGirl.build(:user, password: "abcd1234")}
      it { should have_valid(:password_confirmation).when("abcd1234")}
      it {should_not have_valid(:password_confirmation).when("asdas") }
    end

    describe "#email" do
      subject { FactoryGirl.create(:user) }
      it { should_not have_valid(:email).when("wasd", "kitty.com", "Ki@", nil, "")}
      it { should validate_uniqueness_of(:email) }
    end
end
