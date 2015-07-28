require 'nokogiri'
require 'engtagger'
require 'open-uri'

module Parser
  class Base
    attr_reader :guide

    def initialize(args)
      @guide = args[:guide]
      post_initialize(args)
    end

    def post_initialize(args)
      nil
    end

    def parse
      raise NotImplementedError
    end

    def fetch
      begin
        parse
      rescue StandardError
        raise ParseError, 'Something went wrong in base'
      end
    end

    protected

    def tagger
      @tagger ||= EngTagger.new
    end

    def page
      @page ||= Nokogiri::HTML(open(@guide.trip_url))
    end

    def reviews
      @reviews ||= page.css('div#REVIEWS').css('div.reviewSelector')
    end

  end
end
