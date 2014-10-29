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
        page.parser.css('div.quote').each do |quote|
          name = quote.search("[class='id']").children.text
          rating = quote.search("[class='rating-o']").children.text
          date = quote.search("[class='date']").children.text
          text = quote.search("[class='text']").children.text

          @quotes << {:name => name, :rating => rating, :date => date, :text => text} unless name.empty?
        end
        next_page = current_page.pred
        @count_pages = @count_pages.pred
      end
    end
    create_xml_file(build_xml.to_xml)
  end

  private

  def build_xml
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.root {
        xml.Quotes {
          @quotes.each do |quote|
            xml.Quote {
              xml.Name quote[:name]
              xml.Rating quote[:rating]
              xml.Date quote[:date]
              xml.Text quote[:text]
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
