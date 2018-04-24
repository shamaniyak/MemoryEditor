import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Window 2.2
import MemoryManager 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Memory Editor")
    property string appDirPath

    Component.onCompleted: {
        //console.log()
        appDirPath = app.applicationDirPath()
        memModel.open(appDirPath + "/memory.moi")
    }

    // memModel
    MemoryModel {
        id: memModel
    }

    // treeView
    MemoryTreeView {
        id: treeView
        anchors.fill: parent
        model: memModel
    }

    // mouseArea
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: {
            if(mouse.button == Qt.RightButton)
                treeMenu.popup()
            mouse.accepted = false
        }
    }

    // treeMenu
    Menu {
        id: treeMenu

        MenuItem {
            id: menuItemAdd
            action: addAction
            implicitHeight: 25
        }

        MenuItem {
            id: menuItemDel
            action: removeAction
            implicitHeight: 25
        }

        MenuItem {
            action: clearAction
            implicitHeight: 25
        }
    }

    // addAction
    Action {
        id: addAction
        text: qsTr("&Add")
        onTriggered: {
            memModel.add(memModel.selected, "new")
        }
    }
    // removeAction
    Action {
        id: removeAction
        text: qsTr("&Del")
        onTriggered: {
            memModel.del('new')
        }
    }
    // clearAction
    Action {
        id: clearAction
        text: qsTr("&Clear")
        onTriggered: {
            memModel.clear()
        }
    }
}
