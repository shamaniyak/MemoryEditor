#include "testmemory.h"
#include "Memory/qmemorymodel.h"

#include <QtTest>

static QMemoryModel memory;

TestMemory::TestMemory(QObject *parent) : QObject(parent)
{

}

void TestMemory::testTopMe()
{
    MEWrapper me = memory.getME();
    QCOMPARE(me.getMem(), &memory);
}

#if defined(RAN_AS_TEST)
QTEST_MAIN(TestMemory)
#endif
#include "moc_testmemory.cpp"
