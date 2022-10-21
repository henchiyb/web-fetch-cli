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
    puts "Download page success\nURL: #{url}\nFile path: data/html/#{file_name}.html"
  rescue => e
    puts "Download page error. URL: #{url}"
  end
end

def get_metadata(url:)
  begin
    file_name = url.split('/').slice(2..-1).join('_')
    if File.exists?("data/metadata/#{file_name}_metadata.txt")
      puts File.read("data/metadata/#{file_name}_metadata.txt")
    else
      puts "Metadata not found"
    end
  rescue => e
    puts "Get metadata error. Use `ruby fetch.rb -h` for help"
  end
end

if ARGV[0] == "--metadata"
  get_metadata(url: ARGV[1])
elsif ARGV[0] == "-h"
  puts "Usage: ./fetch [URLS]   # download pages by URL format `https://example.com`"
  puts "--metadata              # get metadata of downloaded page"
else
  ARGV.each do |arg|
    download_page(url: arg)
  end
end
