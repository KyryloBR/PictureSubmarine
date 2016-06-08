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
//   if(m_listAlbums.find(m_pConfiguration->currentAlbumFile()) != m_listAlbums.end())
//   {
//       m_pCurrentAlbum = m_listAlbums[/*m_pConfiguration->currentAlbumFile()*/"current"];
//       qDebug() << "Current Album Condition : " << m_pConfiguration->currentAlbumFile();
//       qDebug() << "Current Album : " << m_pCurrentAlbum->name();
//   }
//   else
//   {
   m_pCurrentAlbum = new Album();
//   }
   m_pCurrentCtrl = new CurrentAlbumController(m_pParser);
   connect(m_pCurrentAlbum,SIGNAL(currentIndexChanged(int)),this,SLOT(writeCurrentImageInAlbum(int)));
   connect(m_pCurrentAlbum,SIGNAL(currentIndexChanged(int)),this, SLOT(setCurrentIndex(int)));
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

void Controller::setCurrentIndex(int index)
{
    m_pParser->setFile(m_pCurrentAlbum->name());
    m_pParser->writeCurrentInAlbum(index);
}

void Controller::setCurrentAlbum(const QString &_id)
{
    if(m_listAlbums.find(_id) != m_listAlbums.end())
    {
        m_pCurrentAlbum = m_listAlbums[_id];
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

void Controller::addImages(QList<QUrl> _files)
{
    m_pParser->setFile(m_pCurrentAlbum->name());
    m_pParser->writeCurrentInAlbum(m_pCurrentAlbum->countImage());
    m_pCurrentAlbum->setCurrentIndex(m_pCurrentAlbum->countImage());
    for(int i = 0; i < _files.count();++i)
    {
        m_pCurrentAlbum->append(_files.at(i).toString());
        m_pParser->writeToAlbumByFile(_files.at(i).toString());
    }
}

void Controller::addImageToCurrentAlbum(Image *_image)
{
    if(m_pCurrentAlbum)
    {
        m_pCurrentAlbum->append(_image);
    }
}

void Controller::addImageToCurrentAlbum(const QString &_source)
{
    m_pCurrentAlbum->append(new Image(_source));
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

void Controller::addAlbum(const QString &_id)
{
     if(m_listAlbums.find(_id) == m_listAlbums.end())
     {
        m_listAlbums.insert(_id, new Album());
        m_listAlbums[_id]->setName(_id);
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

void Controller::createCurrentAlbum(QString _dir, QString _currentImage)
{
   _dir.remove(0,8);
   QDir dir;
   QStringList currentList;
   QStringList filters;
   dir.setPath(_dir);
   dir.setSorting(QDir::Name);
   filters << "*.png" << "*.jpg" << "*.bmp";
   QFileInfoList list = dir.entryInfoList(filters,QDir::Files|QDir::NoDotAndDotDot);
   for(int i = 0; i < list.count(); ++i)
   {
        QFileInfo fileInfo = list.at(i);
        currentList << "file:///" + fileInfo.absoluteFilePath();
   }
   if(m_listAlbums.find("current") != m_listAlbums.end())
   {
        m_listAlbums.remove("current");
   }

   m_listAlbums.insert("current",new Album(currentList,_currentImage));
   m_listAlbums.find("current").value()->setName("current");
   m_pCurrentCtrl->setAlbum(m_listAlbums.find("current").value());
   m_pCurrentCtrl->start(QThread::IdlePriority);
   m_pCurrentAlbum = m_listAlbums.find("current").value();
}

void Controller::removePush(int index)
{
    m_removedIndex.push_back(index);
}

void Controller::removePop(int index)
{
    m_removedIndex.removeAt(index);
}

void Controller::removeSelected()
{
    if(m_pParser->getFileName() != (m_pParser->getDirectory() + "/" + m_pCurrentAlbum->name() + ".alm"))
    {
            m_pParser->setFile(m_pCurrentAlbum->name());
    }
    for(int i = 0;i < m_removedIndex.count();++i)
    {
        m_pParser->removeImage(m_pCurrentAlbum->imageByIndex(m_removedIndex.at(i)));
        m_pCurrentAlbum->remove(m_removedIndex.at(i));
    }
    m_removedIndex.clear();
}
