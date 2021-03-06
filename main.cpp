#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "album.h"
#include "controller.h"
#include <QList>
#include <QIcon>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("Shaman");
    app.setApplicationName("Picture Sumarine");
    app.setApplicationVersion("0.1");

    QQmlApplicationEngine engine;
    Controller * pControl = new Controller;
    engine.rootContext()->setContextProperty("controler",pControl);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

