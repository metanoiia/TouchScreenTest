import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window{
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Touch Screen Test")

    visibility: ApplicationWindow.FullScreen

    signal globalPositionChanged(var item, var position)

    enum Modes{
        Normal,
        Enlarged,
        Giant,
        Drawing
    }

    property int currentMode: Main.Modes.Normal

    StackView {
        id: stack
        initialItem: normalMode
        anchors.fill: parent
    }

    Item {
        id: mainItem
        width: parent.width
        height: parent.height

        focus: true

        Keys.onEscapePressed: Qt.quit()
        Keys.onDigit1Pressed: setNormalAsActiveMode()
        Keys.onDigit2Pressed: setEnlargeAsActiveMode()
        Keys.onDigit3Pressed: setGiantAsActiveMode()
        Keys.onDigit4Pressed: setDrawingAsActiveMode()


        CellGrid{
            id: normalMode
            mode_p: Main.Modes.Normal
        }

        CellGrid{
            id: enlargedMode
            enlargedCells: true

            visible: false
            mode_p: Main.Modes.Enlarged
        }

        CellGrid{
            id: giantMode
            enlargedCells: true
            scaller: enlargedMode.scaller * 3

            visible: false
            mode_p: Main.Modes.Giant
        }

        Drawing{
            id: drawingMode
        }


        function setGiantAsActiveMode(){
            stack.replace(giantMode)

            root.currentMode = Main.Modes.Giant
        }

        function setEnlargeAsActiveMode(){
            stack.replace(enlargedMode)

            root.currentMode = Main.Modes.Enlarged
        }

        function setNormalAsActiveMode(){
            stack.replace(normalMode)

            root.currentMode = Main.Modes.Normal
        }

        function setDrawingAsActiveMode(){
            stack.replace(drawingMode)

            root.currentMode = Main.Modes.Drawing
        }
    }

    function toLocalePosition(toItem, fromItem, position) {
        // return the local position if inside item, or null if outside
        var localPos = toItem.mapFromItem(fromItem, position.x, position.y)
        if (localPos.x >= 0
                && localPos.y >= 0
                && localPos.x <= toItem.width
                && localPos.y <= toItem.height) {
            return localPos
        }
        return null
    }


}



