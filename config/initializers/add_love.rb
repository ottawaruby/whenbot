class AddLove
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers["X-who-loves-you"] = 'whenbot'
    [status, headers, response.body]
  end
end