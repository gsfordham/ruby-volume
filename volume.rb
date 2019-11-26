def get_volume
	volumes = {}
	master = (`amixer`.split(/^simple mixer control/i).reject {|x| x.match(/^[\s]*$/)}).reject {|x| !x.match(/[\s]*'Master'/)}
	
	channels = master[0].split(/$/).reject {|x| !x.match(/\[on\]$/)}
	
	channels.each do |x|
		raw = x.split(/:[\s]*/)
		value = raw[1].gsub(/(^[\w\s\d]+\[|%\].*)/, "").to_f
		key = raw[0].gsub(/^[\s]+/, "").gsub(/[\s]+/, "_").downcase
		volumes[key] = value
	end
	
	volumes
end #End getting volume

def min_max
	low = 0.0
	high = 100.0
	
	vols = get_volume
	
	vols.each do |v|
		if v[1] > low
			low = v[1]
		elsif v[1] < high
			high = v[1]
		end
	end
	
	[low, high]
end #End getting of min and max vols

def confirm cmd, setting
	`#{cmd}`
	low, high = min_max
	
	#The lowest and highest volume values must be equal,
	#or else the speakers will have different outputs
	while low != high
		`#{cmd}`
		low, high = min_max
	end
end #End confirm/validate volume

def set_volume adjustment
	change = 0 #Initialize no change
	op = nil #Initialize a no-op
	
	#Determine what arguments were passed, if any
	if adjustment.length == 1
		op = adjustment[0][0] #Operation is the first character
		
		#Change will be any integer that can be extracted
		change = adjustment[0].sub(/(^[\d]+%[+-]?)*/, '').to_i
	end
	
	#Get the current volume and extract the maximum as the "current setting"
	current = 0
	vols = get_volume
	vols.each do |v|
		if v[1] > current
			current = v[1]
		end
	end
	
	final = current
	
	case op
	when *['+','-']
		final = (current + change)
	else
		final = change
	end
	
	final = final.to_i
	if final < 0
		final = 0
	elsif final > 100
		final = 100
	end
	
	cmd = "amixer set Master playback #{final}%"
	confirm cmd, final
end

#Main application
def main *args
	set_volume *args
	get_volume
end

main ARGV