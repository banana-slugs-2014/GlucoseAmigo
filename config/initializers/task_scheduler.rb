scheduler = Rufus::Scheduler.new

#send one out every day at noon
scheduler.cron("0 12 * * *") do
  Diabetic.all.each do |diabetic|
  	#DiabeticMailer.reminder_email(diabetic).deliver
 	end
end 

# for a certain frequency, something like
# scheduler.every("1m") do
#   Diabetic.all.each do |diabetic|
#   	#DiabeticMailer.reminder_email(diabetic).deliver
#  	end
# end 