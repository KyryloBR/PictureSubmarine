#ifndef ADDEDIMAGES_H
#define ADDEDIMAGES_H

#include <QThread>
#include "album.h"
#include "parseralbum.h"

class AddedImages : public QThread
{
    Q_OBJECT
public:
    AddedImages(const QString & _dir, QObject *parent = 0);
    void run();
    void setFiles(QList<QUrl> _files);
    void setFileName(const QString & _file);

private:
    ParserAlbum * m_pParser;
    QList<QUrl> m_files;
};

#endif // ADDEDIMAGES_H
