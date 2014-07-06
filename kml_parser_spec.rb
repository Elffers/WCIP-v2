require_relative "kml_parser"

describe Parser do
  let(:parser){ Parser.new }
  let(:coords) { " -122.354206,47.734092 -122.354200,47.732372 -122.354248,47.732323 -122.354303,47.732302" }

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

  context 'parse placemark' do
    it 'returns a hash' do
      placemark = Nokogiri::XML(File.open('sample.kml')).css("Placemark").first
      expect(parser.parse_placemark(placemark)).to be_an_instance_of Hash
    end
    it 'contains id, coord, and linestyle' do
      placemark = Nokogiri::XML(File.open('sample.kml')).css("Placemark").first
      expect(parser.parse_placemark(placemark).keys).to eq [:id, :coords, :linestyle]
    end
  end 

  context 'parse coordinates' do
    it 'returns array with lat first then long' do
      expect(parser.parse_coords(coords)).to eq [["47.734092", "-122.354206"], ["47.732372", "-122.354200"], ["47.732323", "-122.354248"], ["47.732302", "-122.354303"]]
    end
  end
end
