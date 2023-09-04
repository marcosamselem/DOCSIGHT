class UsersController < ApplicationController
  def index
    @doctors = User.where(role: "doctor")
    @doctors.each do |doctor|
      @markers = doctor.locations.geocoded.map do |location|
        {
          lat: location.latitude,
          lng: location.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {location: location})
        }
      end
    end
  end

  def new
    @patient = User.new
  end

  def create
    @patient = User.new(params_user)
    @patient = User.find(params[:id])
    @patient.save!
    redirect_to users_path
  end

  def show
    @doctor = User.find(params[:id])
    @appointment = Appointment.new
    @date = params[:appointment_date]
    # @doctor_appointments = Appointment.where() the date day == to the form, and the Doctor Id from the doctors table
    # @procedure = params[:procedure]
    
    @doctor.locations
      @markers = @doctor.locations.geocoded.map do |location|
        {
          lat: location.latitude,
          lng: location.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {location: location})
        }
    end
  end

  private

  def params_user
    params.require(:user).permit(:first_name, :last_name, :bio, :email, :password, :phone_number, :specialty)
  end
end
