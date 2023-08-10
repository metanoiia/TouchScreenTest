import QtQuick 2.0
import QtQuick.Window 2.2

Column{
    property bool enlargedCells: false
    property int scaller: 3

    property int countInHeight_p: 90
    property int countInWidth_p: 160

    property int cellSize_p : enlargedCells? scaller * 20 : 20

    property int mode_p: Main.Modes.Normal

    Repeater{
        model: countInHeight_p
        Row{
            Repeater{
                model: countInWidth_p
                TouchCell{
                    width_p: cellSize_p
                    height_p: cellSize_p
                    parentMode_p: mode_p
                }
            }
        }
    }
}
