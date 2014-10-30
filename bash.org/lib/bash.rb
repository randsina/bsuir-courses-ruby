# Parser of site 'http://bash.im' in XML
class Bash
  PARAMS = { name: 'id', rating: 'rating-o', date: 'date', text: 'text' }

  def initialize(site, count_pages)
    @agent = Mechanize.new
    @quotes = []
    @site = site
    @count_pages = count_pages
  end

  def run
    next_page = ''

    @count_pages.times do
      @agent.get("#{@site}#{next_page}") do |page|
        current_page = page.parser.css('[class="page"]').attr('value').text.to_i
        get_quote(page)
        next_page = current_page.pred
      end
    end
    create_xml_file(build_xml.to_xml)
  end

  private

  def get_quote(page)
    page.parser.css('div.quote').each do |quote|
      q = {}
      PARAMS.each_pair { |key, value| q[key] = quote.search("[class='#{value}']").children.text }
      @quotes << q unless q[:name].empty?
    end
  end

  def build_xml
    Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.root do
        xml.quotes do
          @quotes.each do |quote|
            xml.quote(quote)
          end
        end
      end
    end
  end

  def create_xml_file(xml)
    File.open('output.xml', 'w') do |file|
      file.write(xml)
    end
  end
end
