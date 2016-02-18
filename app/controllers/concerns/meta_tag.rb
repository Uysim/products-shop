class MetaTag
  include MetaTags
  def initialize(options={})
    @options = options
    @request = options[:request]
    @meta_tag = {}
    @base_site = 'gtc-computer'
    process
  end

  def meta
    meta_tag
  end

  def set_title(title=nil)
    meta_tag[:title]=title
  end

  attr_accessor :meta_tag

  private
    attr_accessor :options, :request
    def process
      set_site
      set_keyword
      set_description
      index
    end

    def set_site
      meta_tag[:site] = "GTC Computer"
    end

    def index
      meta_tag[:noindex] = true unless request.host.include?(@base_site)
    end

    def set_keyword
      keywords = %w(
        computer shop laptop desktop server workstation accessories
        networking glow tech cambodia mac trust
      )
      meta_tag[:keywords] = keywords
    end

    def set_description
      meta_tag[:description] = "Glow Tech Cambodia (GTC) provide the best computer
       laptop, desktop, server, workstation, accessories and camera security with good quality and price.
       We are the one you can trust"
    end
end
