A hack to extract a gauge reading using image recognition
=======

FIXME
-----
- This code is an ugly mish-mash of C and C++ styles -- sorry...
- Direct reading from video device is not tested/working
  - seems to be a bug in the current RHEL6 kernel (2.6.32-279.22.1.el6) that is interfering with this...  Allegedly CentOS kernel > 2.6.32-504 has it fixed...

FOR USE WITH MUNIN
-----
NOTE:  Since direct reads from the video device don't work, the scripts below
   assume 'motion' is taking snapshots once every 20 seconds.  This leaves 15
   images that get averaged over a 5 minute period.

- 'run_gauge_extract' will run over image files at a given path and extract a median psi reading on both gauges
   - NOTE:  If '--unlink' is passed, then the image files are deleted.

- 'run_gauge_extract' runs in the crontab:
  ```
  ## Intended for use with munin which runs at 5 minute intervals.  We
  ## want to extract gauge information and have the file ready for the
  ## next munin run so we will run at :04, :09... to leave time for th
  ## extraction routine to complete.
  0-59/5 * * * * sleep 4m; /home/coda/motion/gauge_extract/run_gauge_extract --unlink
  ```

- 'gauge_read.munin' gets a symlink in /etc/munin/plugins
  - NOTE: Edit the filename from which extracts data
    GF="/home/coda/motion/gauge_extract/pressure.out"


INSTALLATION
-----
- Requires libconfig-devel
- Requires opencv 2.4.x
  - http://opencv.org/

- Installation under CentOS 6.2 based on https://gist.github.com/mitmul/9253702
```
yum --enablerepo=epel --enablerepo=rpmforge install  libv4l-devel \
  v4l-utils-devel-tools libv4l gcc g++ gtk+-devel gtk+extra-devel \
  libjpeg-devel libtiff-devel jasper-devel libpng-devel zlib-devel \
  cmake unzip

wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.11/opencv-2.4.11.zip/download
mv download opencv-2.4.11.zip
unzip opencv-2.4.11.zip
mkdir build
cd build
cmake  \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_DOCS=OFF  \
  -DBUILD_EXAMPLES=OFF  \
  -DBUILD_JPEG=OFF\
  -DBUILD_OPENEXR=OFF  \
  -DBUILD_PACKAGE=OFF  \
  -DBUILD_PERF_TESTS=OFF\
  -DBUILD_PNG=OFF  \
  -DBUILD_TBB=OFF  \
  -DBUILD_TESTS=OFF  \
  -DBUILD_TIFF=OFF\
  -DBUILD_WITH_DEBUG_INFO=OFF  \
  -DBUILD_ZLIB=OFF  \
  -DWITH_1394=ON  \
  -DWITH_EIGEN=ON\
  -DWITH_FFMPEG=ON  \
  -DWITH_GIGEAPI=ON  \
  -DWITH_GSTREAMER=ON  \
  -DWITH_GTK=ON\
  -DWITH_IPP=OFF  \
  -DWITH_JASPER=ON  \
  -DWITH_JPEG=ON  \
  -DWITH_LIBV4L=ON\
  -DWITH_OPENCL=OFF  \
  -DWITH_OPENCLAMDBLAS=OFF  \
  -DWITH_OPENCLAMDFFT=OFF\
  -DWITH_OPENEXR=OFF  \
  -DWITH_OPENGL=ON  \
  -DWITH_OPENMP=OFF  \
  -DWITH_OPENNI=OFF\
  -DWITH_PNG=ON  \
  -DWITH_PVAPI=OFF  \
  -DWITH_QT=ON  \
  -DWITH_TBB=OFF  \
  -DWITH_TIFF=ON\
  -DWITH_UNICAP=OFF  \
  -DWITH_V4L=ON  \
  -DWITH_XIMEA=OFF  \
  -DWITH_XINE=OFF\
   -Wno-dev\
   ../

make -j4
sudo make install
```
