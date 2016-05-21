#include "controller.h"
#include <QDir>
#include <QDebug>
#include <QFileInfoList>
#include <QFileInfo>

Controller::Controller(QObject *parent) : QObject(parent)
{
   m_pConfiguration = new Settings();
   loadAlbums();
}

void Controller::loadAlbums()
{
    qDebug() << "LoadAlbums";
    qDebug() << m_pConfiguration->albumPath();
    QDir dir;
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Size | QDir::Reversed);
    dir.setCurrent(dir.currentPath() + m_pConfiguration->albumPath());

    QFileInfoList list = dir.entryInfoList();
    qDebug() << "Size : " << list.size();
    for(int i = 0; i < list.count(); ++i)
    {
         QFileInfo fileInfo = list.at(i);
         qDebug() << fileInfo.baseName() << fileInfo.absoluteDir().path() << fileInfo.suffix() << "\n";
         m_pParser = new ParserAlbum(dir.currentPath(),fileInfo.baseName());
         m_listAlbums.insert(fileInfo.baseName(),new Album(m_pParser->getAlbumFromFile()));
    }
}

