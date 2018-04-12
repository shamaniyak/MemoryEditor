import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Window 2.2
import MemoryManager 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Memory Editor")

    Component.onCompleted: {
        mem.add(0, "1");
        mem.add(0, "2");
    }

    Memory {
        id: mem
    }

    MemoryModel {
        id: memModel
        memory: mem
    }

    MemoryTreeView {
        id: treeView
        anchors.fill: parent
        model: memModel
    }
}
