json.daily_attendances @daily_attendances.each do |daily_attendance|
	json.employee_code daily_attendance.try(:Per_Code)
	json.attendance_date_time daily_attendance.try(:Date_Time)
	json.log_id daily_attendance.try(:ID)
	json.machine_name daily_attendance.try(:Mach_Name)
end