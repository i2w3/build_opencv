if [ -z "$CONDA_PREFIX" ]; then
    echo "Error: Please activate your conda environment first."
    exit 1
fi

# 定义 opencv 版本
OPENCV_VERSION="4.12.0"

# 设置代理
export HTTP_PROXY='http://127.0.0.1:7890'
export HTTPS_PROXY='http://127.0.0.1:7890'
# 设置 CUDA、CUDNN 路径
export CUDA_HOME=${CONDA_PREFIX}
export CUDA_PATH=${CONDA_PREFIX}
# 设置 python 路径
PYTHON_PATH=${CONDA_PREFIX}
INSTALL_PATH=${CONDA_PREFIX}

# 下载 opencv 和 opencv_contrib
if [ ! -d "opencv-$OPENCV_VERSION" ]; then
     wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv-$OPENCV_VERSION.zip
fi
if [ ! -d "opencv_contrib-$OPENCV_VERSION" ]; then
     wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib-$OPENCV_VERSION.zip
fi

# 解压 opencv 和 opencv_contrib
if [ ! -d "opencv-$OPENCV_VERSION" ]; then
    unzip opencv-$OPENCV_VERSION.zip
fi
if [ ! -d "opencv_contrib-$OPENCV_VERSION" ]; then
    unzip opencv_contrib-$OPENCV_VERSION.zip
fi

# 配置 cmake
cd opencv-$OPENCV_VERSION
cmake -S . -G Ninja -B "_build" \
      -DCMAKE_INSTALL_PREFIX="$INSTALL_PATH" \
      -DCMAKE_CXX_FLAGS="-I$INSTALL_PATH/targets/x86_64-linux/include" \
      -DCMAKE_CUDA_FLAGS="-I$INSTALL_PATH/targets/x86_64-linux/include" \
      -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CUDA=ON \
      -DWITH_CUDNN=ON \
      -DWITH_CUBLAS=ON \
      -DCUDA_ARCH_BIN=5.0,5.2,6.0,6.1,7.0,7.5,8.0,8.6,8.9,9.0,10.0,12.0 \
      -DCUDA_ARCH_PTX=12.0 \
      -DOPENCV_DNN_CUDA=ON \
      -DOPENCV_EXTRA_MODULES_PATH="../opencv_contrib-$OPENCV_VERSION/modules" \
      -DOPENCV_ENABLE_NONFREE=ON \
      -DWITH_GSTREAMER=ON \
      -DBUILD_opencv_python2=OFF \
      -DBUILD_opencv_python3=ON \
      -DBUILD_opencv_python_bindings_generator=ON \
      -DBUILD_PYTHON3_VERSION=ON \
      -DBUILD_FORCE_PYTHON_LIBS=ON \
      -DPYTHON3_INCLUDE_DIR="$PYTHON_PATH/include" \
      -DPYTHON3_LIBRARY="$PYTHON_PATH/libs/libpython3.12.so" \
      -DPYTHON3_EXECUTABLE="$PYTHON_PATH/bin/python" \
      -DPYTHON3_NUMPY_INCLUDE_DIRS="$PYTHON_PATH/lib/python3.12/site-packages/numpy/_core/include" \
      -DPYTHON3_PACKAGES_PATH="$PYTHON_PATH/lib/python3.12/site-packages" \
      -DBUILD_TESTS=OFF \
      -DBUILD_PERF_TESTS=OFF \
      -DBUILD_EXAMPLES=OFF