require_relative "kml_parser"

describe Parser do
  let(:parser){ Parser.new }
  context 'parse' do
    it 'returns a hash' do
      expect(parser.parse('sample.kml')).to be_an_instance_of Hash
    end
    it 'returns a hash with one key' do
      expect(parser.parse('sample.kml').keys.count).to eq 1
      expect(parser.parse('sample.kml').keys.first).to eq :data
    end
    it 'should contain an array of hashes' do
      expect(parser.parse('sample.kml')[:data].first).to be_an_instance_of Hash
    end
   
  end
end
