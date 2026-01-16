# 激活 msvc
& 'C:/Softwares/Microsoft/Visual Studio/2022/BuildTools/Common7/Tools/Launch-VsDevShell.ps1' -Arch amd64 -HostArch amd64 -SkipAutomaticLocation

# UTF-8 编码
chcp 65001 > $null

# 定义 opencv 版本
$OPENCV_VERSION = "4.12.0"

# 设置代理
$env:HTTP_PROXY = "http://127.0.0.1:7890"
$env:HTTPS_PROXY = "http://127.0.0.1:7890"
# 设置 CUDA、CUDNN 路径
$env:CUDA_HOME = ($Env:CONDA_PREFIX).Replace('\', '/') + "/Library"
$env:CUDA_PATH = ($Env:CONDA_PREFIX).Replace('\', '/') + "/Library"
# 设置 python 路径
$PYTHON_PATH = ($Env:CONDA_PREFIX).Replace('\', '/')
$INSTALL_PATH = ($Env:CONDA_PREFIX).Replace('\', '/')

# 下载 opencv 和 opencv_contrib
if (-not (Test-Path "opencv-$OPENCV_VERSION.zip")) {
    Write-Host "Downloading OpenCV-$OPENCV_VERSION..."
    wget https://gh-proxy.org/https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -OutFile opencv-$OPENCV_VERSION.zip
}
if (-not (Test-Path "opencv_contrib-$OPENCV_VERSION.zip")) {
    Write-Host "Downloading OpenCV Contrib-$OPENCV_VERSION..."
    wget https://gh-proxy.org/https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -OutFile opencv_contrib-$OPENCV_VERSION.zip
}

# 解压 opencv 和 opencv_contrib
if (-not (Test-Path "opencv_contrib-$OPENCV_VERSION")) {
    Expand-Archive -Path "opencv-$OPENCV_VERSION.zip" -DestinationPath .
}
if (-not (Test-Path "opencv_contrib-$OPENCV_VERSION")) {
    Expand-Archive -Path "opencv_contrib-$OPENCV_VERSION.zip" -DestinationPath .
}

# 配置 cmake
cd opencv-$OPENCV_VERSION
cmake -S . -G Ninja -B "_build" `
      -DCMAKE_INSTALL_PREFIX="$INSTALL_PATH/Library" `
      -DCMAKE_CXX_FLAGS="-I$INSTALL_PATH/Library/include/targets/x64" ` # “nv/target”
      -DCMAKE_CUDA_FLAGS="-I$INSTALL_PATH/Library/include/targets/x64" `
      -DCMAKE_BUILD_TYPE=Release `
      -DWITH_CUDA=ON `
      -DWITH_CUDNN=ON `
      -DWITH_CUBLAS=ON `
      -DOPENCV_DNN_CUDA=ON `
      -DOPENCV_EXTRA_MODULES_PATH="../opencv_contrib-$OPENCV_VERSION/modules" `
      -DOPENCV_ENABLE_NONFREE=ON `
      -DWITH_GSTREAMER=ON `
      -DBUILD_opencv_python2=OFF `
      -DBUILD_opencv_python3=ON `
      -DBUILD_opencv_python_bindings_generator=ON `
      -DBUILD_PYTHON3_VERSION=ON `
      -DBUILD_FORCE_PYTHON_LIBS=ON `
      -DPYTHON3_INCLUDE_DIR="$PYTHON_PATH/include" `
      -DPYTHON3_LIBRARY="$PYTHON_PATH/libs/python312.lib" `
      -DPYTHON3_EXECUTABLE="$PYTHON_PATH/python.exe" `
      -DPYTHON3_NUMPY_INCLUDE_DIRS="$PYTHON_PATH/Lib/site-packages/numpy/_core/include" `
      -DPYTHON3_PACKAGES_PATH="$PYTHON_PATH/Lib/site-packages" `
      -DBUILD_TESTS=OFF `
      -DBUILD_PERF_TESTS=OFF `
      -DBUILD_EXAMPLES=OFF