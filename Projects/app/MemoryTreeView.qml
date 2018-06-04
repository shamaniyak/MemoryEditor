import QtQuick 2.10
import QtQuick.Controls 1.4

TreeView {
    id: tree
    anchors.fill: parent

    TableViewColumn {
        id: firstColumn
        title: "Name"
        role: "display"
        width: 200

        delegate: itemDelegate
    }

    onDoubleClicked: {
        //firstColumn.delegate = itemDelegate.createObject(firstColumn)
    }

    Component {
        id: itemDelegate
        Item {
            Text {
                anchors { verticalCenter: parent.verticalCenter; left: parent.left }
                //color: styleData.textColor
                //elide: styleData.elideMode
                text: styleData.value
            }

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: {
                    mouse.accepted = false
                }

                onDoubleClicked: {
                    //console.log("onDoubleClicked")
                    nameEditor.visible = true
                    nameEditor.forceActiveFocus()
                }
            }

            TextField {
                id: nameEditor
                anchors.fill: parent
                visible: false
                text: styleData.value

                onEditingFinished: {
                    var me = tree.model.getMeByIndex(tree.currentIndex)
                    me.name = text
                    visible = false
                }
            }
        }
    }
}
