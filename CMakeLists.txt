cmake_minimum_required(VERSION 3.15)
project(rtdll LANGUAGES C)

# Manual versioning
set (PROJECT_VERSION_MAJOR 0)
set (PROJECT_VERSION_MINOR 1)
set (PROJECT_VERSION_PATCH 0)
set (PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

# Build options
option(BUILD_MAIN "Build main version with all indicators" ON)
option(BUILD_COMMON "Build common version for subscribers" OFF)

# Configure version.h
configure_file(
    ${CMAKE_SOURCE_DIR}/include/version.h.in
    ${CMAKE_SOURCE_DIR}/include/version.h
)

# Output directory strtucture
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/x64/$<CONFIG>)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/x64/$<CONFIG>)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/x64/$<CONFIG>)

# Include paths
include_directories(
    ${PROJECT_SOURCE_DIR} 
    ${PROJECT_SOURCE_DIR}/include 
    ${PROJECT_BINARY_DIR}/include
)

# Source files
file(GLOB COMMON_SOURCES "src/common/*.c")
file(GLOB INDICATOR_SOURCES "src/indicators/*.c")
file(GLOB PROTECTED_SOURCES "src/protected/*.c")

# Main build
if(BUILD_MAIN)
    add_library(rtdll SHARED
        rtdll.c
        ${COMMON_SOURCES}
        ${INDICATOR_SOURCES}
        ${PROTECTED_SOURCES}
    )

    set(MAIN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/main/x64/$<CONFIG>")

    set_target_properties(rtdll PROPERTIES
        OUTPUT_NAME "rtdll" 
        ARCHIVE_OUTPUT_DIRECTORY "${MAIN_OUTPUT_DIR}" 
        LIBRARY_OUTPUT_DIRECTORY "${MAIN_OUTPUT_DIR}" 
        RUNTIME_OUTPUT_DIRECTORY "${MAIN_OUTPUT_DIR}" 
        VERSION "${PROJECT_VERSION}" 
        SOVERSION "${PROJECT_VERSION_MAJOR}"
    )

    target_compile_definitions(rtdll PRIVATE
        INDICATOR_TYPE=MAIN
        VERSION=${PROJECT_VERSION}
    )

    add_custom_command(TARGET rtdll POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E rename
            "$<TARGET_FILE:rtdll>"
            "${MAIN_OUTPUT_DIR}/rtdll_${PROJECT_VERSION}.dll"
        COMMAND ${CMAKE_COMMAND} -E copy
            "${MAIN_OUTPUT_DIR}/rtdll_${PROJECT_VERSION}.dll"
            "${MAIN_OUTPUT_DIR}/rtdll.dll"
        COMMENT "Backing up DLLs."
    )
endif()

# Common build
if(BUILD_COMMON)
    add_library(rtdll_common SHARED
        rtdll.c
        ${COMMON_SOURCES}
        ${INDICATOR_SOURCES}
    )

    set(COMMON_OUTPUT_DIR "${CMAKE_BINARY_DIR}/common/x64/$<CONFIG>")

    set_target_properties(rtdll_common PROPERTIES
        OUTPUT_NAME "rtdll" 
        ARCHIVE_OUTPUT_DIRECTORY "${COMMON_OUTPUT_DIR}"
        LIBRARY_OUTPUT_DIRECTORY "${COMMON_OUTPUT_DIR}" 
        RUNTIME_OUTPUT_DIRECTORY "${COMMON_OUTPUT_DIR}" 
        VERSION "${PROJECT_VERSION}" 
        SOVERSION "${PROJECT_VERSION_MAJOR}" 
    )

    target_compile_definitions(rtdll_common PRIVATE
        INDICATOR_TYPE="COMMON"
        VERSION="${PROJECT_VERSION}"
    )

    add_custom_command(TARGET rtdll_common POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E rename
            "$<TARGET_FILE:rtdll>"
            "${COMMON_OUTPUT_DIR}/rtdll_${PROJECT_VERSION}.dll"
        COMMAND ${CMAKE_COMMAND} -E copy
            "${COMMON_OUTPUT_DIR}/rtdll_${PROJECT_VERSION}.dll"
            "${COMMON_OUTPUT_DIR}/rtdll.dll"
        COMMENT "Backing up DLLs."
    )
endif()
