﻿import QtQuick 2.10
import QtQuick.Controls 1.4

TreeView {
	id: tree
	//anchors.fill: parent
	property var treeMenu

	signal nameChanged(var index, var newName)

	TableViewColumn {
		id: firstColumn
		title: "Name"
		role: "display"
		width: 200

		delegate: itemDelegate
	}

	// Область мыши
	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onPressed: {
			showPopupMenu(mouse)
			mouse.accepted = false
		}

		function showPopupMenu(mouse) {
			if(mouse.button === Qt.RightButton) {
				treeMenu.popup()
				return true
			}
			return false
		}
	}

	Component {
		id: itemDelegate
		Item {
			property var editor

			Text {
				anchors { verticalCenter: parent.verticalCenter; left: parent.left }
				//color: styleData.textColor
				//elide: styleData.elideMode
				text: styleData.value
			}

			TextField {
				id: nameEditor
				anchors.fill: parent
				visible: false
				text: styleData.value

				Connections {
					target: tree
					onDoubleClicked: {
						//firstColumn.delegate = itemDelegate.createObject(firstColumn)
						nameEditor.visible = true
						nameEditor.forceActiveFocus()

					}
				}

				onEditingFinished: {
					tree.nameChanged(tree.currentIndex, text)
					visible = false
				}
			}
		}
	}

	onDoubleClicked: {
		//firstColumn.delegate = itemDelegate.createObject(firstColumn)
	}
}
