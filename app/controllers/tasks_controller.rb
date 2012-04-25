class TasksController < ApplicationController
  def index
  end

  def new
      @channels = Whenbot.trigger_channels
  end
end
