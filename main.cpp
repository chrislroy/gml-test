#include <QApplication>
#include <QQmlApplicationEngine>
#include <QMainWindow>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include <QDir>
#include "fileio.h"
#include "backend.h"


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    Backend data;
    QQuickView view;

    view.rootContext()->setContextProperty("applicationData", &data);
    qDebug() << qApp->applicationDirPath() << "\n";
    view.setSource(QUrl::fromLocalFile(qApp->applicationDirPath() + "/qml/main.qml"));
    view.show();
    // data.setMap("E:\\dev\\qml-dynamiclist\\data\\b71d55ae-543c-490c-b660-b0dd16800763.json");
    data.setMap("E:\\dev\\qml-dynamiclist\\data\\maps.json");
    return app.exec();
}
