import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import MemoryManager 1.0

Item {
	property var memModel
	property var mainWindow
	// actionNew
	property Action actionNew: Action {
		id: actionNew
		text: qsTr("New")
		onTriggered: {
			memModel.filePath = ""
			memModel.clear()
		}
	}

	// actionOpen
	property Action actionOpen: Action {
		id: actionOpen
		text: qsTr("Open")
		onTriggered: {
			fileDialog.open()
		}
	}

	// actionSave
	property Action actionSave: Action {
		id: actionSave
		text: qsTr("Save")
		onTriggered: {
			memModel.save()
		}
	}

	// actionSaveAs
	property Action actionSaveAs: Action {
		id: actionSaveAs
		text: qsTr("Save As")
		onTriggered: {
			fileDialog
			memModel.save()
		}
	}

	// actionQuit
	property Action actionQuit: Action {
		id: actionQuit
		text: qsTr("Quit")
		onTriggered: {
			mainWindow.close()
		}
	}

	FileDialog {
		id: fileDialog
		title: "Please choose a file"
		folder: app.applicationDirPath()
		onAccepted: {
			//console.log("You chose: " + fileDialog.fileUrls)
			var filePath = app.urlToNativeFilePath(fileDialog.fileUrl)
			console.log("You chose: " + filePath)
			memModel.open(filePath)
		}
		onRejected: {
			console.log("Canceled")
		}
	}

	FileDialog {
		id: fileSaveDialog
		selectExisting: false
		title: "Please enter a file"
		folder: app.applicationDirPath()
		onAccepted: {
			console.log("You chose: " + fileDialog.fileUrl)
			memModel.open(fileDialog.fileUrl)
		}
		onRejected: {
			console.log("Canceled")
		}
	}
}
