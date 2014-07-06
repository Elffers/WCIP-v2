require "nokogiri"

class Parser
  def parse(document)
    data = {}
    placemarks = []
    data[:data] = placemarks
    @doc = Nokogiri::XML(File.open(document))
    return data
  end
end
