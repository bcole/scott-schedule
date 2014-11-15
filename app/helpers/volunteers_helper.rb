module VolunteersHelper
	def cb_id(day, time)
		day.to_s + "_" + time.to_s
	end

	def format_block(block)
		case block.day
		when 0
			d = 'Sun'
		when 1
			d = 'Mon'
		when 2
			d = 'Tues'
		when 3
			d = 'Wed'
		when 4
			d = 'Thurs'
		when 5
			d = 'Fri'
		when 6
			d = 'Sat'
		end

		time = block.start_time


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
        d + ' - ' + t.to_s + str + s
	end
end
