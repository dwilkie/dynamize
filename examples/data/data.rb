class MyData < Dynamizer::Data
  require 'date'

  def last_updated_on
    # e.g external request
    @last_updated_on ||= Date.today
  end

  # def cached_external_request
    # @cached_external_request ||= do_external_request!
  # end
end
