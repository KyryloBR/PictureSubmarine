#ifndef CONTROLLER_H
#define CONTROLLER_H

#define SETTING_PATH "Setting.xml"
#define SET_SETTING_PATH(setting) (SETTING_PATH = setting)

#include <QObject>
#include "album.h"
#include "settings.h"
#include <QMap>
#include "parseralbum.h"

class Controller : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(Album* currentAlbum READ currentAlbum WRITE setCurrentAlbum NOTIFY currentAlbumChanged)
//    Q_PROPERTY(Settings* configuration READ configuration WRITE setConfiguration NOTIFY configurationChanged)
public:
    Controller(QObject *parent = 0);

//    Album * currentAlbum();
//    QString currentId();
//    Settings * configuration();

//signals:
//    void currentAlbumChanged(Album*);
//    void currentIdChanged(QString);
//    void configurationChanged(Settings*);

//public slots:
//    void setCurrentAlbum(const QString & _id);
//    void addImageToAlbum(const QString & _id, Image * _image);
//    void addImageToCurrentAlbum(const QString & _id, Image * _image);
//    void addAlbum(const QString & _id, Album * _newAlbum);
    void loadAlbums();
//    void setSettings(Settings * _configuration);

private:
    Album * m_pCurrentAlbum;
    QString m_currentId;
    QMap<QString,Album*> m_listAlbums;
    Settings * m_pConfiguration;
    ParserAlbum * m_pParser;
};

#endif // CONTROLLER_H