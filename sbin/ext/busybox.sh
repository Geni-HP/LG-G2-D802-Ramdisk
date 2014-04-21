#!/sbin/sh

/sbin/busybox mount -o remount,rw /system;
/sbin/busybox mount -o remount,rw /;

# installe latest busybox to ROM
cp /sbin/busybox /system/xbin/;
/system/xbin/busybox --install -s /system/xbin/
chmod 06755 /system/xbin/busybox;

/sbin/busybox sh /sbin/ext/post-init.sh;

