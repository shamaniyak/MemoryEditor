import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.3
import QtQuick.Window 2.2
import MemoryManager 1.0

Window {
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

    TreeView {
        id: memTree
        anchors.fill: parent
        model: memModel

        TableViewColumn {
            title: "Name"
            role: "display"
            width: 200
        }

        onClicked: {
            treeMenu.popup()
        }
    }

    Menu {
        id: treeMenu

        MenuItem {
            id: menuItemAdd
            action: addAction
        }

        MenuItem {
            id: menuItemDel
            action: delAction
        }
    }

    Action {
        id: addAction
        text: qsTr("&Add")
        onTriggered: {
            mem.add(mem.selected, "new")
        }
    }

    Action {
        id: delAction
        text: qsTr("&Del")
        onTriggered: {
            mem.del('new')
        }
    }
}
