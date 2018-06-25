#ifndef TESTMEMORY_H
#define TESTMEMORY_H

#include <QObject>

class TestMemory : public QObject
{
    Q_OBJECT
public:
    explicit TestMemory(QObject *parent = nullptr);

signals:

private slots:
  void testCreateMemory();
    void testTopMe();
    void testMEWrapper();
};

#endif // TESTMEMORY_H
