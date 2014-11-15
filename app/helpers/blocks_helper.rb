module BlocksHelper
	def cb_id(day, time)
		day.to_s + "_" + time.to_s
	end

	def format_time(time)
		start_slot = 10
        t = start_slot + (time / 2)
        s = 'AM'
        if t > 11
        	s = 'PM'
		end
        t = (t - 1) % 12 + 1

        str = ":00"
        if (time % 2 == 1)
        	str = ":30"
        end
        t.to_s + str + s
	end
end
