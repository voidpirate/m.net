set(BIN_DIR "${CMAKE_CURRENT_BINARY_DIR}/bin")
set(LIB_DIR "${CMAKE_CURRENT_BINARY_DIR}/lib")

if (WIN32)
  set(WIN_BIN_DIR "${BIN_DIR}/${CMAKE_BUILD_TYPE}")
endif()

set(
  TARGET_DIR
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/
  )

file(
  MAKE_DIRECTORY
  ${BIN_DIR}
  ${LIB_DIR}
  )

if (APPLE)
  set(
    APP_FILE
    ${TARGET_DIR}/bin/${CMAKE_PROJECT_NAME}.app/
    )

  set(
    APP_CONTENTS_DIR
    ${APP_FILE}/Contents/
    )

  set(
    APP_BIN_DIR
    ${APP_CONTENTS_DIR}/MacOS/
    )

  set(
    APP_FRAMEWORK_DIR
    ${APP_CONTENTS_DIR}/Frameworks/
    )

  set(
    APP_RESOURCES_DIR
    ${APP_CONTENTS_DIR}/Resources/
    )

  file(MAKE_DIRECTORY
    ${APP_CONTENTS_DIR}
    ${APP_BIN_DIR}
    ${APP_FRAMEWORK_DIR}
    ${APP_RESOURCES_DIR}
    )

  # Substitute in the exact versions.
  configure_file(
    "${CMAKE_SOURCE_DIR}/res/Info.plist.in"
    "${CMAKE_BINARY_DIR}/Info.plist"
    @ONLY
    )

  file(
    COPY "${CMAKE_BINARY_DIR}/Info.plist"
    DESTINATION ${APP_CONTENTS_DIR}
    )

  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${APP_BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CMAKE_BUILD_TYPE} ${APP_BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${APP_BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${APP_BIN_DIR})

  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${APP_FRAMEWORK_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CMAKE_BUILD_TYPE} ${APP_FRAMEWORK_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${APP_FRAMEWORK_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${APP_FRAMEWORK_DIR})
else()
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CMAKE_BUILD_TYPE} ${BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${BIN_DIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${BIN_DIR})

  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CMAKE_BUILD_TYPE} ${LIB_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LIB_DIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${LIB_DIR})
endif()
