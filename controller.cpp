#include "controller.h"
#include <QDir>
#include <QDebug>
#include <QFileInfoList>
#include <QFileInfo>
#include "album.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
   m_pConfiguration = new Settings();
   loadAlbums();
   if(m_listAlbums.find("temp") != m_listAlbums.end())
   {
       m_pCurrentAlbum = m_listAlbums["temp"];
   }
}

Album *Controller::currentAlbum()
{
    if(m_pCurrentAlbum)
    {
        return m_pCurrentAlbum;
    }
    return NULL;
}

QString Controller::currentId()
{
    return m_currentId;
}

Settings *Controller::configuration()
{
    if(m_pConfiguration)
    {
        return m_pConfiguration;
    }
    return NULL;
}

void Controller::setCurrentAlbum(const QString &_id)
{
    if(m_listAlbums.find(_id) != m_listAlbums.end())
    {
        m_pCurrentAlbum = m_listAlbums[_id];\
        emit currentAlbumChanged(m_pCurrentAlbum);
        emit currentIdChanged(_id);
    }
}

void Controller::addImageToAlbum(const QString &_id, Image *_image)
{
    if(m_listAlbums.find(_id) != m_listAlbums.end())
    {
        m_listAlbums[_id]->append(_image);
    }
}

void Controller::addImageToCurrentAlbum(Image *_image)
{
    if(m_pCurrentAlbum)
    {
        m_pCurrentAlbum->append(_image);
    }
}

void Controller::addAlbum(const QString &_id, Album *_newAlbum)
{

}

void Controller::loadAlbums()
{
    QDir dir;
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Size | QDir::Reversed);
    dir.setCurrent(dir.currentPath() + m_pConfiguration->albumPath());

    QFileInfoList list = dir.entryInfoList();
    for(int i = 0; i < list.count(); ++i)
    {
         QFileInfo fileInfo = list.at(i);
         m_pParser = new ParserAlbum(dir.currentPath(),fileInfo.baseName());
         m_listAlbums.insert(fileInfo.baseName(),new Album(m_pParser->getAlbumFromFile(fileInfo.baseName())));
         delete m_pParser;
    }
}


