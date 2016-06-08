#ifndef CURRENTALBUMCONTROLLER_H
#define CURRENTALBUMCONTROLLER_H

#include <QThread>
#include "parseralbum.h"
#include "album.h"

class CurrentAlbumController : public QThread
{
    Q_OBJECT
public:
    CurrentAlbumController(ParserAlbum * pParser,QObject *parent = 0);
    void run();
    void setAlbum(Album * pAlbum);

private:
    ParserAlbum * m_pParser;
    Album * m_pAlbum;
};

#endif // CURRENTALBUMCONTROLLER_H
