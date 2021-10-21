cmake_minimum_required(VERSION 2.8.3)
project(no_catkin_write_ros)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs genmsg)

## Declare a catkin package
# catkin_package()

## Build talker and listener
include_directories(include ${catkin_INCLUDE_DIRS})

add_executable(talker talker.cpp)
target_link_libraries(talker ${catkin_LIBRARIES})

add_executable(listener listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})