# 激活 msvc
& 'C:/Softwares/Microsoft/Visual Studio/2022/BuildTools/Common7/Tools/Launch-VsDevShell.ps1' -Arch amd64 -HostArch amd64 -SkipAutomaticLocation

# UTF-8 编码
chcp 65001 > $null

# 设置代理
$env:HTTP_PROXY='http://127.0.0.1:7890'
$env:HTTPS_PROXY='http://127.0.0.1:7890'

# 定义 opencv 版本
$opencv_version = "4.12.0"
if (-not (Test-Path "opencv-$opencv_version.zip")) {
    Write-Host "Downloading OpenCV-$opencv_version..."
    wget https://gh-proxy.org/https://github.com/opencv/opencv/archive/$opencv_version.zip -OutFile opencv-$opencv_version.zip
}

if (-not (Test-Path "opencv_contrib-$opencv_version.zip")) {
    Write-Host "Downloading OpenCV Contrib-$opencv_version..."
    wget https://gh-proxy.org/https://github.com/opencv/opencv_contrib/archive/$opencv_version.zip -OutFile opencv_contrib-$opencv_version.zip
}

# 定义 python 路径
$python_path = $Env:CONDA_PREFIX
$install_path = $Env:CONDA_PREFIX

# 解压
Expand-Archive -Path "opencv-$opencv_version.zip" -DestinationPath . -Force
Expand-Archive -Path "opencv_contrib-$opencv_version.zip" -DestinationPath . -Force

# 配置 cmake
cd opencv-$opencv_version
cmake -S . -G Ninja -B "_build" `
      -DCMAKE_INSTALL_PREFIX="$install_path/Library" `
      -DCMAKE_BUILD_TYPE=Release `
      -DWITH_CUDA=ON `
      -DWITH_CUDNN=ON `
      -DWITH_CUBLAS=ON `
      -DOPENCV_DNN_CUDA=ON `
      -DOPENCV_EXTRA_MODULES_PATH="../opencv_contrib-$opencv_version/modules" `
      -DOPENCV_ENABLE_NONFREE=ON `
      -DWITH_GSTREAMER=ON `
      -DBUILD_opencv_python2=OFF `
      -DBUILD_opencv_python3=ON `
      -DBUILD_opencv_python_bindings_generator=ON `
      -DBUILD_PYTHON3_VERSION=ON `
      -DBUILD_FORCE_PYTHON_LIBS=ON `
      -DPYTHON3_INCLUDE_DIR="$python_path/include" `
      -DPYTHON3_LIBRARY="$python_path/libs/python312.lib" `
      -DPYTHON3_EXECUTABLE="$python_path/python.exe" `
      -DPYTHON3_NUMPY_INCLUDE_DIRS="$python_path/Lib/site-packages/numpy/_core/include" `
      -DPYTHON3_PACKAGES_PATH="$python_path/Lib/site-packages" `
      -DBUILD_TESTS=OFF `
      -DBUILD_PERF_TESTS=OFF `
      -DBUILD_EXAMPLES=OFF