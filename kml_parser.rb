require "nokogiri"

class Parser
  def parse(document)
    data = {}
    placemarks = []
    data[:data] = placemarks
    @doc = Nokogiri::XML(File.open(document))
    pms = @doc.css("Placemark")
    p pms
    return data
  end
end
