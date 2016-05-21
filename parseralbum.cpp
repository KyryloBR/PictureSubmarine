#include "parseralbum.h"
#include <QFile>
#include <QDebug>

ParserAlbum::ParserAlbum(const QString & _dir, const QString &_name, QObject *parent) : QObject(parent)
{
    qDebug() << _dir << " : dir" << _name;
    m_directory = _dir;
    QFile * file = new QFile(m_directory + "/" + _name + ".alm");
    if(!file->open(QIODevice::ReadWrite))
    {
        qDebug() << "Error";
        //return;
    }
    m_pDoc = new QDomDocument();
    m_pDoc->setContent(file);
}

Album ParserAlbum::getAlbumFromFile()
{
    Album newAlbum;
    QDomElement element = m_pDoc->documentElement();
    QDomNode node = element.firstChild();
    while(!node.isNull())
    {
        if(node.isElement())
        {
            QDomElement domElement = node.toElement();
            if(domElement.tagName() == "id")
            {
                newAlbum.setName(domElement.text());
            }
            if(domElement.tagName() == "images")
            {
                if(domElement.hasChildNodes())
                {
                    getImages(newAlbum,domElement.childNodes());
                }
            }
        }
    }
    return newAlbum;
}

void ParserAlbum::writeToAlbumByFile(Image *_image)
{
    QDomElement element = m_pDoc->documentElement();
    QDomElement node  = element.firstChild().toElement();
    while(node.tagName() != "images")
    {
        node = node.nextSibling().toElement();
    }
    QDomElement image;
    image.setTagName("image");
    image.setNodeValue(_image->sourceImage());
    node.appendChild(image);
}

void ParserAlbum::switchFile(const QString &_file)
{

}

void ParserAlbum::getImages(Album alb, QDomNodeList list)
{
    for(int i = 0; i < list.count() - 1; ++i)
    {
        alb.append(new Image(list.at(i).toElement().text()));
    }
}
