require 'rails_helper'

describe 'TaskAPI' do
  it 'get all the tasks' do
    user = FactoryBot.create(:user)
    FactoryBot.create_list(:task, 10, user: user)
    get '/api/v1/tasks'
    json = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(json['data'].length).to eq(10)
  end 
end
