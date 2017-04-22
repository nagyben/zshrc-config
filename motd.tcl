#!/usr/bin/env tclsh
set var(user) 	$env(USER)

# Disk Usage
set diskusage 	[exec -- df -h | grep Lychee]
set disk(0) 	[lindex $diskusage 2]
set disk(1)	[lindex $diskusage 1]
set disk(2)	[lindex $diskusage 4]

set diskusage   [exec -- df -h | grep /dev/sdc1]
set disk(3)	[lindex $diskusage 2]
set disk(4)	[lindex $diskusage 1]
set disk(5)	[lindex $diskusage 4]

# Last Login
set lastlog 	[exec -- lastlog -u $var(user)]
set ll(0)	[lindex $lastlog 7]
set ll(1)	[lindex $lastlog 8]
set ll(2)	[lindex $lastlog 9]
set ll(3)	[lindex $lastlog 10]
set ll(4)	[lindex $lastlog 6]

# Uptime
set uptime    	[exec -- uptime -p]

# Processes
set psa		[exec ps -A h | wc -l]
set psu		[exec ps U $var(user) h | wc -l]

# Number of sessions
#set ssh		[exec who | grep pts | wc -l]

# Load averages
set loadavg	[exec -- cat /proc/loadavg]
set sysload(1)	[lindex $loadavg 0]
set sysload(5)	[lindex $loadavg 1]
set sysload(15)	[lindex $loadavg 2]

# Calculate memory
set memory	[exec -- free -m]
set mem(t)	[lindex $memory 7]
set mem(u)	[lindex $memory 8]

# CPU temp
set temperature	[exec -- sensors | grep Core | tr -d '+']
set temp(0)	[lindex $temperature 2]
set temp(1)	[lindex $temperature 11]

set head {

     ___                 _      
    / _ \ _ __ __ _  ___| | ___ 
   | | | | '__/ _` |/ __| |/ _ \ 
   | |_| | | | (_| | (__| |  __/ 
    \___/|_|  \__,_|\___|_|\___| 


}

# Print Output
puts "\033\[01;36m$head\033\[0m"
puts "  \033\[35mLast login.......:\033\[0m \033\[36m$ll(0) $ll(1) $ll(2) $ll(3) from\033\[0m \033\[33m$ll(4)\033\[0m"
puts "  \033\[35mUptime...........:\033\[0m \033\[36m$uptime"
puts "  \033\[35mSystem load......:\033\[0m \033\[36m$sysload(1) (1m) $sysload(5) (5m) $sysload(15) (15m)\033\[0m"
puts "  \033\[35mMemory (MB)......:\033\[0m \033\[36m$mem(u) / $mem(t)\033\[0m"
puts "  \033\[35mTemperature......:\033\[0m \033\[36mCPU $temp(0)\033\[0m"
puts "  \033\[35mDisk usage.......:\033\[0m \033\[36m$disk(0) / $disk(1) ($disk(2)) used on /media/ben/Lychee\033\[0m"
puts "                     \033\[36m$disk(3) / $disk(4) ($disk(5)) used on /\033\[0m"
#puts "  \033\[35mSSH logins.......:\033\[0m \033\[36m$ssh\033\[0m"
puts "  \033\[35mProcesses........:\033\[0m \033\[36m$psa (total) :: $psu (yours)\033\[0m"
puts "\n\n"
