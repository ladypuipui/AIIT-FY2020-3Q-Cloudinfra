#!/bin/bash
HOSTCPU=`virsh nodeinfo | grep -i cpu\(s\) |awk '{print $2}'`
HOSTMEM=`virsh nodeinfo | grep -i "Memory size\:" |awk '{print $3} '`
GUESTCPU=`virsh list | awk 'NR>2 && $1!="" {print $2}' | xargs -n 1 virsh vcpucount | awk 'NR%5==1 {sum += $3} END {print sum}'`
GUESTMEM=`virsh list | awk 'NR>2 && $1!="" {print $2}' | xargs -n 1 virsh dommemstat  | awk 'NR%5==1 {sum += $2} END {print sum}'`
CPURESULT=`echo $(( $HOSTCPU - $GUESTCPU ))`
MEMRESULT=`echo $(( $HOSTMEM - $GUESTMEM ))`

if [ $CPURESULT -lt 1 ]; then
 VMCREATE=`echo 0`
 echo "No vCPU available" >> error.log
 exit1
 
 elif [ $MEMRESULT -lt 1048576 ]; then
 echo "No MEM available" >> error.log
 VMCREATE=`echo 0`
 exit1

 else
 VMCREATE=`echo 1`
 
fi

echo $VMCREATE
