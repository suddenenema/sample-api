require 'rails_helper'

RSpec.describe  Api::V1::SampleController, type: :controller do

  context 'GET index' do

    before(:all) do
      @client = Client.create
    end

    it 'responds with 401 for empty params' do
      get :index
      expect(response).to have_http_status(401)
    end

    it 'responds with 401 for incorret params' do
      get :index, { some: 'params' }
      expect(response).to have_http_status(401)
    end

    it 'responds with 401 for non encrypted params' do
      get :index, { token: @client.token, data: 'somedata' }
      expect(response).to have_http_status(401)
    end

    it 'responds with 401 for encrypted params without sinature' do
      data   = { a: 1 }
      params = { token: @client.token, data: @client.encrypt_params(data) }

      get :index, params
      expect(response).to have_http_status(401)
    end


    it 'responds with 401 for encrypted params with wrong sinature' do
      data   = { sig: 'somebadsig' }
      params = { token: @client.token, data: @client.encrypt_params(data) }

      get :index, params
      expect(response).to have_http_status(401)
    end

    it 'responds with 200 for encrypted params with correct sinature' do
      query  = { a: 1, z: 2, b: 3 }
      sig    = { sig: Digest::MD5.hexdigest("a=1&b=3&z=2#{@client.private_key}") }
      data   = query.merge(sig)
      params = { token: @client.token, data: @client.encrypt_params(data) }

      get :index, params
      expect(response).to have_http_status(200)
    end

  end

end
