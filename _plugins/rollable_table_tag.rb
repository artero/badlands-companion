module Iron
  module RollableTableTag
    def rollable_table(input)
      rows = input.each_with_object([]) do |row, array|
        array << (p %(
          <tr>
            <th scope="row" data-key="#{row['from']}">#{row['from']}-#{row['to']}</th>
            <td>#{row['value']}</td>
          </tr>
        ))
      end
      p %(
        <table id="{{input.split('.').last}}"
               class="table table-sm table-striped table-hover">
          <tbody>
            #{rows.join}
          </tbody>
        </table>
      )
    end
  end
end
Liquid::Template.register_filter(Iron::RollableTableTag)

module Jekyll
  class RenderTimeTag < Liquid::Tag
    attr_reader :text

    def initialize(tag_name, text, tokens)
      super
      @text = text.gsub(/\s+/, '')
    end

    def render(context)
      data = context.environments.first['site']['data'][text]
      rows = data.each_with_object([]) do |row, array|
        array << (p %(
          <tr>
            <th scope="row" data-value="#{row['value']}">#{row['label']}</th>
            <td>#{row['description']}</td>
          </tr>
        ))
      end

      p %(
        <table id="#{text}"
               class="table table-sm table-striped table-hover">
          <tbody>
            #{rows.join}
          </tbody>
        </table>
      )
    end
  end
end
Liquid::Template.register_tag('render_time', Jekyll::RenderTimeTag)
