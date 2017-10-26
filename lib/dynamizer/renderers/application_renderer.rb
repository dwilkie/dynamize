require "erb"
require_relative "../data_wrappers/document_data"

class Dynamizer::Renderer
  DEFAULT_TEMPLATE_EXTENSION = "erb"
  DEFAULT_OUTPUT_PATH = "/tmp"
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

  def self.template_name
    underscore(self.name)
  end

  # https://stackoverflow.com/a/1509957
  def self.underscore(camel_cased_word)
    camel_cased_word.to_s.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
  end

  def self.output_path
    File.join(output_dir, template_name)
  end

  def self.template_extension
    ENV["DYNAMIZER_TEMPLATE_EXTENSION"] || DEFAULT_TEMPLATE_EXTENSION
  end

  def self.output_dir
    ENV["DYNAMIZER_OUTPUT_DIR"] || DEFAULT_OUTPUT_PATH
  end

  def self.template_path
    File.expand_path("../templates/#{template_name}.#{template_extension}", File.dirname(__FILE__))
  end

  def self.render?
    true
  end
end
