require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do
  describe "GET /api/v1/tasks" do
    subject { get(api_v1_tasks_path) }
    before { create_list(:task, 3) }

    it "Task一覧を取得する" do
      subject
      res = JSON.parse(response.content)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "content", "is_done"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/tasks" do
    subject { post(api_v1_tasks_path, params: params) }
    let(:params) { { task: attributes_for(:task) } }

    it "レコードが作成される" do
      expect { subject }.to change { Task.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/tasks/:id" do
    subject { patch(api_v1_tasks_path(task.id), params: params) }
    let(:task) { create(:task) }
    let(:params) { { task: { is_done: true, created_at: Time.current } } }
    
    it "指定したレコードが更新される" do
      expect { subject }.to change { Task.find(task.id).is_done }.from(task.is_done).to(params[:task][:is_done])
      expect { subject }.not_to change { Task.find(task.id).content }
      expect { subject }.not_to change { Task.fing(task.id).created_at }
      expect(response).to have_http_status(204)
    end
  end

  describe "DELETE /api/v1/tasks/:id" do
    subject { delete(api_v1_tasks_path(task.id)) }
    let!(:task) { create(:task) }

    it "指定したレコードが削除される" do
      expect { subject }.to change { Task.count }.by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
