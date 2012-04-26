class AddLove
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers["X-Who-Loves-You"] = 'whenbot'
    [status, headers, response.body]
  end
end