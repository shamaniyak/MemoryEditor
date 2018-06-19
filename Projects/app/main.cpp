#include "myapp.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include <memory>
void test() {
    std::shared_ptr<int> x(new int(5));
    {
        std::shared_ptr<int> x1(x.get());
        qDebug() << *x1;
    }
    qDebug() << *x;
}

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    MyApp myApp;

    test();

    qmlRegisterUncreatableType<MyApp>("MyApp", 1, 0, "MyApp", "Can't creat MyApp");

    QQmlApplicationEngine engine;
    engine.addImportPath(qApp->applicationDirPath() + "/qml");
    engine.rootContext()->setContextProperty("app", &myApp);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
