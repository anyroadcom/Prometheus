# Creates an Image from the Parsed Top Review

module Parser
  class CreateImage < Base

    attr_reader :review

    def post_initialize(args)
      @review = args[:review]
    end

    def parse
      begin
        img = Magick::Image.read('https://s3.amazonaws.com/anyadvisor/any_advisor.jpg').first

        # Create a new image in memory with a transparent canvas
        mark = Magick::Image.new(img.rows, img.columns) { self.background_color = 'none' }
        draw = Magick::Draw.new

        review_body = @review.body.truncate_words(20)

        draw.annotate(mark, 0, 0, 0, 0, fit_text(review_body, 500)) do
          draw.gravity = Magick::CenterGravity
          draw.pointsize = 50
          # draw.font_family = AnyAdvisor.configuration.font_family # set font
          draw.fill = "#fff"
          draw.stroke = "none" # remove stroke
        end

        img = img.dissolve(mark, 0.9, 0.9, Magick::CenterGravity)
        img.write('/tmp/any_image.jpg')

        # send_to_aws

      rescue StandardError => e
        raise ParseError, e.message
      end
    end

    # Fit the text in the Frame
    def text_fit?(text, width)
      begin
        tmp_img = Magick::Image.new(width, 600) { self.background_color = 'none' }
        drawing = Magick::Draw.new

        drawing.annotate(tmp_img, 0, 0, 0 ,0, text) { |txt|
          txt.gravity = Magick::NorthGravity
          txt.pointsize = 50
        }

        metrics = drawing.get_multiline_type_metrics(tmp_img, text)
        (metrics.width < width)

      rescue StandardError => e
        raise ParseError, e.message
      end
    end

    def fit_text(text, width)
      separator = ' '
      line = ''

      if not text_fit?(text, width) and text.include? separator
        i = 0
        text.split(separator).each do |word|
          if i == 0
            tmp_line = line + word
          else
            tmp_line = line + separator + word
          end

          if text_fit?(tmp_line, width)
            unless i == 0
              line += separator
            end
            line += word
          else
            unless i == 0
              line +=  '\n'
            end
            line += word
          end
          i += 1
        end
        text = line
      end
      text
    end

  end
end
