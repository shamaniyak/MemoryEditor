import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
	property var memModel
	property var selected: memModel ? memModel.selected : null

	TextArea {
		id: edit
		anchors.fill: parent
		placeholderText: "Input value here"

		onTextChanged: {
			if(selected)
				selected.val = text
		}
	}

	onSelectedChanged: {
		edit.text = selected ? selected.val : ""
	}
}
