#!/bin/bash

# Todo: doesn't work just after midnight UTC (anyway, we get optical images...)

if [ ! -d .sat24-images ]; then
	mkdir .sat24-images
fi
cd .sat24-images

if [ ! -z $1 ]; then
	region=$1
else
	region="fr"	
fi

cur_date=$(date -u +%Y%m%d) # UTC
cur_hour=$(date -u +%H) # UTC
cur_min=$(date +%M)
cur_min=$(printf '%d' "$cur_min") # Remove first 0 if needed

# Start from 05, 10, 15, 20, 25, ...
while [ ${cur_min:(-1):1} != 0 ] && [ ${cur_min:(-1):1} != 5 ]
do
	cur_min=$(( cur_min - 1 ))
	cur_min=$(printf '%d' "$cur_min")
done

c=0

# Get 72 images in the past (72*5min = 6*12*5min = 6 hours)
while [ $c -lt 72 ]
do
	while [ $cur_min -ge 0 ]
	do
		cur_time=$(printf '%d%02d%02d' "$cur_date" "$cur_hour" "$cur_min")
		# echo $cur_time
		if [ ! -e .sat-$cur_time-$1.jpg ]; then
			wget "http://www.sat24.com/image2.ashx?region=$region&time=$cur_time&type=sat5min&ir=false" -O .sat-$cur_time-$region.jpg
		fi
		cur_min=$(( cur_min - 5 ))
		c=$(( c+1 ))
	done
	cur_min=55
	cur_hour=$(( cur_hour - 1 ))
done

# convert -delay 10 -loop 0 .sat-*.jpg .sat-now-animated.gif
# Image delay in 1e-3 seconds
if [ ! -z $2 ]; then
	frame_length=$2
else
	frame_length=20
fi
animate -delay $frame_length .sat-*-$region.jpg

# rm -f .sat-*.jpg
# Only delete images older than 6h to save time and be nice with sat24.com
find .sat-*-$region.jpg -mmin +360 -exec rm -f {} \;
