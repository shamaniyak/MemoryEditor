#include "myapp.h"

#include <QDir>
#include <QGuiApplication>
#include <QUrl>

MyApp::MyApp(QObject *parent) : QObject(parent)
{

}

QString MyApp::applicationDirPath() const
{
  return QGuiApplication::applicationDirPath();
}

QString MyApp::urlToNativeFilePath(const QString &filePath)
{
  auto fName = filePath;
  QUrl url(fName);
  if(url.isLocalFile()) {
    fName = url.toLocalFile();
    fName = QDir::toNativeSeparators(fName);
    //qDebug() << fName;
  }
  return fName;
}

MemoryWrapper *MyApp::getMem() const
{
  return m_mem;
}

void MyApp::setMem(MemoryWrapper *mem)
{
  m_mem = mem;
  emit memChanged();
}
