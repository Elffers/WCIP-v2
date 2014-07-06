require "nokogiri"

class Parser
  def parse(document)
    data = {}
    @doc = Nokogiri::XML(File.open(document))
    pms = @doc.css("Placemark")
    data[:data] = pms.map do |placemark|
      parse_placemark(placemark)
    end
    return data
  end

  def parse_placemark(placemark)
    # parses Nokogiri::XML::Element 
    data = {}
    data[:id] = placemark.at("name").text
    data[:coords] = parse_coords placemark.at("coordinates").text
    p data
    data 
  end

  def parse_coords(coordinates)
    c = coordinates.strip
    c = c.split(/\s/)
    c.map { |string| string.split(",") }.map {|pair| pair.reverse }

  end
end
