require 'spec_helper'
require 'dynamizer/document_updater'

RSpec.describe Dynamizer::DocumentUpdater do
  describe "#dynamize!", :fakefs do
    class MyRenderer < Dynamizer::Renderer
      require 'date'

      def template
        @template ||= "<%= last_modified_at %>"
      end

      def last_modified_at
        Date.today
      end
    end

    before do
      setup_scenario
    end

    def setup_scenario
      subject.dynamize!
    end

    def assert_dynamize!
      expect(File.read("#{Dynamizer::Renderer::DEFAULT_OUTPUT_DIR}/my_renderer")).to eq(Date.today.to_s)
    end

    it { assert_dynamize! }
  end
end
