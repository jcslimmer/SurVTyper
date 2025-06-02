cmake_minimum_required(VERSION 2.8)
project(SurVTyper)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pthread")

include_directories(htslib-1.17/)
include_directories(htslib-1.17/include)
include_directories(libs)

set(GENOTYPE_SVS_SRC libs/ssw.c libs/ssw_cpp.cpp genotype_svs.cpp)
add_executable(genotype_svs ${GENOTYPE_SVS_SRC})

find_library(HTS_LIB hts PATHS htslib-1.17/lib NO_DEFAULT_PATH)
target_link_libraries(genotype_svs "${HTS_LIB}")
