# 设置代理
export HTTP_PROXY='http://127.0.0.1:7890'
export HTTPS_PROXY='http://127.0.0.1:7890'

# 定义 opencv 版本
opencv_version="4.12.0"
wget https://github.com/opencv/opencv/archive/$opencv_version.zip -O opencv-$opencv_version.zip
wget https://github.com/opencv/opencv_contrib/archive/$opencv_version.zip -O opencv_contrib-$opencv_version.zip

# 定义 python 路径
python_path=${CONDA_PATH}
