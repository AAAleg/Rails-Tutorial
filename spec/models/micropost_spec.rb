require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @micropost = Micropost.new(content: "New micropost", user_id: user.id)
  end

  subject { @micropost }

  it { should respond_to(:contentr) }
  it { should respond_to(:user_id) }
end
