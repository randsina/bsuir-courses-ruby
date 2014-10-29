class Bash
  def initialize(site, count_pages)
    @agent = Mechanize.new
    @quotes = []
    @site = site
    @count_pages = count_pages
  end

  def run
    next_page = ''

    while (@count_pages > 0) do
      @agent.get("#{@site}#{next_page}") do |page|
        current_page = page.parser.css('[class="page"]').attr('value').text.to_i
        get_quote(page)
        next_page = current_page.pred
        @count_pages -= 1
      end
    end
    create_xml_file(build_xml.to_xml)
  end

  private

  def get_quote(page)
    params = { name: 'id', rating: 'rating-o', date: 'date', text: 'text' }
    page.parser.css('div.quote').each do |quote|
      q = {}
      params.each_pair { |key, value| q[key] = search_by_class(quote, value)}
      @quotes << q unless q[:name].empty?
    end
  end

  def search_by_class(quote, quote_class)
    quote.search("[class='#{quote_class}']").children.text
  end

  def build_xml
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.root {
        xml.Quotes {
          @quotes.each do |quote|
            xml.Quote {
              xml.Name(quote[:name])
              xml.Rating(quote[:rating])
              xml.Date(quote[:date])
              xml.Text(quote[:text])
            }
          end
        }
      }
    end
  end

  def create_xml_file(xml)
    File.open("output.xml", "w") do |file|
      file.write(xml)
    end
  end
end
