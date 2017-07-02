module Admin
  class JobsController < Admin::BaseController
    def create
      case job_params[:job_type]
      when 'import'
        Importer::WORKERS.each_value(&:perform_async)
      end
      head :created
    end

    private

    def job_params
      params.require(:job).permit(:job_type)
    end
  end
end
