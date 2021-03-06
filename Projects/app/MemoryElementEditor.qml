﻿import QtQuick 2.10
import QtQuick.Controls 2.3

Item {
    property var memModel
    property var selected: memModel ? memModel.selected : null

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

            onTextChanged: {

            }

            onEditingFinished: {
                doSave()
            }

            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)

            function doSave() {
                if(selected)
                    selected.val = text
            }
        }
    }

    onSelectedChanged: {
        edit.text = selected ? selected.val ? selected.val : "" : ""
    }
}
