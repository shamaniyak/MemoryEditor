#include "testmemory.h"
#include "Memory/qmemorymodel.h"

#include <QtTest>

TestMemory::TestMemory(QObject *parent) : QObject(parent)
{

}

void TestMemory::testCreateMemory()
{
  std::shared_ptr<QMemoryModel> spM = std::make_shared<QMemoryModel>();
  QVERIFY2(spM, "QMemoryModel constructor fail.");
}

void TestMemory::testTopMe()
{
  QMemoryModel memory;
  MEWrapper me = memory.getME();
  QCOMPARE(me.getMem(), &memory);
  QVERIFY(!me.isNull());
  QVERIFY(me);
  QCOMPARE(me.name(), "");
}

void TestMemory::testMEWrapper()
{
  QMemoryModel memory;
  //MEWrapper me = memory.getME().add("new");
  MEWrapper me = memory.add(MEWrapper(), "new");
  QCOMPARE(me.name(), "new");
}

#if defined(RAN_AS_TEST)
QTEST_MAIN(TestMemory)
#endif
#include "moc_testmemory.cpp"
