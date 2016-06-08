#ifndef CONTROLLER_H
#define CONTROLLER_H

#define SETTING_PATH "Setting.xml"
#define SET_SETTING_PATH(setting) (SETTING_PATH = setting)

#include <QObject>
#include "album.h"
#include "settings.h"
#include <QMap>
#include "parseralbum.h"
#include "currentalbumcontroller.h"
#include <QList>

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Album* currentAlbum READ currentAlbum NOTIFY currentAlbumChanged)
    Q_PROPERTY(Settings* configuration READ configuration NOTIFY configurationChanged)
public:
    Controller(QObject *parent = 0);

    Album * currentAlbum();
    QString currentId();
    Settings * configuration();
    Q_INVOKABLE QList<QObject *> getModelAlbum();
signals:
    void currentAlbumChanged(Album*);
    void currentIdChanged(QString);
    void configurationChanged(Settings*);

public slots:
    void setCurrentIndex(int index);
    void setCurrentAlbum(const QString & _id);
    void addImageToAlbum(const QString & _id, Image * _image);
    void addImageToAlbum(const QString & _id,const QString & _image);
    void addImages(QList<QUrl> _files);
    void addImageToCurrentAlbum(Image * _image);
    void addImageToCurrentAlbum(const QString & _source);
    void addAlbum(const QString & _id, Album * _newAlbum);
    void addAlbum(const QString & _id);
    void loadAlbums();
    void writeCurrentImageInAlbum(int index);
    void createCurrentAlbum(QString _dir, QString _currentImage);
    void removePush(int index);
    void removePop(int index);
    void removeSelected();

private:
    Album * m_pCurrentAlbum;
    QString m_currentId;
    QMap<QString,Album*> m_listAlbums;
    Settings * m_pConfiguration;
    ParserAlbum * m_pParser;
    CurrentAlbumController * m_pCurrentCtrl;
    QList<int> m_removedIndex;
};

#endif // CONTROLLER_H
