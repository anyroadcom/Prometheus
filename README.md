# Prometheus

> Prometheus parses 5 :star2: Tripadvisor Reviews, calculates a score based on selected Adjectives and draws an Image which is uploaded to S3.

Calculating the score is still really immature but will improve with time.

## Parser

```ruby
# Parses All 5★ reviews
# @return [Hash] First Page Reviews
Parser::AllReviews.new(guide: g).parse

# Calculates Top Review 
# @return [Struct] Top Review
Parser::TopReview.new(guide: g).parse

# Creates Image from Review
# @return [String] Url for image on S3 bucket
Parser::CreateImage.new(review).parse
```

## Endpoint

Issuing a `POST` request to the `api/get_image` endpoint will trigger the parser. Once the whole process is completed it will issue a callback with the selected Review containing the Image url.

The Request takes 2 params:

- `anyguide_id` : The id of the Guide
- `trip_url` : The Tripadvisor url of the Guide's Page


## Playground :sparkles:

Set up Env's from your AWS Credentials:
- `ENV['PROMETHEUS_AKID']`: AWS access key id
- `ENV['PROMETHEUS_SECRET']` AWS Secret key


```
$ curl -X POST -H 'Content-Type: application/json' "http://localhost:3000/api/get_image?anyguide_id=123&trip_url=http://www.tripadvisor.com/Attraction_Review-g3174148-d3613903-Reviews-Chania_Diving_Center-Kounoupidiana_Chania_Prefecture_Crete.html"
```