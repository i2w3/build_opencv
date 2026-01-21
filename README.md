# what is this
用于从源码编译 **OpenCV** 的构建项目。官方提供的 `pip install opencv-python` 通常不包含 CUDA 支持，且 GStreamer 功能有限。注意 Windows 端编译 Opencv 时，会使用预编译好的 FFMPEG，但是 Linux 端则不会。

已知问题：
- [ ] OpenCV 4.12.0 与 FFMPEG>8.0 不兼容，可修改 mamba 命令为 ffmpeg=7.1.1

编译通过：
- [x] OpenCV 4.12.0 on Windows
- [x] OpenCV 4.13.0 on Linux

# how to use
根据平台查看 `configure.ps1/.sh` 中的代码，默认安装的是 `python3.12 + opencv-4.12.0/4.13.0`，下载 [Video_Codec_SDK_*.zip](https://developer.nvidia.com/video-codec-sdk/download)等待使用，随后配置一下虚拟环境，注意编译期间要保持在终端在虚拟环境中：
```bash
mamba create -n cucv python=3.12 numpy zlib ffmpeg gstreamer gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gst-rtsp-server cuda-toolkit cudnn cuda-version=12.8 -c nvidia
mamba activate cucv
```

# configure
## Windows
0. 修改 `configure.ps1`，将路径修改为 `msvc` 的安装路径
1. 关闭 Windows 安全中心中的病毒和威胁防护
2. 解压 `Video_Codec_SDK_*.zip`，将其中的 `./Interface` 放在 `{CONDA_PREFIX}/include`、`./Lib/win/x64` 放在 `{CONDA_PREFIX}/lib`
3. 右键 `configure.ps1` 选择 `使用 PowerShell 运行` 或者在终端输入 "./configure.ps1"
4. 检查 `OpenCV modules` 中 `To be built` 的模块，再查看 [build](#build)

## Linux
1. 补充安装图形库 `mamba install gtk3` 和运行 `export PATH=${CONDA_PREFIX}/nvvm/bin:$PATH` 导入 `cicc`
2. 解压 `Video_Codec_SDK_*.zip`，将其中的 `./Interface` 放在 `{CONDA_PREFIX}/targets/x86_64-linux/include`、`./Lib/linux/stubs/x86_64` 放在 `{CONDA_PREFIX}/targets/x86_64-linux/lib`
3. 赋予脚本执行权限 `chmod +x ./configure.sh`，并在终端输入 "./configure.sh
4. 检查 `OpenCV modules` 中 `To be built` 的模块，再查看 [build](#build)

# build
```bash
cmake --build _build --parallel
cmake --install _build
```

# log
## Windows
```powershell
-- General configuration for OpenCV 4.12.0 =====================================
--   Version control:               82b1b5f-dirty
--
--   Extra modules:
--     Location (extra):            D:/code/OpenCV/opencv_contrib-4.12.0/modules
--     Version control (extra):     82b1b5f-dirty
--
--   Platform:
--     Timestamp:                   2026-01-16T07:30:03Z
--     Host:                        Windows 10.0.26200 AMD64
--     CMake:                       4.1.0
--     CMake generator:             Ninja
--     CMake build tool:            C:/Softwares/ninja/ninja.exe
--     MSVC:                        1944
--     Configuration:               Release
--     Algorithm Hint:              ALGO_HINT_ACCURATE
--
--   CPU/HW features:
--     Baseline:                    SSE SSE2 SSE3
--       requested:                 SSE3
--     Dispatched code generation:  SSE4_1 SSE4_2 AVX FP16 AVX2 AVX512_SKX
--       SSE4_1 (17 files):         + SSSE3 SSE4_1
--       SSE4_2 (1 files):          + SSSE3 SSE4_1 POPCNT SSE4_2
--       AVX (9 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX
--       FP16 (0 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16
--       AVX2 (37 files):           + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3
--       AVX512_SKX (6 files):      + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3 AVX_512F AVX512_COMMON AVX512_SKX
--
--   C/C++:
--     Built as dynamic libs?:      YES
--     C++ standard:                11
--     C++ Compiler:                C:/Softwares/Microsoft/Visual Studio/2022/BuildTools/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe  (ver 19.44.35222.0)
--     C++ flags (Release):         -IC:/Softwares/miniforge3/envs/cucv/Library/include/targets/x64  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /O2 /Ob2 /DNDEBUG
--     C++ flags (Debug):           -IC:/Softwares/miniforge3/envs/cucv/Library/include/targets/x64  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /Zi /Ob0 /Od /RTC1
--     C Compiler:                  C:/Softwares/Microsoft/Visual Studio/2022/BuildTools/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe
--     C flags (Release):           /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS      /O2 /Ob2 /DNDEBUG
--     C flags (Debug):             /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /Zi /Ob0 /Od /RTC1
--     Linker flags (Release):      /machine:x64  /INCREMENTAL:NO
--     Linker flags (Debug):        /machine:x64  /debug /INCREMENTAL
--     ccache:                      NO
--     Precompiled headers:         NO
--     Extra dependencies:          cudart_static.lib nppc.lib nppial.lib nppicc.lib nppidei.lib nppif.lib nppig.lib nppim.lib nppist.lib nppisu.lib nppitc.lib npps.lib cublas.lib cudnn.lib cufft.lib -LIBPATH:"C:/Softwares/miniforge3/envs/cucv/Library/lib"
--     3rdparty dependencies:
--
--   OpenCV modules:
--     To be built:                 aruco bgsegm bioinspired calib3d ccalib core cudaarithm cudabgsegm cudacodec cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping cudev datasets dnn dnn_objdetect dnn_superres dpm face features2d flann fuzzy gapi hfs highgui img_hash imgcodecs imgproc intensity_transform line_descriptor mcc ml objdetect optflow phase_unwrapping photo plot python3 quality rapid reg rgbd saliency shape signal stereo stitching structured_light superres surface_matching text tracking video videoio videostab wechat_qrcode xfeatures2d ximgproc xobjdetect xphoto
--     Disabled:                    world
--     Disabled by dependency:      -
--     Unavailable:                 alphamat cannops cvv fastcv freetype hdf java julia matlab ovis python2 sfm ts viz
--     Applications:                apps
--     Documentation:               NO
--     Non-free algorithms:         YES
--
--   Windows RT support:            NO
--
--   GUI:                           WIN32UI
--     Win32 UI:                    YES
--     VTK support:                 NO
--
--   Media I/O:
--     ZLib:                        build (ver 1.3.1)
--     JPEG:                        build-libjpeg-turbo (ver 3.1.0-70)
--       SIMD Support Request:      YES
--       SIMD Support:              NO
--     WEBP:                        build (ver decoder: 0x0209, encoder: 0x020f, demux: 0x0107)
--     AVIF:                        NO
--     PNG:                         build (ver 1.6.43)
--       SIMD Support Request:      YES
--       SIMD Support:              YES (Intel SSE)
--     TIFF:                        build (ver 42 - 4.6.0)
--     JPEG 2000:                   build (ver 2.5.3)
--     OpenEXR:                     build (ver 2.3.0)
--     GIF:                         YES
--     HDR:                         YES
--     SUNRASTER:                   YES
--     PXM:                         YES
--     PFM:                         YES
--
--   Video I/O:
--     FFMPEG:                      YES (prebuilt binaries)
--       avcodec:                   YES (58.134.100)
--       avformat:                  YES (58.76.100)
--       avutil:                    YES (56.70.100)
--       swscale:                   YES (5.9.100)
--       avresample:                YES (4.0.0)
--     GStreamer:                   YES (1.26.10)
--     DirectShow:                  YES
--     Media Foundation:            YES
--       DXVA:                      YES
--
--   Parallel framework:            Concurrency
--
--   Trace:                         YES (with Intel ITT(3.25.4))
--
--   Other third-party libraries:
--     Intel IPP:                   2022.1.0 [2022.1.0]
--            at:                   D:/code/OpenCV/opencv-4.12.0/_build/3rdparty/ippicv/ippicv_win/icv
--     Intel IPP IW:                sources (2022.1.0)
--               at:                D:/code/OpenCV/opencv-4.12.0/_build/3rdparty/ippicv/ippicv_win/iw
--     Lapack:                      NO
--     Eigen:                       NO
--     Custom HAL:                  YES (ipp (ver 0.0.1))
--     Protobuf:                    build (3.19.1)
--     Flatbuffers:                 builtin/3rdparty (23.5.9)
--
--   NVIDIA CUDA:                   YES (ver 12.8, CUFFT CUBLAS NVCUVID NVCUVENC)
--     NVIDIA GPU arch:             50 52 60 61 70 75 80 86 89 90 100 120
--     NVIDIA PTX archs:            120
--
--   cuDNN:                         YES (ver 9.14.0)
--
--   OpenCL:                        YES (NVD3D11)
--     Include path:                D:/code/OpenCV/opencv-4.12.0/3rdparty/include/opencl/1.2
--     Link libraries:              Dynamic load
--
--   Python 3:
--     Interpreter:                 C:/Softwares/miniforge3/envs/cucv/python.exe (ver 3.12.12)
--     Libraries:                   C:/Softwares/miniforge3/envs/cucv/libs/python312.lib (ver 3.12.12)
--     Limited API:                 NO
--     numpy:                       C:/Softwares/miniforge3/envs/cucv/Lib/site-packages/numpy/_core/include (ver 2.4.1)
--     install path:                C:/Softwares/miniforge3/envs/cucv/Lib/site-packages/cv2/python-3.12        
--
--   Python (for build):            C:/Softwares/miniforge3/envs/cucv/python.exe
--
--   Java:
--     ant:                         NO
--     Java:                        NO
--     JNI:                         NO
--     Java wrappers:               NO
--     Java tests:                  NO
--
--   Install to:                    C:/Softwares/miniforge3/envs/cucv/Library
-- -----------------------------------------------------------------
--
-- Configuring done (56.4s)
-- Generating done (2.9s)
-- Build files have been written to: D:/code/OpenCV/opencv-4.12.0/_build
```

## Linux
```bash
-- General configuration for OpenCV 4.13.0 =====================================
--   Version control:               dbddaec-dirty
-- 
--   Extra modules:
--     Location (extra):            /home/tuf/codes/build_opencv/opencv_contrib-4.13.0/modules
--     Version control (extra):     dbddaec-dirty
-- 
--   Platform:
--     Timestamp:                   2026-01-21T09:41:12Z
--     Host:                        Linux 6.6.87.2-microsoft-standard-WSL2 x86_64
--     CMake:                       3.31.6
--     CMake generator:             Ninja
--     CMake build tool:            /usr/bin/ninja
--     Configuration:               Release
--     Algorithm Hint:              ALGO_HINT_ACCURATE
-- 
--   CPU/HW features:
--     Baseline:                    SSE SSE2 SSE3
--       requested:                 SSE3
--     Dispatched code generation:  SSE4_1 SSE4_2 AVX FP16 AVX2 AVX512_SKX
--       SSE4_1 (17 files):         + SSSE3 SSE4_1
--       SSE4_2 (1 files):          + SSSE3 SSE4_1 POPCNT SSE4_2
--       AVX (9 files):             + SSSE3 SSE4_1 POPCNT SSE4_2 AVX
--       FP16 (0 files):            + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16
--       AVX2 (37 files):           + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3
--       AVX512_SKX (7 files):      + SSSE3 SSE4_1 POPCNT SSE4_2 AVX FP16 AVX2 FMA3 AVX_512F AVX512_COMMON AVX512_SKX
-- 
--   C/C++:
--     Built as dynamic libs?:      YES
--     C++ standard:                11
--     C++ Compiler:                /home/tuf/miniforge3/envs/cucv/bin/x86_64-conda-linux-gnu-c++  (ver 13.4.0)
--     C++ flags (Release):         -I/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/include   -fsigned-char -W -Wall -Wreturn-type -Wnon-virtual-dtor -Waddress -Wsequence-point -Wformat -Wformat-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Wsuggest-override -Wno-delete-non-virtual-dtor -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -O3 -DNDEBUG  -DNDEBUG
--     C++ flags (Debug):           -I/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/include   -fsigned-char -W -Wall -Wreturn-type -Wnon-virtual-dtor -Waddress -Wsequence-point -Wformat -Wformat-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Wsuggest-override -Wno-delete-non-virtual-dtor -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse3 -fvisibility=hidden -fvisibility-inlines-hidden -g  -O0 -DDEBUG -D_DEBUG
--     C Compiler:                  /home/tuf/miniforge3/envs/cucv/bin/x86_64-conda-linux-gnu-cc
--     C flags (Release):           -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/tuf/miniforge3/envs/cucv/include  -I/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/include  -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib/stubs   -fsigned-char -W -Wall -Wreturn-type -Waddress -Wsequence-point -Wformat -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse3 -fvisibility=hidden -O3 -DNDEBUG  -DNDEBUG
--     C flags (Debug):             -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/tuf/miniforge3/envs/cucv/include  -I/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/include  -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib/stubs   -fsigned-char -W -Wall -Wreturn-type -Waddress -Wsequence-point -Wformat -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Wno-comment -Wimplicit-fallthrough=3 -Wno-strict-overflow -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -msse3 -fvisibility=hidden -g  -O0 -DDEBUG -D_DEBUG
--     Linker flags (Release):      -Wl,--exclude-libs,libippicv.a -Wl,--exclude-libs,libippiw.a -Wl,-O2 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,--disable-new-dtags -Wl,--gc-sections -Wl,--allow-shlib-undefined -Wl,-rpath,/home/tuf/miniforge3/envs/cucv/lib -Wl,-rpath-link,/home/tuf/miniforge3/envs/cucv/lib -L/home/tuf/miniforge3/envs/cucv/lib  -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib/stubs  -Wl,--gc-sections -Wl,--as-needed -Wl,--no-undefined  
--     Linker flags (Debug):        -Wl,--exclude-libs,libippicv.a -Wl,--exclude-libs,libippiw.a -Wl,-O2 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,--disable-new-dtags -Wl,--gc-sections -Wl,--allow-shlib-undefined -Wl,-rpath,/home/tuf/miniforge3/envs/cucv/lib -Wl,-rpath-link,/home/tuf/miniforge3/envs/cucv/lib -L/home/tuf/miniforge3/envs/cucv/lib  -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib/stubs  -Wl,--gc-sections -Wl,--as-needed -Wl,--no-undefined  
--     ccache:                      NO
--     Precompiled headers:         NO
--     Extra dependencies:          m pthread cudart_static dl rt nppc nppial nppicc nppidei nppif nppig nppim nppist nppisu nppitc npps cublas cudnn cufft -L/home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib -L/home/tuf/miniforge3/envs/cucv/x86_64-conda-linux-gnu/sysroot/usr/lib -L/home/tuf/miniforge3/envs/cucv/lib
--     3rdparty dependencies:
-- 
--   OpenCV modules:
--     To be built:                 aruco bgsegm bioinspired calib3d ccalib core cudaarithm cudabgsegm cudacodec cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping cudev datasets dnn dnn_objdetect dnn_superres dpm face features2d flann freetype fuzzy gapi hfs highgui img_hash imgcodecs imgproc intensity_transform line_descriptor mcc ml objdetect optflow phase_unwrapping photo plot python3 quality rapid reg rgbd saliency shape signal stereo stitching structured_light superres surface_matching text tracking video videoio videostab wechat_qrcode xfeatures2d ximgproc xobjdetect xphoto
--     Disabled:                    world
--     Disabled by dependency:      -
--     Unavailable:                 alphamat cannops cvv fastcv hdf java julia matlab ovis python2 sfm ts viz
--     Applications:                apps
--     Documentation:               NO
--     Non-free algorithms:         YES
-- 
--   GUI:                           NONE
--     GTK+:                        NO
--     VTK support:                 NO
-- 
--   Media I/O: 
--     ZLib:                        /home/tuf/miniforge3/envs/cucv/lib/libz.so (ver 1.3.1)
--     JPEG:                        /home/tuf/miniforge3/envs/cucv/lib/libjpeg.so (ver 80)
--     WEBP:                        /home/tuf/miniforge3/envs/cucv/lib/libwebp.so (ver decoder: 0x0210, encoder: 0x0210, demux: 0x0107)
--     AVIF:                        NO
--     PNG:                         /home/tuf/miniforge3/envs/cucv/lib/libpng.so (ver 1.6.54)
--     TIFF:                        /home/tuf/miniforge3/envs/cucv/lib/libtiff.so (ver 42 / 4.7.1)
--     JPEG 2000:                   build (ver 2.5.3)
--     OpenEXR:                     build (ver 2.3.0)
--     GIF:                         YES
--     HDR:                         YES
--     SUNRASTER:                   YES
--     PXM:                         YES
--     PFM:                         YES
-- 
--   Video I/O:
--     FFMPEG:                      YES
--       avcodec:                   YES (62.11.100)
--       avformat:                  YES (62.3.100)
--       avutil:                    YES (60.8.100)
--       swscale:                   YES (9.1.100)
--       avdevice:                  YES (62.1.100)
--     GStreamer:                   YES (1.26.10)
--     v4l/v4l2:                    YES (linux/videodev2.h)
--     Orbbec:                      YES
-- 
--   Parallel framework:            pthreads
-- 
--   Trace:                         YES (with Intel ITT(3.25.4))
-- 
--   Other third-party libraries:
--     Intel IPP:                   2022.2.0 [2022.2.0]
--            at:                   /home/tuf/codes/build_opencv/opencv-4.13.0/_build/3rdparty/ippicv/ippicv_lnx/icv
--     Intel IPP IW:                sources (2022.2.0)
--               at:                /home/tuf/codes/build_opencv/opencv-4.13.0/_build/3rdparty/ippicv/ippicv_lnx/iw
--     VA:                          YES
--     Lapack:                      NO
--     Eigen:                       NO
--     Custom HAL:                  YES (ipp (ver 0.0.1))
--     Flatbuffers:                 builtin/3rdparty (25.9.23)
-- 
--   NVIDIA CUDA:                   YES (ver 12.8, CUFFT CUBLAS NVCUVID NVCUVENC)
--     NVIDIA GPU arch:             50 52 60 61 70 75 80 86 89 90 100 120
--     NVIDIA PTX archs:            120
-- 
--   cuDNN:                         YES (ver 9.14.0)
-- 
--   OpenCL:                        YES (INTELVA)
--     Include path:                /home/tuf/codes/build_opencv/opencv-4.13.0/3rdparty/include/opencl/1.2
--     Link libraries:              Dynamic load
-- 
--   Python 3:
--     Interpreter:                 /home/tuf/miniforge3/envs/cucv/bin/python (ver 3.12.12)
--     Libraries:                   /home/tuf/miniforge3/envs/cucv/libs/libpython3.12.so
--     Limited API:                 NO
--     numpy:                       /home/tuf/miniforge3/envs/cucv/lib/python3.12/site-packages/numpy/_core/include (ver 2.4.1)
--     install path:                /home/tuf/miniforge3/envs/cucv/lib/python3.12/site-packages/cv2/python-3.12
-- 
--   Python (for build):            /home/tuf/miniforge3/envs/cucv/bin/python
-- 
--   Java:                          
--     ant:                         NO
--     Java:                        NO
--     JNI:                         NO
--     Java wrappers:               NO
--     Java tests:                  NO
-- 
--   Install to:                    /home/tuf/miniforge3/envs/cucv
-- -----------------------------------------------------------------
-- 
-- Configuring done (20.3s)
CMake Warning at cmake/OpenCVUtils.cmake:1586 (add_library):
  Cannot generate a safe runtime search path for target opencv_cudacodec
  because files in some directories may conflict with libraries in implicit
  directories:

    runtime library [libnvcuvid.so.1] in /home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib may be hidden by files in:
      /usr/lib/wsl/lib
    runtime library [libnvidia-encode.so.1] in /home/tuf/miniforge3/envs/cucv/targets/x86_64-linux/lib may be hidden by files in:
      /usr/lib/wsl/lib

  Some of these libraries may not be found correctly.
Call Stack (most recent call first):
  cmake/OpenCVModule.cmake:979 (ocv_add_library)
  cmake/OpenCVModule.cmake:905 (_ocv_create_module)
  /home/tuf/codes/build_opencv/opencv_contrib-4.13.0/modules/cudacodec/CMakeLists.txt:51 (ocv_create_module)


-- Generating done (0.8s)
-- Build files have been written to: /home/tuf/codes/build_opencv/opencv-4.13.0/_build
```