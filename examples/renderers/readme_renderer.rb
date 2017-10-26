class ReadmeRenderer < Dynamizer::Renderer
  TEMPLATE_NAME = "README.md"

  def self.template_name
    TEMPLATE_NAME
  end

  def last_updated_on
    Date.today.to_time.strftime("%d %B %Y")
  end
end
