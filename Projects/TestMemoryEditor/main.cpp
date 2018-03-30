#include "mainwindow.h"
#include <QApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlComponent>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QQmlApplicationEngine engine;
//    QQmlComponent component(&engine);
//    component

    MainWindow w;
    w.show();

    return a.exec();
}
