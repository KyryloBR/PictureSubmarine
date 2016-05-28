#ifndef IMAGE_H
#define IMAGE_H

#include <QObject>
#include <QImage>
#include <QString>
#include <QAbstractListModel>

class Image : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sourceImage READ sourceImage WRITE setSourceImage NOTIFY sourceImageChanged)
public:
    Image(const QString & _source = "", QObject *parent = 0);
    Image(const Image & instance);

    QString & sourceImage();
signals:
    void sourceImageChanged(QString&);

public slots:
    void setSourceImage(const QString & _source);

private:
    QString m_source;
};

#endif // IMAGE_H
