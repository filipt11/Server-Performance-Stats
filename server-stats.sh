#!/bin/bash

cpu_usage(){
	echo "CPU usage:"
	/usr/bin/mpstat | awk '/all/ {printf "%.2f%\n\n",100 - $13}'
}

mem_usage(){
	echo "Memory usage:"
	/usr/bin/free -m | awk '/Mem/ {printf "free:  %d MB  %.2f%\nusage: %d MB  %.2f\n\n",$7,$7/$2*100,$3,$3/$2*100}'
}

disk_space(){
	echo "Disk space:"
	/usr/bin/df -m | awk 'NR>1 {printf "%s\nfree: %.2f GB %d%\nusage: %.2f GB %d%\n\n",$1,$4/1000,100-$5,$3/1000,$5}'

}

top_cpu(){
	echo "Top CPU processes: "
	ps -eo pid,comm,%cpu --sort=-%cpu | head -6
	printf "\n"
}

top_mem(){
	echo "Top Mem processes: "
	ps -eo pid,comm,%mem --sort=-%mem | head -6
	printf "\n"
}

main(){
	cpu_usage
	mem_usage
	disk_space
	top_cpu
	top_mem

}
main
