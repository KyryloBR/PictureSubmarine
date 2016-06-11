TEMPLATE = app

QT += qml quick widgets xml

SOURCES += main.cpp \
    image.cpp \
    album.cpp \
    controller.cpp \
    settings.cpp \
    parseralbum.cpp \
    currentalbumcontroller.cpp \
    addedimages.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    image.h \
    album.h \
    controller.h \
    settings.h \
    parseralbum.h \
    currentalbumcontroller.h \
    addedimages.h

