#include <QApplication>
#include <QQmlApplicationEngine>
#include <QMainWindow>
#include <QString>
#include "fileio.h"
#include "softcostpanel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
//    engine.load(url);

//    QMainWindow mainWindow;
//    mainWindow.show();
    auto* panel = new SoftCostPanel(&engine);
    panel->show();

    return app.exec();
}
