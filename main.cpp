#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "album.h"
#include "controller.h"
#include <QList>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("Shaman");
    app.setApplicationName("Picture Sumarine");
    app.setApplicationVersion("0.1");

    QQmlApplicationEngine engine;
    Album * album = new Album();
    album->append("D:/Download/1.jpg");
    album->setCurrentIndex(0);
    Controller * pControl = new Controller;
    Q_UNUSED(pControl)
    engine.rootContext()->setContextProperty("photo",album->currentImage());
    engine.rootContext()->setContextProperty("album",album);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    engine.rootContext()->setContextProperty("PhotoModel",QVariant::fromValue(album->getModel()));

    return app.exec();
}

