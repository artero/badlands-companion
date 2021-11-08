module Iron
  module Filters
    def to_id(input)
      input.downcase
           .gsub(' ', '-')
           .gsub(/[áéíóú]/, '')
    end
  end
end
Liquid::Template.register_filter(Iron::Filters)
