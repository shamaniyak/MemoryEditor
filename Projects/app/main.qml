import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3
import MemoryManager 1.0

ApplicationWindow {
	visible: true
	width: 640
	height: 480
	title: qsTr("Memory Editor")
	property string appDirPath
	menuBar: MainMenu {
		editorActions: editor.actions
	}

	// Модель
	MemoryModel {
		id: memModel
	}

	// Редактор
	MemoryEditor {
		id: editor
		memModel: memModel
	}

	// Диалог сохранения
	MessageDialog {
		id: messageDialog
		text: "The memory has been modified."
		informativeText: "Do you want to save your changes?"
		standardButtons: MessageDialog.Save | MessageDialog.Discard | MessageDialog.Cancel
		onAccepted: {
			if(memModel.save())
				console.log("Memory saved.")
			Qt.quit()
		}
		onDiscard: {
			Qt.quit()
		}
	}

	Component.onCompleted: {
		//console.log()
		appDirPath = app.applicationDirPath()
		memModel.open(appDirPath + "/memory.moi")
	}

	onClosing: {
		if(memModel.changed()) {
			close.accepted = false
			messageDialog.open()
		}
	}
}
