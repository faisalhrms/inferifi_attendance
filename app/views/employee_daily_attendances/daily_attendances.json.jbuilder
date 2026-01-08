json.daily_attendances @daily_attendances.each do |daily_attendance|
	json.employee_code 					daily_attendance["employee_code"]
	json.attendance_date_time 	daily_attendance["attendance_time"]
	json.machine_name 					'Inferifi'
	json.ip_address 						'103.116.251.49'
end