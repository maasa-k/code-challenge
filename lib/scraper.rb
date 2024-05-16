require "json"
require "nokogiri"
require "open-uri"
require "net/http"

class Scraper
	attr_accessor :input

	def initialize(input)
	@input = input
	end

	def html_or_uri
	# This creates an HTML file, but it is not getting parsed as expected
	if @input.include?("http")
		uri = URI.parse(@input)
		@html = Net::HTTP.get_response(uri).body
		File.write("../other-paintings.html", @html)
		return Nokogiri::HTML.parse(@html)
	else
		return Nokogiri::HTML.parse(open(@input))
	end
	end

	def parse_html
	result = []

	doc = html_or_uri

		doc.css("g-scrolling-carousel div > a").each do |item|
		itemName = item.css("div > div:nth-of-type(1)").text
		itemDate = item.css("div > div:nth-of-type(2)").any? ? item.css("div > div:nth-of-type(2)").text : nil
		itemLink = "https://www.google.com" + item.attr("href")
		itemImage = item.at_css("img").attr("src")

		hashed_data = {}

		hashed_data["name"] = itemName

		if !itemDate.nil?
			hashed_data["extensions"] = [itemDate]
		end

		hashed_data["link"] = itemLink

		hashed_data["image"] = !itemImage.nil? ? itemImage : nil

		result << hashed_data
		end

		File.write("../solution.json", JSON.pretty_generate(result))
	end
end
