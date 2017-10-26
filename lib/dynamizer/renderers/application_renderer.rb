require "erb"
require_relative "../data_wrappers/document_data"

class Dynamizer::ApplicationRenderer
  DEFAULT_TEMPLATE_EXTENSION = "erb"
  attr_accessor :content, :document_data

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def initialize(options = {})
    self.content = options[:content]
    self.document_data = options[:document_data]
  end

  def render
    ERB.new(template).result(binding)
  end

  def generate_doc!
    FileUtils.mkdir_p(File.dirname(self.class.output_path))
    File.open(self.class.output_path, 'w') { |file| file.write(render) }
  end

  def content
    @content ||= {}
  end

  private

  def template
    @template ||= File.read(self.class.template_path)
  end

  def document_data
    @document_data ||= Dynamizer::DocumentData.new
  end

  def self.template_extension
    DEFAULT_TEMPLATE_EXTENSION
  end

  def self.template_name
    self::TEMPLATE_NAME
  end

  def self.output_path
    File.expand_path("../../../docs/#{template_name}", File.dirname(__FILE__))
  end

  def self.template_path
    File.expand_path("../templates/#{template_name}.#{template_extension}", File.dirname(__FILE__))
  end

  def self.render?
    true
  end
end
