#include <QApplication>
#include <QQmlApplicationEngine>
#include <QMainWindow>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include <QJsonDocument>
#include <QDir>
#include "fileio.h"
#include "backend.h"

QJsonDocument loadJson(QString fileName) {
    QFile jsonFile(fileName);
    jsonFile.open(QFile::ReadOnly);
    return QJsonDocument().fromJson(jsonFile.readAll());
}

void saveJson(QJsonDocument document, QString fileName) {
    QFile jsonFile(fileName);
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(document.toJson());
}


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

    FileIO map;
    map.setSource("E:\\dev\\qml-dynamiclist\\data\\maps.json");  // this is a text file containing 2 maps
    data.setMapPanelData(map.read());
    return app.exec();
}
