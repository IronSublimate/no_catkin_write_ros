# 不用catkin_make，像正常c++一样写ROS

> 侯宇轩

+ 不用catkin
+ 不用source /opt/ros/xxx/setup.bash
+ 使用CMake
+ Clion能调试
+ Clion能远程/WSL调试

直接用g++编译同理
以[官网教程:Writing a Simple Publisher and Subscriber (C++)](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28c%2B%2B%29)为例

## 新建工作空间(可选)

如果想按照ros的工作空间格式建项目，可以按照这个步骤

```bash
catkin init
mkdir src
cd src
catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
cd beginner_tutorials
```



## 新建/修改CMakeLists.txt

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
1. 查看catkin相关的环境变量

    ```bash
    catkin_make
    source devel/setup.zsh
    ```

    （远程）终端输入env，查看CMAKE_PREFIX_PATH和LD_LIBRARY_PATH环境变量

    

2. 工作空间打开clion，选择src下面的CMakeLists.txt
    
2. File -> Settings -> Build, Execution, Deployment -> CMake，
    
    添加cmake option，这里ROS neotic是python3，其他的ros可能是python2，其中CMAKE_INSTALL_PREFIX和CATKIN_DEVEL_PREFIX是相对于Build directory的
    
   ```bash
   -DPYTHON_EXECUTABLE=/usr/bin/python3 -DCMAKE_INSTALL_PREFIX=../install -DCATKIN_DEVEL_PREFIX=../devel
   ```
   
   添加Environment，注意是python3还是python2
   
   ```shell
   PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig:/opt/ros/kinetic/lib/x86_64-linux-gnu/pkgconfig;
   PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages\;/usr/lib/python3/dist-packages;
   CMAKE_PREFIX_PATH=/opt/ros/noetic;
   ROS_PACKAGE_PATH=/opt/ros/noetic/share:./src
   LD_LIBRARY_PATH=/opt/ros/noetic/lib:/opt/ros/noetic/lib/x86_64-linux-gnu;
   PATH=/opt/ros/noetic/bin:~/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin;
   ROS_DISTRO=noetic;
   ROS_ETC_DIR=/opt/ros/noetic/etc/ros;
   ROS_PYTHON_VERSION=3;
   ROS_VERSION=1;
   ROS_ROOT=/opt/ros/noetic/share/ros;
   ROS_MASTER_URI=http://localhost:11311;
   ROSLISP_PACKAGE_DIRECTORIES=./devel/share/common-lisp;
   
   ```
   ![](README/1.png)
   
4. 执行cmake，编译

4. 右上角Edit Configuration，对可执行程序（listener和talker）增加LD_LIBRARY_PATH环环境变量
    ```shell
    LD_LIBRARY_PATH=devel/lib:/opt/ros/noetic/lib:/opt/ros/noetic/lib/x86_64-linux-gnu:/usr/local/lib:$LD_LIBRARY_PATH;
    PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages:/usr/lib/python3/dist-packages;
   ROS_PACKAGE_PATH=./src:/opt/ros/noetic/share;
   PATH=/opt/ros/noetic/bin:~/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:$PATH;
   ```
   ![](README/2.png)
   
5. 开roscore，运行
