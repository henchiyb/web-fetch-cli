# web-fetch-cli app design

## Requirement

* Features:
  * Download page (HTML) for local use (can give multiple urls in argument of cli)
  * Check metada, include site name, num of images, nums of links and last fetch time.
  * Get all asset (Optional)
* Non-feature requirement
  * Use docker to build cli app
  * Don't use UNIX utilities like wget, ...

## Tools

* Ruby version 3.0.3
* [Faraday](https://lostisland.github.io/faraday/) library - request process
* [Nokogiri](https://github.com/sparklemotion/nokogiri) - HTML parser
* [RSpec](https://rspec.info/) - Unit test

## Feature Design

* Download page features:
  * Send get request to the URL, save HTML response to local file
  * If error => print error
  * If page is redirected -> move to redirected page

* Check metadata:
  * Save metadata of a page to a file:
    * Pros: If this page has downloaded before -> return the metadata
  * If checking page isn't downloaded => print "Metadata not found" (or fetch the page and return metadata)
  * If checking page is downloaded, return metadata file content

## Detailed Design

### Folder Structure

```sh
  root
    fetch.rb        # main file
    data/           # folder of downlaoded file
      html/
      metadata/
    Dockerfile
    Gemfile
    Gemfile.lock
```

### App deigsn

I will make some aumption for clear the requirement of app

- The input urls must have http or https prefix
- "-metadata" must be the first argument and only show metadata of a url after it


* Use ruby ARGV for check argument pass into app (check --metadata argument)
* Download page features:
  * Simple send get request to the target url
  * If this url is redirected -> move to new page
  * If response >= 400 (error responses) -> print "Download page error. URL: {get_url}"
  * Save both html and metadata (Use html parser to count images and links)

* Get metadata:
  * Check if metadata existed -> print file content
  * If not => print "Metadata not found"

## Things not done

* `Archive all assets as well as html so that you load the web page locally with all assets loading properly.`
  * Now this app only download 1 web page at input url, if subpages needed we have to check each link in pages, download subpage and change the link to local file
  * Same as above, to get CSS/Image we ahve to download all by link and replace the path with local file path
* Add db for test (like a db for test and clear db after each test)
* Optimization:
  * When download multi pages, the execution time maybe slow because we run sequentialy -> can use parallel to speed up the process
  * The cons of this approach is if in argument input have duplicate url, 2 process may be write into same file at the same time => conflict
