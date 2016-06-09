#include "album.h"
#include <QDebug>

Album::Album(QObject *parent) : QObject(parent)
{
    m_currentIndex = -1;
    m_pCurrentImage = new Image();
}

Album::Album(const Album &instance)
{
    m_currentIndex = instance.m_currentIndex;
    m_imageList = instance.m_imageList;
    m_name = instance.m_name;
    m_pCurrentImage = instance.m_pCurrentImage;
}

Album::Album(QStringList &listImages, QString _currentImage)
{
    m_pCurrentImage = new Image(_currentImage);
    for(int i = 0; i < listImages.size();++i)
    {
        m_imageList.append(new Image(listImages.at(i)));
        if(m_imageList.at(i)->sourceImage() == _currentImage)
        {
            m_currentIndex = i;
        }
    }
}

Image *Album::currentImage()
{
    if(m_pCurrentImage)
    {
        return m_pCurrentImage;
    }
    return NULL;
}

int Album::currentIndex()
{
    return m_currentIndex;
}

QList<QObject*> Album::getModel()
{
    QList<QObject*> dataList;
    for(int i = 0;i < m_imageList.size();++i)
    {
        dataList.append(m_imageList.at(i));
    }
    return dataList;
}

int Album::indexByImage(Image *_image)
{
    int index = -1;
    for(int i = 0; i < m_imageList.size();++i)
    {
        if(m_imageList.at(i)->sourceImage() == _image->sourceImage())
        {
            index = i;
        }
    }
    return index;
}

QString Album::name()
{
    return m_name;
}

int Album::countImage()
{
    return m_imageList.count();
}

Image *Album::imageByIndex(int index)
{
    if(index < countImage() || index >= 0)
    {
        return m_imageList.at(index);
    }
    return NULL;
}

void Album::setCurrentImage(int index)
{
    if(index >= 0 && index < m_imageList.size())
    {
        m_pCurrentImage = m_imageList.at(index);
        m_currentIndex = index;
        currentImageChanged(m_pCurrentImage);
        currentIndexChanged(m_currentIndex);
    }
}

void Album::setCurrentIndex(int index)
{
    setCurrentImage(index);
}

void Album::next()
{
    if(m_currentIndex == m_imageList.size() - 1)
    {
        setCurrentIndex(0);
    }
    else
    {
        setCurrentIndex(m_currentIndex + 1);
    }
}

void Album::previous()
{
    if(m_currentIndex == 0)
    {
        setCurrentIndex(m_imageList.size() - 1);
    }
    else
    {
        setCurrentIndex(m_currentIndex - 1);
    }
}

void Album::append(Image *_image)
{
    if(_image)
    {
        m_imageList.append(_image);
    }
}

void Album::append(const QString &_source)
{
    m_imageList.append(new Image(_source));
    m_pCurrentImage = m_imageList.at(m_imageList.size() - 1);
}

void Album::addAfter(int index, Image *_image)
{
    if((index >= 0 && index < m_imageList.size()) && _image)
    {
        m_imageList.insert(index + 1,_image);
    }
}

void Album::addAfter(int index, const QString &_source)
{
    if(index >= 0 && index < m_imageList.size())
    {
        m_imageList.insert(index + 1,new Image(_source));
    }
}

void Album::addBefore(int index, Image *_image)
{
    if(index >= 0 && index < m_imageList.size())
    {
        m_imageList.insert(index,_image);
    }
}

void Album::addBefore(int index, const QString &_source)
{
    if(index >= 0 && index < m_imageList.size())
    {
        m_imageList.insert(index,new Image(_source));
    }
}

void Album::move(int from, int to)
{
    if((from >= 0 && from < m_imageList.size()) && (to >= 0 && to < m_imageList.size()))
    {
        m_imageList.move(from,to);
    }
}

void Album::setName(const QString &_name)
{
    m_name = _name;
}

void Album::remove(int index)
{
    if(index > 0 || index < m_imageList.size())
    {
        m_imageList.removeAt(index);
    }
}
