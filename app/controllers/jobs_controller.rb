class JobsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :authorize_user_for_job!, only: [:edit, :update, :delete]

	def index
		@jobs = Job.all
	end

	def new
		@job = Job.new
	end

	def create
		Job.create(job_params)
		redirect_to jobs_path
	end

	def edit
	end

	def update
		@job.update_attributes(job_params)
		redirect_to jobs_path
	end

	def destroy
		@job.destroy
		redirect_to jobs_path
	end

	def authorize_user_for_job!
		@job = Job.find(params[:id])
		redirect_to jobs_path unless current_user == job_user
	end


	private 

	def job_params
		params.require(:job).permit(:title, :description)
	end
end
