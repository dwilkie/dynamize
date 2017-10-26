require "erb"

class Dynamizer::Renderer
  DEFAULT_TEMPLATE_EXTENSION = "erb"
  DEFAULT_TEMPLATES_DIR = "/tmp/dynamizer_templates"
  DEFAULT_OUTPUT_DIR = "/tmp/dynamizer_output"

  attr_accessor :data

  def initialize(options = {})
    self.data = options[:data]
  end

  def render
    ERB.new(template).result(binding)
  end

  def generate_output!
    FileUtils.mkdir_p(File.dirname(self.class.output_path))
    File.open(self.class.output_path, 'w') { |file| file.write(render) }
  end

  private

  def template
    @template ||= File.read(self.class.template_path)
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

  def self.template_path
    File.join(templates_dir, template_name)
  end

  def self.template_extension
    ENV["DYNAMIZER_TEMPLATE_EXTENSION"] || DEFAULT_TEMPLATE_EXTENSION
  end

  def self.output_dir
    ENV["DYNAMIZER_OUTPUT_DIR"] || DEFAULT_OUTPUT_DIR
  end

  def self.templates_dir
    ENV["DYNAMIZER_TEMPLATES_DIR"] || DEFAULT_TEMPLATES_DIR
  end

  def self.render?
    true
  end
end
