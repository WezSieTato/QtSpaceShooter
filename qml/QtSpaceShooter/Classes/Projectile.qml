import QtQuick 2.0

SpaceObject {
    z: 1
    id: root
    property bool toRight : true
    property int velocity : 3
    property string source

    width: image.width
    height: image.height

    Image {
        id: image
        source: root.source
    }

    Component.onCompleted: {
        animation.to =  (toRight ? parent.width : (-root.width))
        animation.duration = Math.abs(animation.to - root.x ) * velocity
        animation.running = true
        animation.start();
    }

    NumberAnimation on x{
        id: animation
        running: false
    }


}
