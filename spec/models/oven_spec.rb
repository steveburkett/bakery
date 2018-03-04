require 'rails_helper'

describe Oven do
  subject { Oven.new }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:cookies) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
  end

  context "cooking" do
    let(:oven) { create(:oven) }

    let(:cookie_params) do
      ActionController::Parameters.new(cookie: { filling: 'cheese' }).require(:cookie).permit(:fillings)
    end

    before do
      CookingJob.any_instance.stub(:cook) #simulate the oven device cooking
    end

    it "bakes some cookies" do
      oven.bake_some_cookies(2, cookie_params)
      expect(CookingJob.jobs.size).to eq 1
      CookingJob.drain
      expect(oven.finished_cooking?).to eq true
    end
  end
end
