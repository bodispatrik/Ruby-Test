require 'open-url'
require 'nokogiri'
require 'csv'

def scraping(url)
    html = open("#{url}").read
    nokogiri_doc = Nokogiri::HTML(html)
    final_array = []

    nokogiri_doc.search("Link--primary v-align-middle no-underline h4 js-navigation-open markdown-title").each do |element|
        element = element.text
        final_array << element 
    end

    final_array.each_with_index do |element, index|
        puts "#{index + 1} - #{element}"
    end
end

scraping = scraping('https://github.com/rails/rails/pulls')



filepath = "test_end.csv"

csv_options = {headers: :first_row, col_sep: ';'}


csv.open(filepath, 'wb', csv_options) do |csv|
    csv << ['title', 'index']
    scraping.each_with_index do |item, index|
        csv << [item, index]
    end
end
