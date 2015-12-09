require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @micropost = Micropost.new(content: "New micropost", user_id: user.id) }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it "should have a user" do
    expect(subject.user).to eq user
  end

  it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
