require 'spec_helper'
require 'dynamizer/document_updater'

RSpec.describe Dynamizer::DocumentUpdater do
  describe "#update_all!", :fakefs do
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
      subject.update_all!
    end

    def assert_update_all!
      expect(File.read("/tmp/my_renderer")).to eq(Date.today.to_s)
    end

    it { assert_update_all! }
  end
end
