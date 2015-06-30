require 'rails_helper'

RSpec.describe Client, type: :model do

  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }

    it { is_expected.to validate_presence_of(:private_key) }
    it { is_expected.to validate_uniqueness_of(:private_key) }

    it { is_expected.to validate_presence_of(:secret_key) }
    it { is_expected.to validate_uniqueness_of(:secret_key) }
  end

  context 'instance methods' do

    let(:client) { Client.new }

    describe '#sig_correct?' do

      it 'compares received and gage sig' do
        data   = { sig: '123123', some_key: 'some_value' }
        params = { data: client.encrypt_params(data) }

        expect(client).to receive(:gage_sig).with({ some_key: 'some_value' })
        client.sig_correct?(params)
      end

    end

    describe '#generate_keys' do

      it 'sets keys after initialize' do
        expect(client.token).to_not be_nil
        expect(client.private_key).to_not be_nil
        expect(client.private_key).to_not be_nil
      end

    end

    describe '#gage_sig' do

      it 'calculates md5 on sorted hash and private key' do
        params = { z: 123, a: 'bsc', A: '0' }
        expected_sig = Digest::MD5.hexdigest("A=0&a=bsc&z=123#{client.private_key}")

        expect(client.send(:gage_sig, params)).to be_eql(expected_sig)
      end

      it 'correctly works with empty params' do
        params = {}
        expect{ client.send(:gage_sig, params) }.to_not raise_error
      end

    end


  end

end
