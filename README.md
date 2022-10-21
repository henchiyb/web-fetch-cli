# web-fetch-cli

## About The Project

A CLI for downloading webpages and checking metadata

### Built With

* Ruby version 3.0.3

## Getting Started

### Prerequisites

* docker
  Docker version 20.10.5, build 55c4c88

### Installation

1. Clone the repo
  `git clone https://github.com/henchiyb/web-fetch-cli.git`
2. Move to this repo
  `cd web-fetch-cli`
3. Build docker image
  `docker build . -f Dockerfile -t fetch`
4. Run app
  `docker run -v $(pwd)/:/app fetch https://google.com https://bing.com`

Or you can pull the image from [here](https://hub.docker.com/repository/docker/henchiyb/fetch) and run:

`docker run -v $(pwd)/:/app henchiyb/fetch:1.0 https://google.com`

`docker run -v $(pwd)/:/app henchiyb/fetch:1.0 --metadata https://google.com`

## Usage

* Help
`docker run -v $(pwd)/:/app fetch -h`
* Fetch web pages
`docker run -v $(pwd)/:/app fetch https://google.com https://bing.com`
* Get metadata
`docker run -v $(pwd)/:/app fetch --metadata https://google.com`

## Test (local)

1. Install gem
`bundle install --binstubs`

2. Run rspec
`bin/rspec`

## Contact

Project Link: [https://github.com/henchiyb/web-fetch-cli](https://github.com/henchiyb/web-fetch-cli)