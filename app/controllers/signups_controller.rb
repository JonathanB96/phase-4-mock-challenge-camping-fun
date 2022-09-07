class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    def create
        
        signup = Signup.create(signup_params)
        if signup.valid?
            activity = signup.activity
            render json: activity, status: :created
        else
            render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
        end              
    end

    private
    
    def not_found
        render json: {error: "validation errors" }, status: :not_found

    end

    def signup_params 
        params.permit(:time, :camper_id, :activity_id)
    end

end
