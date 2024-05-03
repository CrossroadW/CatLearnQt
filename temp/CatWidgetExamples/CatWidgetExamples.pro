QT += core gui sql widgets

#DEFINES += WEBASSEMBLY
if(contains(DEFINES,WEBASSEMBLY)) {
QT -= sql
}
QT += quick quickwidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
contains(QT_CONFIG, opengl): QT += opengl

#DEFINES += ANDROID_APP
DEFINES += QAPPLICATIONEXE_CLASS
#DEFINES += _X86_

CONFIG += c++11
# CONFIG += console

DEFINES += QT_DEPRECATED_WARNINGS


# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.

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

DEFINES += APP_VERSION=\\\"'v1.2.0'\\\"
DEFINES += LOG_PATH=\\\"'Logs/'\\\"
DEFINES += APP_NAME=\\\"'CatWidgetExamples'\\\"
lessThan(QT_MAJOR_VERSION, 6) {
include($$PWD/../../GrayFramelesshelper/GrayFramelesshelper.pri)
} else {

}
include($$PWD/CatWidgetExamples.pri)
include($$PWD/../../GrayCatQt/GrayCatQt.pri)
include($$PWD/../../GrayCatQtCore/GrayCatQtCore.pri)

RESOURCES += \
    Resource/Resource.qrc

TRANSLATIONS = Resource/lang/language_en.ts \
               Resource/lang/language_zh_CN.ts

win32 {
    RC_ICONS += Resource\Images\cwlogo.ico
}

SOURCES += \
    main.cpp


#win32 {
#    CONFIG(release, debug|release){
#        QMAKE_LFLAGS += /MANIFESTUAC:\"level=\'requireAdministrator\' uiAccess=\'false\'\"
#        QMAKE_LFLAGS += /SUBSYSTEM:WINDOWS
#    }
#}
