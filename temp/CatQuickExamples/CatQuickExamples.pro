QT += core gui quick

#DEFINES += WEBASSEMBLY

message(Qt version: $$[QT_VERSION])
message(Qt is installed in $$[QT_INSTALL_PREFIX])
message(Qt resources can be found in the following locations:)
message(Documentation: $$[QT_INSTALL_DOCS])
message(Header files: $$[QT_INSTALL_HEADERS])
message(Libraries: $$[QT_INSTALL_LIBS])
message(Binary files (executables): $$[QT_INSTALL_BINS])
message(Plugins: $$[QT_INSTALL_PLUGINS])
message(Data files: $$[QT_INSTALL_DATA])
message(Translation files: $$[QT_INSTALL_TRANSLATIONS])
message(Settings: $$[QT_INSTALL_CONFIGURATION])
message(Examples: $$[QT_INSTALL_EXAMPLES])


DEFINES += WEBRESOURCEPATH=\\\"file:///$$PWD/WebResource\\\"

defineTest(minQtVersion) {
    maj = $$1
    min = $$2
    patch = $$3
    isEqual(QT_MAJOR_VERSION, $$maj) {
        isEqual(QT_MINOR_VERSION, $$min) {
            isEqual(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
            greaterThan(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
        }
        greaterThan(QT_MINOR_VERSION, $$min) {
            return(true)
        }
    }
    greaterThan(QT_MAJOR_VERSION, $$maj) {
        return(true)
    }
    return(false)
}

#判断Qt版本
lessThan(QT_MAJOR_VERSION, 6) {

minQtVersion(5, 12, 2) {
    QT += quick3d

    !mingw {
        QT += webengine webchannel websockets webview
    }

}

} else {

QT += quick3d

!mingw {
    QT += webenginequick webchannel websockets webview
}

}


if(contains(DEFINES,WEBASSEMBLY)) {
    QT -= quick3d
}

if(contains(DEFINES,WEBASSEMBLY)) {
    QT -= webengine webchannel websockets webview
    QT -= webenginequick webchannel websockets webview
}

if(!contains(DEFINES,WEBASSEMBLY)) {
# 配置file_copies
CONFIG += file_copies

# 创建examples变量并配置
# 配置需要复制的文件或目录(支持通配符)
examples.files = $$PWD/WebResource
# 配置需要复制的目标目录, $$OUT_PWD为QMake内置变量，含义为程序输出目录
CONFIG += debug_and_release
CONFIG(debug, debug|release){
    examples.path = $$OUT_PWD/debug
} else {
    examples.path = $$OUT_PWD/release
}



# 配置COPIES
COPIES += examples
}

CONFIG += c++17 utf8_source
CONFIG += object_with_source
# CONFIG += console

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QGUIAPPLICATIONEXE_CLASS

win32:msvc {
        DEFINES += QT_OS_WIN10
}

TARGET = CatQuickExamples

Release:DESTDIR = release
Release:OBJECTS_DIR = release/.obj
Release:MOC_DIR = release/.moc
Release:RCC_DIR = release/.rcc
Release:UI_DIR = release/.ui

Debug:DESTDIR = debug
Debug:OBJECTS_DIR = debug/.obj
Debug:MOC_DIR = debug/.moc
Debug:RCC_DIR = debug/.rcc
Debug:UI_DIR = debug/.ui

include($$PWD/../../GrayCatQtQuick/GrayCatQtQuick.pri)

include($$PWD/../../GrayCatQtCore/Src/CatUniversal/CatUniversal.pri)

include($$PWD/../../GrayFramelesshelper/GrayFramelesshelper.pri)

if(!contains(DEFINES,WEBASSEMBLY)) {
    include($$PWD/../../GrayCatQtCore/Src/SingleApplication/singleapplication.pri)
    #include($$PWD/../../GrayCatQtCore/Src/CatEncp/CatEncp.pri)
}

include($$PWD/QrenCode/QrenCode.pri)
include($$PWD/QmlCatLog/QmlCatLog.pri)

if(!contains(DEFINES,WEBASSEMBLY)) {
    win32:msvc {
        include($$PWD/Src/WebChannelFunction/WebChannelFunction.pri)
    }
    unix {
        include($$PWD/Src/WebChannelFunction/WebChannelFunction.pri)
    }
}

include($$PWD/Src/TableFunction/TableFunction.pri)


if(!contains(DEFINES,WEBASSEMBLY)) {
# 配置file_copies
CONFIG += file_copies

# 创建examples变量并配置
# 配置需要复制的文件或目录(支持通配符)

webresource.files = $$PWD/WebResource
# 配置需要复制的目标目录, $$OUT_PWD为QMake内置变量，含义为程序输出目录
CONFIG += debug_and_release
CONFIG(debug, debug|release){
    webresource.path = $$OUT_PWD/debug
} else {
    webresource.path = $$OUT_PWD/release
}

COPIES += webresource
}

SOURCES += \
    CatConfig.cpp \
    main.cpp

RESOURCES += \
    Resource/Resource.qrc

lessThan(QT_MAJOR_VERSION, 6) {
RESOURCES += \
    QmlSrc/Qt5Compat/QmlSrc.qrc
} else {
RESOURCES += \
    QmlSrc/Qt6Compat/QmlSrc.qrc
}

TRANSLATIONS = $$PWD/Resource/Lang/language_en.ts \
                $$PWD/Resource/lang/language_zh_CN.ts

win32 {
    RC_ICONS += Resource\Images\cqlogo.ico
}

HEADERS += \
    CatConfig.h \
    QmlConfig.h

win32 {
#    CONFIG(release, debug|release){
#        QMAKE_LFLAGS += /MANIFESTUAC:\"level=\'requireAdministrator\' uiAccess=\'false\'\"
#        QMAKE_LFLAGS += /SUBSYSTEM:WINDOWS
#    }
}
