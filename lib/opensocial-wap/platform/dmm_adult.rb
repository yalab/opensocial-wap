module OpensocialWap
  module Platform
    # Singleton Pattern
    extend self

    def dmm_adult(config, &block)
      dmm(config, &block)
    end
  end
end
