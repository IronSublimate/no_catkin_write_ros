# 不用catkin_make，像正常c++一样写ROS

> 侯宇轩

+ 不用catkin
+ 不用source /opt/ros/xxx/setup.bash
+ 使用CMake
+ Clion能调试
+ Clion能远程/WSL调试

直接用g++编译同理
以[官网教程:Writing a Simple Publisher and Subscriber (C++)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29)为例

## 新建工作空间(可选,同官网教程一样)

如果想按照ros的工作空间格式建项目，可以按照这个步骤

```bash
catkin init
mkdir src
cd src
catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
cd beginner_tutorials
```



## 新建/修改CMakeLists.txt（同官网教程一样）

```cmake
cmake_minimum_required(VERSION 2.8.3)
project(beginner_tutorials)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs genmsg)

## Declare a catkin package
catkin_package()

## Build talker and listener
include_directories(include ${catkin_INCLUDE_DIRS})

add_executable(talker src/talker.cpp)
target_link_libraries(talker ${catkin_LIBRARIES})

add_executable(listener src/listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})
```

## talker.cpp和listener.cpp
同教程一样，注意talker.cpp和listener.cpp的相对于CMakeLists.txt的路径和上面CMakeLists.txt中的一样

## clion设置
1. 工作空间打开clion，选择src下面的CMakeLists.txt，也就是链接到ros安装目录的CMakeLists.txt
    
2. File -> Settings -> Build, Execution, Deployment -> CMake，
    
    添加cmake option，这里ROS neotic是python3，其他的ros可能是python2，其中CMAKE_INSTALL_PREFIX和CATKIN_DEVEL_PREFIX是相对于Build directory的
    
   ```bash
   -DPYTHON_EXECUTABLE=/usr/bin/python3 -DCMAKE_INSTALL_PREFIX=../install -DCATKIN_DEVEL_PREFIX=../devel
   ```
   
   修改env.sh中ros的路径，运行env.sh，将输出添加Environment，注意是python3还是python2
   
   ```shell
   ROS_VERSION=1;
   PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig;
   ROS_PYTHON_VERSION=3;ROS_PACKAGE_PATH=/opt/ros/noetic/share;
   ROSLISP_PACKAGE_DIRECTORIES=;
   ROS_ETC_DIR=/opt/ros/noetic/etc/ros;
   CMAKE_PREFIX_PATH=/opt/ros/noetic;
   PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages;
   ROS_MASTER_URI=http://localhost:11311;
   LD_LIBRARY_PATH=/opt/ros/noetic/lib;
   PATH=/opt/ros/noetic/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;
   ROS_ROOT=/opt/ros/noetic/share/ros;
   ROS_DISTRO=noetic;
   ```
   ![](README/1.png)
   
3. 执行cmake，编译

4. 右上角Edit Configuration，对可执行程序（listener和talker）增加env.sh的输出的环境变量，
    ```shell
   ROS_VERSION=1;
   PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig;
   ROS_PYTHON_VERSION=3;ROS_PACKAGE_PATH=/opt/ros/noetic/share;
   ROSLISP_PACKAGE_DIRECTORIES=;
   ROS_ETC_DIR=/opt/ros/noetic/etc/ros;
   CMAKE_PREFIX_PATH=/opt/ros/noetic;
   PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages;
   ROS_MASTER_URI=http://localhost:11311;
   LD_LIBRARY_PATH=/opt/ros/noetic/lib;
   PATH=/opt/ros/noetic/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;
   ROS_ROOT=/opt/ros/noetic/share/ros;
   ROS_DISTRO=noetic;
   ```
   ![](README/2.png)
   
5. 开roscore，运行

## 已知环境变量的影响

1. ROS_PACKAGE_PATH 
   + 会影响运行时查找plugin，如果没有指定则会报pluginlib::ClassLoaderException
2. CMAKE_PREFIX_PATH 
   + 会影响编译时查找catkin
   + 会影响运行时查找plugin，如果没有指定则会报'pluginlib::LibraryLoadException'
