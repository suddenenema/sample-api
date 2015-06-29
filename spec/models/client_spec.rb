require 'rails_helper'

RSpec.describe Client, type: :model do

  context 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }

    it { is_expected.to validate_presence_of(:private_key) }
    it { is_expected.to validate_uniqueness_of(:private_key) }
  end

  context 'callbacks' do

    describe '#generate_keys' do

      it 'set keys after initialize' do
        client = Client.new
        expect(client.token).to_not be_nil
        expect(client.private_key).to_not be_nil
      end

    end

  end

end
