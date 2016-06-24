class MetaTag
  include MetaTags
  def initialize(options={})
    @options = options
    @request = options[:request]
    @meta_tag = {}
    @category = options[:category]
    @product = options[:product]
  end

  def meta
    process
    meta_tag
  end

  
  private
    attr_accessor :meta_tag, :options, :request, :product, :category
    def process
      set_site
      set_title
      set_description
      set_keyword
    end

    def set_title
      @meta_tag[:title] = category.name if category.present?
      @meta_tag[:title] = product.name if product.present?
    end

    def set_site
      @meta_tag[:site] = "GTC Computer"
    end

    def set_keyword
      site_default_keywords
      keywords_from_desc if category.present? or product.present?
    end

    def set_description
      default_desc
      desc_from_category if category.present?
      desc_from_product  if product.present?
    end

    def default_desc
      @meta_tag[:description] = "Glow Tech Cambodia (GTC) provide the best computer
       laptop, desktop, server, workstation, accessories and camera security with good quality and price.
       We are the one you can trust"
    end

    def desc_from_category
      description = category.description
      text = Nokogiri::HTML(description).text
      @meta_tag[:description] = text
    end

    def desc_from_product
      name = product.name
      spec = product.fields.pluck(:value).join(" ")
      text = "#{name} #{spec}"
      @meta_tag[:description] = text
    end

    def keywords_from_desc
      keywords = meta_tag[:description].split(' ')
      rand_keywords = keywords.shuffle
      @meta_tag[:keywords] = rand_keywords
    end

    def site_default_keywords
      default_keywords = %w(
        computer shop laptop desktop server workstation accessories
        networking glow tech cambodia mac trust
      )
      @meta_tag[:keywords] = default_keywords
    end
end
