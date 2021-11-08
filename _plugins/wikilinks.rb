require 'pry'

module Wikilinks
  def self.transform(doc)
    doc.output.gsub!(/\[\[([^\]]+)\]\]/) do |_m|
      link = Regexp.last_match(1)
      if link =~ /^(.+)\|(.+)$/
        link = Regexp.last_match(1)
        text = Regexp.last_match(2)
      else
        text = link
      end
      sanitized_link = link.downcase
                           .gsub(' ', '-')
                           .gsub(/[áéíóú]/, '')
      "<a href=\"#{sanitized_link}\">#{text.gsub('#', '')}</a>"
    end
  end
end

Jekyll::Hooks.register :pages, :post_render do |doc|
  Wikilinks.transform(doc)
end
