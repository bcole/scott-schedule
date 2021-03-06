# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for d in 0..6
	for t in 0..19
		Block.create(day: d, start_time: t)
	end
end

v = Volunteer.create(first_name: 'Brandon', last_name: 'Cole', contact_number: '716-474-3417', notes: 'My email is bnc8088@rit.edu');

Confirmation.create(volunteer: v, block: Block.find(1), confirmed: false)
Confirmation.create(volunteer: v, block: Block.find(2), confirmed: false)
Confirmation.create(volunteer: v, block: Block.find(21), confirmed: false)