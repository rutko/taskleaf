# frozen_string_literal: true
# Task App
class TasksController < ApplicationController
  def index; end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end
end
