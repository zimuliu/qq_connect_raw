module QQConnectRaw
  class Error < StandardError
  end

  class NotConfigured < Error; end

  class FailedResponse < Error
    attr_reader :code, :method, :path
    alias :msg :message

    def initialize(msg, code, method, path)
      @code = code
      @method = method
      @path = path
      super("'#{method}.upcase #{path}' - #{msg}")
    end
  end
end
