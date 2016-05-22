#include "album.h"
#include <QDebug>

Album::Album(QObject *parent) : QObject(parent)
{

}

Album::Album(const Album &instance)
{
    m_currentIndex = instance.m_currentIndex;
    m_imageList = instance.m_imageList;
    m_name = instance.m_name;
    m_pCurrentImage = instance.m_pCurrentImage;
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
    qDebug() << m_name << m_imageList.size();
    for(int i = 0;i < m_imageList.size();++i)
    {
        qDebug() << "Dickmus";
        dataList.append(m_imageList.at(i));
    }
    return dataList;
}

QString Album::name()
{
   return m_name;
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
    setCurrentIndex(m_currentIndex + 1);
}

void Album::previous()
{
    setCurrentIndex(m_currentIndex - 1);
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
