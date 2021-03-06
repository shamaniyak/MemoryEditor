﻿import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
    property var memModel
    property var treeView
    property var memEditor

    // addAction
    property Action addAction: Action {
        id: addAction
        text: qsTr("&Add")
        onTriggered: {
            var me = memModel.getMeByIndex(treeView.currentIndex)
			memEditor.add(me, "new", false);
            //memModel.add(me, "new")
        }
    }
    // removeAction
    property Action removeAction: Action {
        id: removeAction
        text: qsTr("&Del")
        onTriggered: {
            var me = memModel.getMeByIndex(treeView.currentIndex)
            memEditor.deleteMe(me)
            //memModel.deleteMe(me)
        }
    }
    // clearAction
    property Action clearAction: Action {
        id: clearAction
        text: qsTr("&Clear")
        onTriggered: {
            //var me = memModel.getMeByIndex(treeView.currentIndex)
            memEditor.clear()
        }
    }
    // undoAction
    property Action undoAction: Action {
        id: undoAction
        text: qsTr("&Undo")
        enabled: memEditor.canUndo
        onTriggered: {
            memEditor.undo()
        }
    }
    // redoAction
    property Action redoAction: Action {
        id: redoAction
        text: qsTr("&Redo")
        enabled: memEditor.canRedo
        onTriggered: {
            memEditor.redo()
        }
    }
}
