# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(os_scan_library VERSION 0.0.1 LANGUAGES C)

add_library(os_scan SHARED
  "os_scan.c"
)

set_target_properties(os_scan PROPERTIES
  PUBLIC_HEADER os_scan.h
  OUTPUT_NAME "os_scan"
)

target_compile_definitions(os_scan PUBLIC DART_SHARED_LIB)
