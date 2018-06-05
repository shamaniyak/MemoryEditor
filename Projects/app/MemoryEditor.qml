import QtQuick 2.0

Item {
	id: editor
	anchors.fill: parent
	property var memModel
	readonly property var actions: meActions

	// Вид для модели
	MemoryTreeView {
		id: treeView
		anchors.fill: parent
		model: editor.memModel
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
	}
}
