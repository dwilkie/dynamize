require_relative "data"
require_relative "renderer"

class Dynamizer::Runner
  DEFAULT_RENDERERS_DIR = "/tmp/dynamizer_renderers"
  DEFAULT_DATA_DIR = "/tmp/dynamizer_data"

  def self.renderers_path
    ENV["DYNAMIZER_RENDERERS_DIR"] || DEFAULT_RENDERERS_DIR
  end

  def self.data_path
    ENV["DYNAMIZER_DATA_DIR"] || DEFAULT_DATA_DIR
  end

  def dynamize!
    require_renderers
    require_data
    renderers_to_execute.each do |renderer_class|
      renderer_class.new(:data => data).generate_output!
    end
  end

  private

  def require_data
    require_dir(self.class.data_path)
  end

  def require_renderers
    require_dir(self.class.renderers_path)
  end

  def require_dir(path, glob = "**/*.rb")
    Dir[File.join(path, glob)].each { |f| require f }
  end

  def data
    @data ||= (descendants(Dynamizer::Data).first || Dynamizer::Data).new
  end

  def descendants(parent_klass)
    ObjectSpace.each_object(Class).select { |klass| klass < parent_klass }
  end

  def renderers_to_execute
    descendants(Dynamizer::Renderer).select { |renderer_class| renderer_class.render? }
  end
end
