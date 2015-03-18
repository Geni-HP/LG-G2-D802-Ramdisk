#!/sbin/busybox sh

BB=/sbin/busybox

SYSTEM=$($BB blkid /dev/block/platform/msm_sdcc.1/by-name/system | $BB grep "f2fs" | $BB wc -l);
DATA=$($BB blkid /dev/block/platform/msm_sdcc.1/by-name/userdata | $BB grep "f2fs" | $BB wc -l);

SYSTEM_TYPE=0;
DATA_TYPE=0;

if [ "$SYSTEM" -eq "1" ]; then
	$BB mount -t f2fs -o rw /dev/block/platform/msm_sdcc.1/by-name/system /system;
	SYSTEM_TYPE=1;
fi;
if [ "$DATA" -eq "1" ]; then
	$BB mount -t f2fs -o rw,nosuid,nodev /dev/block/platform/msm_sdcc.1/by-name/userdata /data;
	DATA_TYPE=1;
fi;

$BB mount -o remount,rw /;

if [ "$SYSTEM_TYPE" -eq "1" ] && [ "$DATA_TYPE" -eq "1" ]; then
	$BB cp -p /sbin/fstab_mount/fstab_data_system.g2 /fstab.g2;
elif [ "$SYSTEM_TYPE" -eq "1" ] && [ "$DATA_TYPE" -eq "0" ]; then
	$BB cp -p /sbin/fstab_mount/fstab_system.g2 /fstab.g2;
elif [ "$SYSTEM_TYPE" -eq "0" ] && [ "$DATA_TYPE" -eq "1" ]; then
	$BB cp -p /sbin/fstab_mount/fstab_data.g2 /fstab.g2;
fi;

