# Creates an Image from the Parsed Top Review

module Parser
  class CreateImage < Base

    def parse
      begin
        #
      rescue StandardError => e
        raise ParseError, e.message
      end
    end

  end
end
