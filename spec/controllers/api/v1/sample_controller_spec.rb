require 'rails_helper'

RSpec.describe  Api::V1::SampleController, type: :controller do

  it 'responds with 200 code' do
    get :index
    expect(response).to have_http_status(:ok)
  end

end
