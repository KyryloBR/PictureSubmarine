#ifndef PARSERALBUM_H
#define PARSERALBUM_H

#include <QObject>
#include <QtXml>
#include "album.h"

class ParserAlbum : public QObject
{
    Q_OBJECT
public:
    ParserAlbum(const QString &_dir, /*const QString & _name,*/ QObject *parent = 0);

    Album getAlbumFromFile(const QString &_name);
    void writeToAlbumByFile(/*const QString & _album,*/ const QString &_source);
    void createNewAlbum(/*Album * _pAlbum*/);
    QString getDirectory();

public slots:
    void setFile(const QString & _file);
    void setDirectory(const QString & _dir);

private:
    void getImages(Album &alb, QDomNodeList list);
    QDomElement createElement(const QString & _name, const QString & _text);
    QDomElement createElement(const QString & _name);

    QDomDocument * m_pDoc;
    QString m_directory;
    QFile * m_pFile;
};

#endif // PARSERALBUM_H
