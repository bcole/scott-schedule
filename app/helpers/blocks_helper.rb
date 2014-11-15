module BlocksHelper
	def cb_id(day, time)
		day.to_s + "_" + time.to_s
	end

	def format_time(time)
		start_slot = 10
        t = start_slot + time
        s = 'AM'
        if t > 11
        	s = 'PM'
		end
        t = (t - 1) % 12 + 1
        t.to_s + s
	end
end
