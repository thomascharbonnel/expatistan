require "expatistan/version"
require "mechanize"

module Expatistan
  def self.compare(city_a, city_b)
    city_a = parse_city_name(city_a)
    city_b = parse_city_name(city_b)

    a = Mechanize.new
    page = a.get("https://www.expatistan.com/cost-of-living/comparison/#{city_a}/#{city_b}")

    text = page.search("h1 span.content").text

    if text =~ /more expensive/
      1 + text.gsub(/% more expensive/, "").to_i / 100.0
    end
  end

  def self.parse_city_name(orig)
    orig.downcase.gsub(/ /, "-")
  end
end
