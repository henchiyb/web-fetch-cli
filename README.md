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
  `docker run -v $(pwd)/:/app fetch https://exampl1.com https://example2.com ...`

## Usage

* Help
`docker run -v $(pwd)/:/app fetch -h`
* Fetch web pages
`docker run -v $(pwd)/:/app fetch https://exampl1.com https://example2.com ...`
* Get metadata
`docker run -v $(pwd)/:/app fetch --metadata https://google.com`

## Contact
Project Link: [https://github.com/henchiyb/web-fetch-cli](https://github.com/henchiyb/web-fetch-cli)