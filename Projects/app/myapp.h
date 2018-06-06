#ifndef MYAPP_H
#define MYAPP_H

#include <QObject>

class MyApp : public QObject
{
  Q_OBJECT
public:
  explicit MyApp(QObject *parent = nullptr);

signals:

public slots:
  QString applicationDirPath() const;
  QString urlToNativeFilePath(const QString &filePath);
};

#endif // MYAPP_H
