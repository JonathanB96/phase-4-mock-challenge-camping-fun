class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :not_valid
    def index
        campers = Camper.all 

        render json: campers, except: [:activities, :created_at, :updated_at]
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper.to_json(except: [:created_at, :updated_at], include: [activities: {except: [:created_at, :updated_at]}]) 
    end


    def create

        camper= Camper.create!(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render json: {errors: ["validation errors"]}, status: :unprocessable_entity
        end

    end

    private
    def camper_params
        params.permit(:name, :age)
    end

    def not_found
        render json: {error: "Camper not found" }, status: :not_found

    end


    def not_valid
        render json: {errors: ["validation errors"]}, status: :unprocessable_entity 
    end
end
