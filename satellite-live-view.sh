#!/bin/bash

cd ~/.cache/

if [ ! -d sat24-images ]; then
	mkdir sat24-images
fi
cd sat24-images

if [ ! -z $1 ]; then
	region=$1
else
	region="fr"
fi

# Time span in hours
if [ ! -z $2 ]; then
	time_span=$2
	if [ $time_span -gt 24 ]; then
		time_span=24 # Set the limit at 24h to avoid huge downloads
	fi
else
	time_span=6 # 24 images in the past: 24*15 min = 6*4*15 min = 6 hours
	# used to be 72 images in the past: 72*5 min = 6*12*5 min = 6 hours
fi
nbimax=$(( time_span * 12 ))

# HD images?
if [ $3 == "HD" ]; then
	HD=$3
else
	HD=""
fi

cur_date=$(date -u +%Y%m%d) # UTC
cur_hour=$(date -u +%-H) # UTC without zeros filling
cur_min=$(date +%-M) # without zeros filling

# Start from 00, 15, 30, 45 # used to be 00, 05, 10, 15, 20, 25, ...
while (( $cur_min % 15 ))
do
	cur_min=$(( cur_min - 1 ))
done

nbi=0

# Get $nbimax images in the past
while [ $nbi -lt $nbimax ]
do
	# We cross midnight UTC
	if [ $cur_hour -lt 0 ]; then
		cur_hour=23
		cur_date=$(date -d "$cur_date - 1 day" -u +%Y%m%d)
	fi

	while [ $cur_min -ge 0 ]
	do
		cur_time=$(printf '%s%02d%02d' "$cur_date" "$cur_hour" "$cur_min")
		filename="sat-$cur_time-$region.jpg"
		#echo $cur_time
		if [ ! -e $filename ]; then
			#wget "http://www.sat24.com/image2.ashx?region=$region&time=$cur_time&type=sat5min&ir=false" -O .sat-$cur_time-$region.jpg
			#echo $filename
			wget "https://fr.sat24.com/image?type=visual5${HD}Complete&region=$region&timestamp=$cur_time&ir=false" -O $filename
			# Check the file size
			actualsize=$(wc -c < $filename)
			#if [ -s $filename ]; then
			if [ $actualsize -ge 8092 ]; then
				# Give the correct date to the file
				touch_time=$(printf '%s %02d%02d' "$cur_date" "$cur_hour" "$cur_min")
				touch_time=$(date -d "$touch_time UTC" +"%Y%m%d %H%M")
				touch --date "$touch_time" $filename
			else
				# Empty file: no picture was downloaded
				rm -f $filename
			fi
		fi
		cur_min=$(( cur_min - 15 )) # used to be every 5 minutes
		nbi=$(( nbi+1 ))
		if [ $nbi -ge $nbimax ]; then
			break
		fi
	done
	cur_min=45 # used to be 55
	cur_hour=$(( cur_hour - 1 ))
done

# Only delete images older than XXh
duration_min=$(( nbimax * 5 ))
find sat-*-$region.jpg -mmin +$duration_min -exec rm -f {} \;

# convert -delay 10 -loop 0 sat-*-$region.jpg sat-now-animated.gif
# Image delay in 1e-3 seconds
if [ ! -z $4 ]; then
	frame_length=$4
else
	frame_length=20
fi
animate -delay $frame_length sat-*-$region.jpg
