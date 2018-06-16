#include "myapp.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <memory>

void test() {
  std::weak_ptr<int> wp;
  {
    std::shared_ptr<int> sp(new int(123));
    wp = sp;
  }
  if(auto sp1 = wp.lock())
    qDebug() << *sp1.get();

}

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    MyApp myApp;

    //test();

    qmlRegisterUncreatableType<MyApp>("MyApp", 1, 0, "MyApp", "Can't creat MyApp");

    QQmlApplicationEngine engine;
    engine.addImportPath(qApp->applicationDirPath() + "/qml");
    engine.rootContext()->setContextProperty("app", &myApp);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
