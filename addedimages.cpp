#include "addedimages.h"
#include <QDebug>

AddedImages::AddedImages(const QString & _dir,QObject *parent) : QThread(parent)
{
    m_pParser = new ParserAlbum(_dir);
}

void AddedImages::run()
{
    for(int i = 0; i < m_files.count() - 1; ++i)
    {
        m_pParser->writeToAlbumByFile(m_files.at(i).toString());
    }
}


void AddedImages::setFiles(QList<QUrl> _files)
{
    m_files = _files;
}

void AddedImages::setFileName(const QString &_file)
{
    m_pParser->setFile(_file);
}
