# Parser of site 'http://bash.im' in XML
class Bash
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
    params = { name: 'id', rating: 'rating-o', date: 'date', text: 'text' }
    page.parser.css('div.quote').each do |quote|
      q = {}
      params.each_pair { |key, value| q[key] = quote.search("[class='#{value}']").children.text }
      @quotes << q unless q[:name].empty?
    end
  end

  def build_xml
    builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.root do
        xml.Quotes do
          @quotes.each do |quote|
            xml.Quote do
              xml.Name(quote[:name])
              xml.Rating(quote[:rating])
              xml.Date(quote[:date])
              xml.Text(quote[:text])
            end
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
