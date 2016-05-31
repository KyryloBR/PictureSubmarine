#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>
#include <QMap>

class Settings : public QObject
{
    Q_OBJECT
public:
    Settings(QObject *parent = 0);
    int width();
    int height();
    int x(); //sss
    int y();

    QString albumPath();
    QString currentAlbumFile();

    bool isCurrent();
signals:
    void widthChanged(int);
    void heightChanged(int);
    void xChanged(int);
    void yChanged(int);

    void albumPathChanged(QString);
    void currentAlbumFileChanged(QString);

    void currentChanged(bool);

public slots:
    void setWidth(int _width);
    void setHeight(int _height);
    void setX(int _x);
    void setY(int _y);

    void setAlbumPath(const QString & _path);
    void setCurrentAlbumFile(const QString & _file);

    void setCurrent(bool _current);

private:
    QSettings * m_configuration;
};

#endif // SETTINGS_H
