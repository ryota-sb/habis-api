require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validates presence" do
    context "全カラムの値を指定している時" do
      let(:user) { create(:user) }
      it "userレコードが作成される" do
        expect(user).to be_valid
      end
    end
    context "emailを指定していない時" do
      let(:user) { build(:user, email: nil) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:email]).to include("can't be blank")
      end
    end
    context "passwordを指定していない時" do
      let(:user) { build(:user, password: nil) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include("can't be blank")
      end
    end
  end

  describe "validates uniqueness" do
    context "保存されたメールアドレスが指定されたとき"
    let(:user) { create(:user) }
    let(:other_user) { build(:user, email: user.email) }
    it "エラーになる" do
      other_user.valid?
      expect(other_user.errors.messages[:email]).to include("has already been taken")
    end
  end
end