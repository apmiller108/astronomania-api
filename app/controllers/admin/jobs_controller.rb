module Admin
  class JobsController < Admin::BaseController
    def create
      case job_params[:job_type]
      when 'import'
        create_import_jobs
      else
        return render_error(message: I18n.t(:detail,
                                            scope: 'errors.unkown_job'))
      end
      head :created
    end

    private

    def create_import_jobs
      Importer::WORKERS.values.each_with_index do |worker, index|
        worker.perform_in(index.hours)
      end
    end

    def job_params
      params.require(:job).permit(:job_type)
    end
  end
end
