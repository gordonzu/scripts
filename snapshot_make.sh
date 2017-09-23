#!/bin/bash

# /root/snapshot_make.sh

unset PATH	
ID=/usr/bin/id;
ECHO=/bin/echo;
MOUNT=/bin/mount;
RM=/bin/rm;
MV=/bin/mv;
CP=/bin/cp;
TOUCH=/bin/touch;

RSYNC=/usr/bin/rsync;
MOUNT_DEVICE=/dev/sdb1;
SNAPSHOT_RW=/media/gordonzu/DATA;
USB=/media/gordonzu/17E9-E0B5;
MEGA=/home/gordonzu/MEGA/snapshot;
EXCLUDES=/usr/local/etc/backup_exclude;

$MOUNT -o remount,rw $MOUNT_DEVICE $SNAPSHOT_RW ;
if (( $? )); then
{
	$ECHO "snapshot: could not remount $SNAPSHOT_RW readwrite";
	exit;
}
fi;

if [ -d $SNAPSHOT_RW/snapshot/home/hourly.3 ] ; then			\
$RM -rf $SNAPSHOT_RW/snapshot/home/hourly.3 ;				\
fi ;

if [ -d $SNAPSHOT_RW/snapshot/home/hourly.2 ] ; then			\
$MV $SNAPSHOT_RW/snapshot/home/hourly.2 $SNAPSHOT_RW/home/hourly.3 ;	\
fi;

if [ -d $SNAPSHOT_RW/snapshot/home/hourly.1 ] ; then			\
$MV $SNAPSHOT_RW/snapshot/home/hourly.1 $SNAPSHOT_RW/home/hourly.2 ;	\
fi;

if [ -d $SNAPSHOT_RW/snapshot/home/hourly.0 ] ; then			\
$CP -al $SNAPSHOT_RW/snapshot/home/hourly.0 $SNAPSHOT_RW/home/hourly.1 ;	\
fi;

$RSYNC								\
	-av --delete --delete-excluded				\
	--exclude-from="$EXCLUDES"				\
	/home $SNAPSHOT_RW/snapshot/home/hourly.0 ;

$TOUCH $SNAPSHOT_RW/snapshot/home/hourly.0 ;
$RSYNC								\
	-av --delete --delete-excluded				\
	$SNAPSHOT_RW/snapshot/home/hourly.0 $MEGA/.;
	$SNAPSHOT_RW/snapshot/home/hourly.0 $USB/.;

$MOUNT -o remount,ro $MOUNT_DEVICE $SNAPSHOT_RW ;
if (( $? )); then
{
	$ECHO "snapshot: could not remount $SNAPSHOT_RW readonly";
	exit;
} fi;

