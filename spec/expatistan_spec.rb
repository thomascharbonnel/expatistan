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

  describe ".compare(city_a, city_b)" do
    context "when city_a is Paris" do
      context "when city_b is London" do
        it "returns 1.31" do
          Artifice.activate_with(rack_help("paris_london.html"))

          expect(Expatistan.compare("Paris", "London")).to eq(1.31)
        end
      end
    end
  end
end
