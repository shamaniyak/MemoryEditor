#include "memorymanager_plugin.h"
#include "memorymanager.h"
#include "Memory/memorywrapper.h"
#include "Memory/qmemorymodel.h"

#include <qqml.h>

void MemoryManagerPlugin::registerTypes(const char *uri)
{
    // @uri memorymanagerplugins
    qmlRegisterType<MemoryManager>(uri, 1, 0, "MemoryManager");

    qmlRegisterType<MemoryWrapper>(uri, 1, 0, "Memory");
    qmlRegisterType<QMemoryModel>(uri, 1, 0, "MemoryModel");
}

