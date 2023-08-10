import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow{
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
        Giant
    }

    property int currentMode: Main.Modes.Normal

    Item {
        id: mainItem
        width: parent.width
        height: parent.height

        focus: true

        Keys.onEscapePressed: Qt.quit()
        Keys.onDigit1Pressed: setNormalAsActiveMode()
        Keys.onDigit2Pressed: setEnlargeAsActiveMode()
        Keys.onDigit3Pressed: setGiantAsActiveMode()

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


        function setGiantAsActiveMode(){
            normalMode.visible = false
            enlargedMode.visible = false
            giantMode.visible = true

            root.currentMode = Main.Modes.Giant
        }

        function setEnlargeAsActiveMode(){
            normalMode.visible = false
            enlargedMode.visible = true
            giantMode.visible = false

            root.currentMode = Main.Modes.Enlarged
        }

        function setNormalAsActiveMode(){
            normalMode.visible = true
            enlargedMode.visible = false
            giantMode.visible = false

            root.currentMode = Main.Modes.Normal
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


