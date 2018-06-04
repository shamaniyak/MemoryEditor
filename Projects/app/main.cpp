#include "myapp.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    MyApp myApp;

    qmlRegisterUncreatableType<MyApp>("MyApp", 1, 0, "MyApp", "Can't creat MyApp");

    QQmlApplicationEngine engine;
    engine.addImportPath(qApp->applicationDirPath() + "/qml");
    engine.rootContext()->setContextProperty("app", &myApp);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
