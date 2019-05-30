#include <QApplication>
#include <QQmlApplicationEngine>
#include <QMainWindow>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include "fileio.h"
#include "backend.h"
#include "softcostpanel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    // qmlRegisterType<Backend>("Backend", 1, 0, "Backend");
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

    // auto* panel = new SoftCostPanel(&engine);


    view.rootContext()->setContextProperty("applicationData", &data);

    view.setSource(QUrl::fromLocalFile("qml/main.qml"));
    view.show();

    // panel->show();

    return app.exec();
}
