module Admin
  class JobsController < Admin::BaseController
    def create
      case job_params[:job_type]
      when 'import'
        Importer::WORKERS.values.each_with_index do |worker, index|
          worker.perform_in(index.hours)
        end
      end
      head :created
    end

    private

    def job_params
      params.require(:job).permit(:job_type)
    end
  end
end
