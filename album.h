#ifndef ALBUM_H_
#define ALBUM_H_

#include <QObject>
#include "image.h"

class Album : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Image* currentImage READ currentImage NOTIFY currentImageChanged)
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
public:
    Album(QObject *parent = 0);
    Album(const Album & instance);
    Album(QStringList & listImages, QString _currentImage);

    Image *currentImage();
    int currentIndex();
    Q_INVOKABLE QList<QObject *> getModel();
    Q_INVOKABLE int indexByImage(Image * _image);
    QString name();
    Q_INVOKABLE int countImage();
    Image * imageByIndex(int index);
signals:
    void currentImageChanged(Image*);
    void currentIndexChanged(int);
    void nameChanged(QString);

public slots:
    void setCurrentImage(int index);
    void setCurrentIndex(int index);
    void next();
    void previous();
    void append(Image * _image);
    void append(const QString & _source);
    void addAfter(int index, Image * _image);
    void addAfter(int index, const QString & _source);
    void addBefore(int index, Image * _image);
    void addBefore(int index, const QString &_source);
    void move(int from, int to);
    void setName(const QString & _name);
    void remove(int index);

private:
    Image * m_pCurrentImage;
    QList<Image*> m_imageList;
    int m_currentIndex;
    QString m_name;

};

#endif // ALBUM_H_
