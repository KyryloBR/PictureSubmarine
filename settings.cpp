#include "settings.h"
#include <QFile>
#include <QDebug>

Settings::Settings(QObject *parent) : QObject(parent)
{
    m_configuration = new QSettings("Shaman","Picture Sumarine");
//    QFile f("default.cfg");
//    f.open(QIODevice::ReadOnly);
//    m_configuration->setDefaults(f.readAll());
     m_defaults.insert("directory/currentAlbum",false);
     m_defaults.insert("directory/currentAlbumFile","none");
     m_defaults.insert("directory/albumPath","/album");
     m_defaults.insert("app/y",0);
     m_defaults.insert("app/x",0);
     m_defaults.insert("app/height",480);
     m_defaults.insert("app/width",640);
}

int Settings::width()
{
    return m_configuration->value("app/width").toInt();
}

int Settings::height()
{
    return m_configuration->value("app/height").toInt();
}

int Settings::x()
{
    return m_configuration->value("app/x").toInt();
}

int Settings::y()
{
    return m_configuration->value("app/y").toInt();
}

QString Settings::albumPath()
{
    return m_configuration->value("directory/albumPath").toString() == "" ? m_defaults["directory/albumPath"].toString() : m_configuration->value("directory/albumPath").toString();
}

QString Settings::currentAlbumFile()
{
    return m_configuration->value("directory/currentAlbumFile").toString();
}

bool Settings::isCurrent()
{
    return m_configuration->value("directory/currentAlbum").toBool();
}

void Settings::setWidth(int _width)
{
    m_configuration->setValue("app/width",_width);
}

void Settings::setHeight(int _height)
{
    m_configuration->setValue("app/height",_height);
}

void Settings::setX(int _x)
{
    m_configuration->setValue("app/x",_x);
}

void Settings::setY(int _y)
{
    m_configuration->setValue("app/y",_y);
}

void Settings::setAlbumPath(const QString &_path)
{
    m_configuration->setValue("directory/albumPath",_path);
}

void Settings::setCurrentAlbumFile(const QString &_file)
{
    m_configuration->setValue("directory/currentAlbumFile",_file);
}

void Settings::setCurrent(bool _current)
{
    m_configuration->setValue("directory/currentAlbum",_current);
}



