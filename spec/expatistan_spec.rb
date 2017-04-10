require "spec_helper"
require "fakeweb"

RSpec.describe Expatistan do
  it "has a version number" do
    expect(Expatistan::VERSION).not_to be nil
  end

  describe ".compare(city_a, city_b)" do
    context "when city_a is Paris" do
      context "when city_b is London" do
        it "returns 1.2" do
          stream = File.read("paris_london.html")
          FakeWeb.register_uri(:get, 
            "https://www.expatistan.com/cost-of-living/comparison/paris/london", 
            :body => stream, 
            :content_type => "text/html")

          expect(Expatistan.compare("Paris", "London")).to eq(1.2)
        end
      end
    end
  end
end
