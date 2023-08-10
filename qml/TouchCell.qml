import QtQuick 2.0

Rectangle {

    property int width_p : 20
    property int height_p : 20
    property int parentMode_p: 1

    width: width_p
    height: height_p

    color: "cornsilk"
    border.color: "darkgrey"

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        hoverEnabled: true

        onReleased:{
            parent.color = "forestgreen"
        }

        onPressed:{
            parent.color = "crimson"
        }

        onPositionChanged: {
            globalPositionChanged(parent, mouse)
        }

        Component.onCompleted: {
            globalPositionChanged.connect(handlePositionChange)
        }

        function handlePositionChange(item, position) {
            var localPos = toLocalePosition(parent, item, position)
            if (localPos) {
                // we are in the rect
                if(position.buttons && root.currentMode === parent.parentMode_p)
                    parent.color = "forestgreen"

            }
        }
    }
}

