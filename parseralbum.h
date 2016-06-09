#ifndef PARSERALBUM_H
#define PARSERALBUM_H

#include <QObject>
#include <QtXml>
#include "album.h"

class ParserAlbum : public QObject
{
    Q_OBJECT
public:
    ParserAlbum(const QString &_dir, QObject *parent = 0);

    Album getAlbumFromFile(const QString &_name);
    void writeToAlbumByFile(const QString &_source);
    void createNewAlbum();
    QString getDirectory();
    void writeCurrentInAlbum(int _current);
    void removeImage(Image * image);
    QString getFileName();

public slots:
    void setFile(const QString & _file);
    void setDirectory(const QString & _dir);
    void removeFile(const QString & _file);

private:
    void getImages(Album &alb, QDomNodeList list);
    QDomElement createElement(const QString & _name, const QString & _text);
    QDomElement createElement(const QString & _name);

    QDomDocument * m_pDoc;
    QString m_directory;
    QFile * m_pFile;
};

#endif // PARSERALBUM_H
