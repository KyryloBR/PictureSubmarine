#include "parseralbum.h"
#include <QFile>
#include <QDebug>

ParserAlbum::ParserAlbum(const QString & _dir, const QString &_name, QObject *parent) : QObject(parent)
{
    m_directory = _dir;
    QFile * file = new QFile(m_directory + "/" + _name + ".alm");
    if(!file->open(QIODevice::ReadWrite))
    {
        return;
    }
    m_pDoc = new QDomDocument();
    m_pDoc->setContent(file);
}

Album ParserAlbum::getAlbumFromFile(const QString &_name)
{
    Album newAlbum;
    newAlbum.setName(_name);
    QDomElement element = m_pDoc->documentElement();
    QDomNode node = element.firstChild();
    while(!node.isNull())
    {
        if(node.isElement())
        {
            QDomElement domElement = node.toElement();
            if(domElement.nodeName() == "images")
            {
                if(domElement.hasChildNodes())
                {
                    getImages(newAlbum,domElement.childNodes());
                }
            }
            if(domElement.nodeName() == "current")
            {
                newAlbum.setCurrentIndex(domElement.text().toInt());
            }
            node = node.nextSibling().toElement();
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
    node.appendChild(createElement("image",_image->sourceImage()));
}

void ParserAlbum::createNewAlbum(Album *_pAlbum)
{
    m_pDoc->clear();
    QDomElement firstChild = createElement("album");
    m_pDoc->appendChild(firstChild);

    QDomElement images = createElement("images"," ");
    QDomElement current = createElement("current","0");

    firstChild.appendChild(images);
    firstChild.appendChild(current);

    QFile * file = new QFile(m_directory + "/" + _pAlbum->name() + ".alm");
    if(file->open(QIODevice::WriteOnly))
    {
        QTextStream(file) << m_pDoc->toString();
        file->close();
    }
}

void ParserAlbum::switchFile(const QString &_file)
{
    QFile * file = new QFile(m_directory + "/" + _file + ".alm");
    if(!file->open(QIODevice::ReadWrite))
    {
        return;
    }
    m_pDoc->setContent(file);

}

void ParserAlbum::getImages(Album & alb, QDomNodeList list)
{
    for(int i = 0; i < list.count(); ++i)
    {
        alb.append(new Image(list.at(i).toElement().text()));
    }
}

QDomElement ParserAlbum::createElement(const QString &_name, const QString &_text)
{
    QDomElement domElement;
    if(!_name.isEmpty())
    {
        domElement = m_pDoc->createElement(_name);

    }

    if(!_text.isEmpty())
    {
        QDomText text = m_pDoc->createTextNode(_text);
        domElement.appendChild(text);
    }

    return domElement;
}

QDomElement ParserAlbum::createElement(const QString &_name)
{
    QDomElement domElement;
    if(!_name.isEmpty())
    {
        domElement = m_pDoc->createElement(_name);
    }
    return domElement;
}

