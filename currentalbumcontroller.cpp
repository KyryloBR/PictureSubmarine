#include "currentalbumcontroller.h"
#include <QDir>

CurrentAlbumController::CurrentAlbumController(ParserAlbum *pParser, QObject *parent) : QThread(parent)
{
    m_pParser = pParser;
}

void CurrentAlbumController::run()
{
    QDir dir;
    QStringList filters;
    filters << "*.alm";
    dir.setPath(m_pParser->getDirectory());
    dir.remove("current.alm");
    m_pParser->setFile("current");
    m_pParser->createNewAlbum();

    for(int i = 0;i < m_pAlbum->countImage() - 1;++i)
    {
         m_pParser->writeToAlbumByFile(m_pAlbum->imageByIndex(i)->sourceImage());
    }
    m_pParser->writeCurrentInAlbum(m_pAlbum->currentIndex());
}

void CurrentAlbumController::setAlbum(Album *pAlbum)
{
    m_pAlbum = pAlbum;
}
