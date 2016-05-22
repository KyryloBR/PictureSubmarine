#ifndef PARSERALBUM_H
#define PARSERALBUM_H

#include <QObject>
#include <QtXml>
#include "album.h"

class ParserAlbum : public QObject
{
    Q_OBJECT
public:
    ParserAlbum(const QString &_dir, const QString & _name, QObject *parent = 0);

    Album getAlbumFromFile(const QString &_name);
    void writeToAlbumByFile(Image * _image);
    //void createNewAlbum(Album * _pAlbum);

public slots:
    void switchFile(const QString & _file);

private:
    void getImages(Album &alb, QDomNodeList list);

    QDomDocument * m_pDoc;
    QString m_directory;
};

#endif // PARSERALBUM_H
