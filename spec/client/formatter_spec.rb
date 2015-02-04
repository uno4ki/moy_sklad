require 'spec_helper'

describe MoySklad::Client::Formatter do
  describe '#decode' do
    it 'should rise BadApiResponse when data is empty' do
      expect { subject.decode(nil) }.to raise_error(MoySklad::Error::BadApiResponse)
    end
  end
end
