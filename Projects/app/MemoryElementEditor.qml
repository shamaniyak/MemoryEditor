import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
	id: root
	property var memModel
	property var selected
	//property var memEditor

	onSelectedChanged: {
		showSelectedValue()
	}

	function showSelectedValue() {
		//console.debug("selected = ", selected)
		if(selected != null && selected.val != undefined)
			edit.showText(selected.val)
		else
			edit.showText("")
	}

	Connections {
		target: root.memModel
		onValueChanged: {
			if(me==selected)
				showSelectedValue()
		}
		onSelectedChanged: {
			doSave()
			selected = memModel ? memModel.selected : undefined
			//showSelectedValue()
		}
	}

	function doSave() {
		console.debug("doSave")
		timer.stop()
		if(selected) {
			if(memEditor)
				memEditor.setVal(selected, edit.text)
			else
				selected.val = edit.text
		}
	}

	Flickable {
		id: flick

		anchors.fill: parent
		contentWidth: edit.contentWidth
		contentHeight: edit.paintedHeight+20
		clip: true

		function ensureVisible(r)
		{
			if (contentX >= r.x)
				contentX = r.x;
			else if (contentX+width <= r.x+r.width)
				contentX = r.x+r.width-width;
			if (contentY >= r.y)
				contentY = r.y;
			else if (contentY+height <= r.y+r.height)
				contentY = r.y+r.height-height;
		}

		TextArea {
			id: edit
			focus: true
			width: flick.width
			//wrapMode: TextEdit.Wrap
			//anchors.fill: parent
			placeholderText: qsTr("Input value here")
			property bool canChange

			function showText(_text) {
				canChange = false
				text = _text
				canChange = true
			}

			onTextChanged: {
				console.debug("textChanged")
				if(canChange) {
					timer.stop()
					timer.start()
				}
			}

			onEditingFinished: {
				//doSave()
			}

			onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
		}
	}
	// Таймер для отложенного сохранения
	Timer {
		id: timer
		interval: 1000
		onTriggered: doSave()
	}
}
