require "spec_helper"
require "artifice"

def rack_help(file)
  Proc.new do |env|
    [
      200,
      {"Content-Type": "text/html"},
      [open(file).read]
    ]
  end
end

RSpec.describe Expatistan do
  it "has a version number" do
    expect(Expatistan::VERSION).not_to be nil
  end

  describe ".parse_city_name(orig)" do
    context "when the city name is Paris" do
      it "returns 'paris'" do
        expect(Expatistan.parse_city_name("Paris")).to eq("paris")
      end
    end

    context "when the city name is Hong Kong" do
      it "returns 'hong-kong'" do
        expect(Expatistan.parse_city_name("Hong Kong")).to eq("hong-kong")
      end
    end
  end

  describe ".compare(city_a, city_b)" do
    context "when city_a is Paris" do
      context "when city_b is London" do
        it "returns 1.31" do
          Artifice.activate_with(rack_help("paris_london.html"))

          expect(Expatistan.compare("Paris", "London")).to eq(1.31)
        end
      end

      context "when city_b is Paris" do
        it "returns 1" do
          Artifice.activate_with(rack_help("paris_paris.html"))

          expect(Expatistan.compare("Paris", "Paris")).to eq(1)
        end
      end

      context "when city_b is Berlin" do
        it "returns 0.8" do
          Artifice.activate_with(rack_help("paris_berlin.html"))

          expect(Expatistan.compare("Paris", "Berlin")).to eq(0.8)
        end
      end
    end
  end
end
