#include "memorymanager_plugin.h"
#include "memorymanager.h"

#include <qqml.h>

void MemoryManagerPlugin::registerTypes(const char *uri)
{
    // @uri memorymanagerplugins
    qmlRegisterType<MemoryManager>(uri, 1, 0, "MemoryManager");
}

