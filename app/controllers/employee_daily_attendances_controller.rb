class EmployeeDailyAttendancesController < ApplicationController
	def daily_attendances
		start_date = params[:start_date].to_date.strftime('%Y-%m-%d')
		end_date   = params[:end_date].to_date.strftime('%Y-%m-%d')
		@daily_attendances = ActiveRecord::Base.connection.select_all(<<~SQL)
      SELECT employee_code, attendance_time
      FROM dbo.attendance_logs
      WHERE CAST(attendance_time AS DATE) BETWEEN '#{start_date}' AND '#{end_date}'
    SQL
		render 'employee_daily_attendances/daily_attendances', status: :ok
	rescue => e
		render json: { status: 500, error: e.message }, status: 500
	end
end
