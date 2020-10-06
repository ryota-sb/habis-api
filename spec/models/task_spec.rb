require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validates presence" do
    context "contentを指定している時" do
      let(:task) { create(:task) }
      it "レコードが作成される" do
        expect(task).to be_valid
      end
    end

    context "contentを指定していない時" do
      let(:task) { build(:task, content: nil) }
      it "エラーになる" do
        task.valid?
        expect(task.errors.messages[:task]).to include "can't be blank"
      end
    end
  end
end