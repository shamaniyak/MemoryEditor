#include "myapp.h"

#include <QGuiApplication>

MyApp::MyApp(QObject *parent) : QObject(parent)
{

}

QString MyApp::applicationDirPath() const
{
  return QGuiApplication::applicationDirPath();
}
