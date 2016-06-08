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
    Q_INVOKABLE int width();
    Q_INVOKABLE int height();
    Q_INVOKABLE int x();
    Q_INVOKABLE int y();

    Q_INVOKABLE QString albumPath();
    Q_INVOKABLE QString currentAlbumFile();

signals:
    void widthChanged(int);
    void heightChanged(int);
    void xChanged(int);
    void yChanged(int);

    void albumPathChanged(QString);
    void currentAlbumFileChanged(QString);

public slots:
    Q_INVOKABLE void setWidth(int _width);
    Q_INVOKABLE void setHeight(int _height);
    Q_INVOKABLE void setX(int _x);
    Q_INVOKABLE void setY(int _y);

    Q_INVOKABLE void setAlbumPath(const QString & _path);
    Q_INVOKABLE void setCurrentAlbumFile(const QString & _file);


private:
    void initialDefaults();

    QSettings * m_configuration;
    QMap<QString,QString> m_defaults;
};

#endif // SETTINGS_H
