import QtQuick 2.7
import QtQuick.Controls 1.4

TreeView {
    id: root
    anchors.fill: parent

    TableViewColumn {
        title: "Name"
        role: "display"
        width: 200
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: {
            if(mouse.button == Qt.RightButton)
                treeMenu.popup()
            mouse.accepted = false
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

        MenuItem {
            action: clearAction
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

    Action {
        id: clearAction
        text: qsTr("&Clear")
        onTriggered: {
            mem.clear()
        }
    }
}
