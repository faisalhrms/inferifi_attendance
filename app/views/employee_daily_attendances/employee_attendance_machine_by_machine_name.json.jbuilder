json.daily_attendances @daily_attendances.each do |daily_attendance|
	if daily_attendance.Date_Time.to_date >= @start_date.to_date and daily_attendance.Date_Time.to_date <= @end_date.to_date
		json.employee_code daily_attendance.try(:Per_Code)
		json.attendance_date_time daily_attendance.try(:Date_Time)
		json.log_id daily_attendance.try(:ID)
		json.machine_name daily_attendance.try(:Mach_Name)
	end
end