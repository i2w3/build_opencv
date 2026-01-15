# what is this
用于从源码编译 **OpenCV 4.12.0** 的构建项目。官方提供的 `pip install opencv-python` 通常不包含 CUDA 支持，且 GStreamer 功能有限。

# how to use
根据平台查看 `configure.ps1/.sh` 中的代码，默认安装的是 `opencv-4.12.0`，默认已下载 [Video_Codec_SDK_*.zip](https://developer.nvidia.com/video-codec-sdk/download)，随后配置一下虚拟环境，注意编译期间要保持在终端在虚拟环境中：
```bash
mamba create -n cucv python=3.12 numpy gstreamer gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gst-rtsp-server
mamba activate cucv
```

# configure
## Windows
0. 修改 `configure.ps1`，将路径修改为 `msvc` 的安装路径
1. 关闭 Windows 安全中心中的病毒和威胁防护
2. 解压 `Video_Codec_SDK_*.zip`，将其中的 `./Interface` 放在 `{CUDA_HOME}/include`、`./Lib/win` 放在 `{CUDA_HOME}/lib`
3. 右键 `configure.ps1` 选择 `使用 PowerShell 运行` 或者在终端输入 "./configure.ps1"
4. 检查 `OpenCV modules` 中 `To be built` 的模块，再查看 [build](#build)
```powershell
-- General configuration for OpenCV 4.12.0 =====================================
--   Version control:               unknown
--
--   Extra modules:
--     Location (extra):            D:/code/OpenCV/opencv_contrib-4.12.0/modules
--     Version control (extra):     unknown
--
--   Platform:
--     Timestamp:                   2026-01-13T06:31:18Z
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
--     C++ flags (Release):         /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /O2 /Ob2 /DNDEBUG
--     C++ flags (Debug):           /DWIN32 /D_WINDOWS /W4 /GR  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /EHa /wd4127 /wd4251 /wd4324 /wd4275 /wd4512 /wd4589 /wd4819  /Zi /Ob0 /Od /RTC1
--     C Compiler:                  C:/Softwares/Microsoft/Visual Studio/2022/BuildTools/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe
--     C flags (Release):           /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS      /O2 /Ob2 /DNDEBUG
--     C flags (Debug):             /DWIN32 /D_WINDOWS /W3  /D _CRT_SECURE_NO_DEPRECATE /D _CRT_NONSTDC_NO_DEPRECATE /D _SCL_SECURE_NO_WARNINGS /Gy /bigobj /Oi  /fp:precise /FS    /Zi /Ob0 /Od /RTC1
--     Linker flags (Release):      /machine:x64  /INCREMENTAL:NO
--     Linker flags (Debug):        /machine:x64  /debug /INCREMENTAL
--     ccache:                      NO
--     Precompiled headers:         NO
--     Extra dependencies:          cudart_static.lib nppc.lib nppial.lib nppicc.lib nppidei.lib nppif.lib nppig.lib nppim.lib nppist.lib nppisu.lib nppitc.lib npps.lib cublas.lib cudnn.lib cufft.lib -LIBPATH:"C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.8/lib/x64"
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
--   cuDNN:                         YES (ver 9.8.0)
--
--   OpenCL:                        YES (NVD3D11)
--     Include path:                D:/code/OpenCV/opencv-4.12.0/3rdparty/include/opencl/1.2
--     Link libraries:              Dynamic load
--
--   Python 3:
--     Interpreter:                 C:\Softwares\miniforge3\envs\cucv/python.exe (ver 3.12.12)
--     Libraries:                   C:/Softwares/miniforge3/envs/cucv/libs/python312.lib (ver 3.12.12)
--     Limited API:                 NO
--     numpy:                       C:\Softwares\miniforge3\envs\cucv/Lib/site-packages/numpy/_core/include (ver 2.4.1)       
--     install path:                C:\Softwares\miniforge3\envs\cucv/Lib/site-packages/cv2/python-3.12
--
--   Python (for build):            C:\Softwares\miniforge3\envs\cucv/python.exe
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
-- Configuring done (13.4s)
-- Generating done (2.9s)
-- Build files have been written to: D:/code/OpenCV/opencv-4.12.0/_build
```

## Linux
TOOD

# build
```bash
cmake --build _build --parallel
cmake --install _build
```