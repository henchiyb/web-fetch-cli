require 'faraday'
require 'nokogiri'

def download_page(url:)
  begin
    res = Faraday.get(url)

    while res.status >= 300 && res.status < 400
      redirect_url = res["Location"]
      res = Faraday.get(redirect_url)
    end

    raise "Get page error" if res.status >= 400
    
    file_name = url.split('/').slice(2..-1).join('_')
    File.write("data/html/#{file_name}.html", res.body)

    doc = Nokogiri::HTML(res.body)
    num_images = doc.css('img').size
    num_links = doc.css('a').size
    
    File.write("data/metadata/#{file_name}_metadata.txt", "Site: #{url}\nImages: #{num_images}\nLinks: #{num_links}\nLast fetch time: #{Time.now}")
    puts "Download page success. URL: #{url}"
  rescue => e
    puts "Download page error. URL: #{url}"
  end
end

ARGV.each do |arg|
  download_page(url: arg)
end
