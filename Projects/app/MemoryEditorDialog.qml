import QtQuick 2.10
import QtQuick.Layouts 1.3
import MemoryManager 1.0

Item {
	id: editor
	anchors.fill: parent
	property var memModel
	//readonly property var actions: meActions

	// Редактор для памяти (набор команд)
	MemoryEditor {
		id: memEditor
		mem: memModel
	}

	property MemoryEditorActions actions: MemoryEditorActions {
		id: meActions
		memModel: editor.memModel
		treeView: treeView
		memEditor: memEditor
	}

	GridLayout {
		anchors.fill: parent
		columns: 2
		//rows: 1
		// Вид для модели
		MemoryTreeView {
			id: treeView
			model: editor.memModel
			Layout.fillHeight: true
			// Контекстное меню для дерева
			treeMenu: TreePopupMenu {
				id: treeMenu
				actions: editor.actions
			}

			onNameChanged: {
				var me = model.getMeByIndex(index)
				if(me)
					me.name = newName
				me = undefined
			}

			onClicked: {
				var me = model.getMeByIndex(index)
				model.selected = me
				me = undefined
			}
		}

		// Редактор значения элемента
		MemoryElementEditor {
			id: meEditor
			memModel: editor.memModel
			Layout.fillHeight: true
			Layout.fillWidth: true
		}
	}
}
