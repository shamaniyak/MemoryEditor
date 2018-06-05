import QtQuick 2.10
import QtQuick.Layouts 1.3

Item {
	id: editor
	anchors.fill: parent
	property var memModel
	readonly property var actions: meActions

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
				actions: MemoryEditorActions {
					id: meActions
					memModel: editor.memModel
					treeView: treeView
				}
			}

			onNameChanged: {
				var me = model.getMeByIndex(index)
				if(me)
					me.name = newName
			}

			onClicked: {
				var me = model.getMeByIndex(index)
				model.selected = me
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
