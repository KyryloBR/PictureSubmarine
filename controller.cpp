#include "controller.h"
#include <QDir>
#include <QDebug>
#include <QFileInfoList>
#include <QFileInfo>
#include "album.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
   m_pConfiguration = new Settings();
   m_pParser = new ParserAlbum(QDir::currentPath() + m_pConfiguration->albumPath());
   loadAlbums();
   if(m_listAlbums.find("temp") != m_listAlbums.end())
   {
       m_pCurrentAlbum = m_listAlbums["temp"];
   }
   connect(m_pCurrentAlbum,SIGNAL(currentIndexChanged(int)),this,SLOT(writeCurrentImageInAlbum(int)));
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

QList<QObject *> Controller::getModelAlbum()
{
    QList<QObject*> dataList;
    for(int i = 0;i < m_listAlbums.values().size();++i)
    {
        dataList.append(m_listAlbums.values().at(i));
    }
    return dataList;
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

void Controller::addImageToAlbum(const QString &_id,const QString & _image)
{
    if(m_listAlbums.find(_id) != m_listAlbums.end())
    {
        m_listAlbums[_id]->append(_image);
        m_pParser->setFile(_id);
        m_pParser->writeToAlbumByFile(_image);
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
    if(m_listAlbums.find(_id) == m_listAlbums.end())
    {
        _newAlbum->setName(_id);
        m_pParser->setFile(_id);
        m_pParser->createNewAlbum();
    }
}

void Controller::loadAlbums()
{
    QDir dir;
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Name);
    dir.setCurrent(m_pParser->getDirectory());

    QFileInfoList list = dir.entryInfoList();
    for(int i = 0; i < list.count(); ++i)
    {
         QFileInfo fileInfo = list.at(i);
         m_pParser->setFile(fileInfo.baseName());
         m_listAlbums.insert(fileInfo.baseName(),new Album(m_pParser->getAlbumFromFile(fileInfo.baseName())));
    }
}

void Controller::writeCurrentImageInAlbum(int index)
{
    m_pParser->setFile(m_pCurrentAlbum->name());
    m_pParser->writeCurrentInAlbum(index);
}
