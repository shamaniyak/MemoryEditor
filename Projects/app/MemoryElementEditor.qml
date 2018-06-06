import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
	property var memModel
	property var selected: memModel ? memModel.selected : null

	TextArea {
		id: edit
		anchors.fill: parent
		placeholderText: qsTr("Input value here")

		onTextChanged: {
			if(selected)
				selected.val = text
		}
	}

	onSelectedChanged: {
		console.log(selected)
		edit.text = selected ? selected.val ? selected.val : "" : ""
	}
}
