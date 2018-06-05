import QtQuick 2.0
import QtQuick.Controls 2.3

MenuBar {
	property var editorActions

	Menu {
		id: menu
		title: qsTr("&File")
		Action { text: qsTr("&New...") }
		Action { text: qsTr("&Open...") }
		Action { text: qsTr("&Save") }
		Action { text: qsTr("Save &As...") }
		MenuSeparator { }
		Action { text: qsTr("&Quit") }
	}

	Menu {
		id: editorMenu
		title: qsTr("&Edit")
	}

	onEditorActionsChanged: {
		editorMenu.addAction(editorActions.addAction)
		editorMenu.addAction(editorActions.removeAction)
		editorMenu.addAction(editorActions.clearAction)
	}
}
