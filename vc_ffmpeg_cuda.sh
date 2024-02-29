#!/bin/bash

function _install_ffmpeg() {
	clear
	_file=""
	_package=""
	echo -e $RED"Installation of $_package ....... started"$RESET
	cd $SOURCE_DIR/
	rm -vrf ffmpeg*
	#git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
	wget https://github.com/FFmpeg/FFmpeg/archive/refs/tags/n4.4.2.tar.gz
	tar -xvzf n4.4.2.tar.gz
	cd FFmpeg-n4.4.2/
	ldconfig
	./configure --prefix=$INSTALL_DIR \
	--pkg-config-flags="--static" \
	--extra-libs=-lpthread \
	--enable-gpl --enable-shared --enable-nonfree \
	--enable-cuda --enable-cuvid --enable-nvenc --enable-libnpp \
	--enable-pthreads  --enable-libopencore-amrnb --enable-libopencore-amrwb \
	--enable-libmp3lame --enable-libvpx --enable-libfdk-aac --enable-libfreetype \
	--enable-libtheora --enable-libvorbis  --enable-libx264 --enable-libx265 --enable-libxvid \
	--enable-postproc --enable-swscale --enable-avfilter --enable-libass --enable-runtime-cpudetect \
	--extra-cflags=-I/usr/local/ffmpegtoolkit/include/ --extra-ldflags=-L/usr/local/ffmpegtoolkit/lib \
	--extra-cflags="-I/usr/local/ffmpegtoolkit/include/ -I/usr/local/cuda/include" --extra-ldflags="-L/usr/local/ffmpegtoolkit/lib -L/usr/local/cuda/lib64" \
	--enable-version3
	make -j $cpu
	make tools/qt-faststart
	make install
	cp -vf tools/qt-faststart /usr/local/ffmpegtoolkit/bin/

	echo -e $RED"Installation of $_package ....... Completed"$RESET
	cd $SOURCE_DIR/
}

_install_ffmpeg
