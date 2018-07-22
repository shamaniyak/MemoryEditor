#ifndef MYAPP_H
#define MYAPP_H

#include <QObject>

#include <Memory/qmemorymodel.h>

class MyApp : public QObject
{
  Q_OBJECT
  Q_PROPERTY(MemoryWrapper* mem READ getMem WRITE setMem NOTIFY memChanged)
public:
  explicit MyApp(QObject *parent = nullptr);

  MemoryWrapper *getMem() const;
  void setMem(MemoryWrapper *mem);

signals:
  void memChanged();

public slots:
  QString applicationDirPath() const;
  QString urlToNativeFilePath(const QString &filePath);

private:
  MemoryWrapper *m_mem = 0;
};

#endif // MYAPP_H
