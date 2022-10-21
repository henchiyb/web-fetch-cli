RSpec.describe "Fetch" do
  context "download pages" do
    it "success" do
      expect { system %(ruby fetch.rb https://google.com https://bing.com) }
      .to output(include("Download page success. URL: https://google.com\nDownload page success. URL: https://bing.com"))
      .to_stdout_from_any_process
    end

    it "error" do
      expect { system %(ruby fetch.rb https://gogle.com) }
      .to output(include("Download page error. URL: https://gogle.com"))
      .to_stdout_from_any_process
    end
  end

  context "get metadata" do
    it "success" do
      expect { system %(ruby fetch.rb --metadata https://google.com) }
      .to output(include("Site: https://google.com"))
      .to_stdout_from_any_process
    end

    it "not found" do
      expect { system %(ruby fetch.rb --metadata https://gogle.com) }
      .to output(include("Metadata not found"))
      .to_stdout_from_any_process
    end
  end
end