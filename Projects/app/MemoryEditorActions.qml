import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
    property var memModel
    property var treeView



    // addAction
    property Action addAction: Action {
        id: addAction
        text: qsTr("&Add")
        onTriggered: {
            var me = memModel.getMeByIndex(treeView.currentIndex)
            memModel.add(me, "new")
        }
    }
    // removeAction
    property Action removeAction: Action {
        id: removeAction
        text: qsTr("&Del")
        onTriggered: {
            var me = memModel.getMeByIndex(treeView.currentIndex)
            memModel.deleteMe(me)
        }
    }
    // clearAction
    property Action clearAction: Action {
        id: clearAction
        text: qsTr("&Clear")
        onTriggered: {
            memModel.clear()
        }
    }
}
