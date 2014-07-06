require "nokogiri"

class Parser
  def parse(document)
    data = {}
    @doc = Nokogiri::XML(File.open(document))
    pms = @doc.css("Placemark")
    data[:data] = pms.map do |placemark|
      parse_placemark(placemark)
    end
    data
  end

  def parse_placemark(placemark)
    # parses Nokogiri::XML::Element 
    data = {}
    data[:id] = placemark.at("name").text
    data[:coords] = parse_coords placemark.at("coordinates").text
    data[:linestyle] = placemark.at("styleUrl").text
    data 
  end

  def parse_coords(coordinates)
    c = coordinates.strip.split(/\s/)
    c.map { |string| string.split(",") }.map {|pair| pair.reverse }
  end
end
