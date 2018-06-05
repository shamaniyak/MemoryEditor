import QtQuick 2.0
import QtQuick.Controls 2.3

MenuBar {
	property var actions

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

	onActionsChanged: {

	}
}
