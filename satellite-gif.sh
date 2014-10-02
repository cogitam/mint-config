#!/bin/sh

# Todo: doesn't work just after midnight UTC (anyway, we get optical images...)

cur_date=$(date -u +%Y%m%d) # UTC
cur_hour=$(date -u +%H) # UTC
cur_min=$(date +%M)
cur_min=$(printf '%d' "$cur_min") # Remove first 0 if needed

# Start from 00, 15, 30 or 45 minutes
while [ $cur_min != 0 ] && [ $cur_min != 15 ] && [ $cur_min != 30 ] && [ $cur_min != 45 ]
do
	cur_min=$(( cur_min - 1 ))
	cur_min=$(printf '%d' "$cur_min")
done

c=0

# Get 36 images in the past (3 hours)
while [ $c -lt 36 ]
do
	while [ $cur_min -ge 0 ]
	do
		cur_time=$(printf '%d%02d%02d' "$cur_date" "$cur_hour" "$cur_min")
		# echo $cur_time
		if [ ! -e .sat-$cur_time-$1.jpg ]; then
			wget "http://www.sat24.com/image2.ashx?region=$1&time=$cur_time&type=sat5min&ir=false" -O .sat-$cur_time-$1.jpg
		fi
		cur_min=$(( cur_min - 5 ))
		c=$(( c+1 ))
	done
	cur_min=55
	cur_hour=$(( cur_hour - 1 ))
done

# convert -delay 10 -loop 0 .sat-*.jpg .sat-now-animated.gif
animate -delay 20 .sat-*-$1.jpg

# rm -f .sat-*.jpg
# Delete images older than 3h
find .sat-*-$1.jpg -mmin +120 -exec rm -f {} \;
