class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :update, :destroy]
  
  def index
    @reminders = Reminder.all
    json_response(@reminders)
  end
  
  def create
    @reminder = Reminder.create!(reminder_params)
    json_response(@reminder, :created)
  end
  
  def show
    json_response(@reminder)
  end
  
  def update
    @reminder.update(reminder_params)
    head :no_content
  end
  
  def destroy
    @reminder.destroy
    head :no_content
  end
  
  private
  
    def reminder_params
      params.permit(:title, :created_by, :done)
    end
    
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end
end