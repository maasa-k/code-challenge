require "scraper"

describe Scraper do

	describe "initialize" do
		it "initializes with an input" do
			expected_input = "../van-gogh-paintings.html"
			scraper = Scraper.new(expected_input)
			expect(scraper.input).to eq(expected_input)
		end
	end

	describe "parse_html method" do
		context "when initialized with an HTML file input" do
			expected_input = "../van-gogh-paintings.html"
			scraper = Scraper.new(expected_input)

			it "creates a solutions.json file" do
				scraper.parse_html
				expect(File.exist?("../solution.json")).to be true
			end

			it "creates a solutions.json file with an Array containing Hashes" do
				scraper.parse_html

				file = File.read("../solution.json")
				data = JSON.parse(file)

				expect(data).to be_a(Array)

				data.each do |item|
					expect(item).to be_a(Hash)
				end
			end

			it "creates a solutions.json file with correct keys" do
				# TODO
			end
		end
	end

end
