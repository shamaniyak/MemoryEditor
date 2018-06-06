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
			if(memModel.changed())
				messageDialog.open()
			else {
				createNew()
			}
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
			fileSaveDialog.open()
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
		signal saved()
		onAccepted: {
			//console.log("You chose: " + fileSaveDialog.fileUrl)
			var filePath = app.urlToNativeFilePath(fileSaveDialog.fileUrl)
			console.log("You chose: " + filePath)
			memModel.filePath = filePath
			memModel.save()
			saved()
		}
		onRejected: {
			console.log("Canceled")
			saved()
		}
	}

	// Диалог сохранения
	MessageDialog {
		id: messageDialog
		text: "The memory has been modified."
		informativeText: "Do you want to save your changes?"
		standardButtons: MessageDialog.Save | MessageDialog.Discard | MessageDialog.Cancel
		onAccepted: {
			if(memModel.filePath === "") {
				fileSaveDialog.saved.connect(saved)
				fileSaveDialog.open()
			}
			else
				if(memModel.save())
					console.log("Memory saved.")
			createNew()
		}
		onDiscard: {
			createNew()
		}

		function saved() {
			createNew()
		}
	}

	function createNew() {
		memModel.filePath = ""
		memModel.clear()
	}
}
