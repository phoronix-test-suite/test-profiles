#!/bin/sh

tar -xJf MPlayer-1.1.1.tar.xz

mkdir $HOME/mplayer_

cd MPlayer-1.1.1

if [ -f "/usr/include/vdpau/vdpau.h" ]
then
	VDPAU_STATUS="--enable-vdpau"
else
	VDPAU_STATUS="--disable-vdpau"
fi

if [ -f "/usr/include/va/va.h" ]
then
	VAAPI_STATUS="--enable-vaapi"
else
	VAAPI_STATUS="--disable-vaapi"
fi

./configure --enable-xv --enable-xvmc $VAAPI_STATUS $VDPAU_STATUS --disable-ivtv --prefix=$HOME/mplayer_

case $OS_TYPE in
	BSD|Solaris)
		gmake -j $NUM_CPU_JOBS
		gmake install
	;;
	*)
		make -j $NUM_CPU_JOBS
		make install
	;;
esac

cd ~

rm -rf MPlayer-1.1.1
rm -rf mplayer_/share/

ln -s mplayer_/bin/mplayer mplayer
ln -s mplayer_/bin/mencoder mencoder
