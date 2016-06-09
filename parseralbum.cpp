#include "parseralbum.h"
#include <QFile>
#include <QDebug>

ParserAlbum::ParserAlbum(const QString & _dir, QObject *parent) : QObject(parent)
{
    qDebug() << "Directory : " << _dir;
    m_directory = _dir;
    m_pFile = new QFile();
    m_pDoc = new QDomDocument();
}

Album ParserAlbum::getAlbumFromFile(const QString &_name)
{
    m_pFile->close();
    if(!m_pFile->open(QIODevice::ReadOnly))
    {
        qDebug() << "Can`t open file : " << m_pFile->fileName();
    }
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
    m_pFile->close();
    return newAlbum;
}

void ParserAlbum::writeToAlbumByFile(const QString & _source)
{
    m_pFile->close();
    if(!m_pFile->open(QIODevice::WriteOnly))
    {
        return;
    }
    QDomElement element = m_pDoc->documentElement();
    QDomElement node  = element.firstChild().toElement();
    while(node.tagName() != "images")
    {
        node = node.nextSibling().toElement();
    }
    node.appendChild(createElement("image",_source));
    if(m_pFile->isOpen())
    {
        QTextStream(m_pFile) << m_pDoc->toString();
        m_pFile->close();
    }
}

void ParserAlbum::createNewAlbum()
{
    m_pFile->close();
    if(!m_pFile->open(QIODevice::WriteOnly))
    {
        qDebug() << "Can`t open file : " << m_pFile->fileName();
        return;
    }
    QDomElement firstChild = createElement("album");
    m_pDoc->appendChild(firstChild);

    QDomElement images = createElement("images"," ");
    QDomElement current = createElement("current","0");

    firstChild.appendChild(images);
    firstChild.appendChild(current);

    if(m_pFile->isOpen())
    {
        QTextStream(m_pFile) << m_pDoc->toString();
        m_pFile->close();
    }
}

QString ParserAlbum::getDirectory()
{
    return m_directory;
}

void ParserAlbum::writeCurrentInAlbum(int _current)
{
    m_pFile->close();
    if(!m_pFile->open(QIODevice::WriteOnly))
    {
        return;
    }
    QDomElement element = m_pDoc->documentElement();
    QDomElement node  = element.firstChild().toElement();
    while(node.tagName() != "current")
    {
        node = node.nextSibling().toElement();
    }
    QDomElement CurrentElement = createElement("current",QString::number(_current));
    element.replaceChild(CurrentElement,node);

    if(m_pFile->isOpen())
    {
        QTextStream(m_pFile) << m_pDoc->toString();
        m_pFile->close();
    }
}

void ParserAlbum::removeImage(Image *image)
{
    m_pFile->close();
    if(!m_pFile->open(QIODevice::WriteOnly))
    {
        return;
    }
    QDomElement element = m_pDoc->documentElement();
    QDomElement node  = element.firstChild().toElement();
    QDomElement images = node;
    node = node.firstChildElement();
    while(!node.isNull())
    {
        qDebug() << node.tagName() << " : " << node.text();
        if(node.text() == image->sourceImage())
        {
            images.removeChild(node);
            qDebug() << "removed : " << node.text();
            node = node.nextSibling().toElement();
        }
        else
        {
            node = node.nextSibling().toElement();
        }
    }
    if(m_pFile->isOpen())
    {
        QTextStream(m_pFile) << m_pDoc->toString();
        m_pFile->close();
    }
}

QString ParserAlbum::getFileName()
{
    return m_pFile->fileName();
}

void ParserAlbum::setFile(const QString &_file)
{
        m_pFile->setFileName(m_directory + "/" + _file + ".alm");
        m_pDoc->setContent(m_pFile);
}

void ParserAlbum::setDirectory(const QString &_dir)
{
    m_directory = _dir;
}

void ParserAlbum::removeFile(const QString &_file)
{
    QDir dir;
    dir.setPath(m_directory);
    dir.remove(_file + ".alm");
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

