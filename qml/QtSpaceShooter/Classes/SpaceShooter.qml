import QtQuick 2.0

Rectangle {
    id: root
    anchors.fill: parent
    property var game : null
    Background{

    }

    Item {
        id: startLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        SpaceLabel{
            text: qsTr("Start Game")
            font.pixelSize: 40
            x : - (width/ 2)

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("clicked")
                    startLabel.visible = false
                    startGame()
                }
            }
        }

        SpaceLabel{
            text: qsTr("QtSpaceShooter!")
            font.pixelSize: 40
            y : -height
            x : - (width/ 2)
        }

    }

   Item {
        id: endLabel
        property int score
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        SpaceLabel{
            text: qsTr("Game Over")
            font.pixelSize: 40
            x : - (width/ 2)

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("clicked")
                    startLabel.visible = true
                    endLabel.visible = false
                }
            }
        }

        SpaceLabel{
            text: qsTr("End score: " + endLabel.score)
            font.pixelSize: 40
            y : -height
            x : - (width/ 2)
        }


    }

    function startGame(){
        var component = Qt.createComponent("Game.qml");
        game = component.createObject(parent, {});
        game.gameOver.connect(endGame)
    }

    function endGame(game){
        endLabel.score = game.ship.point
        game.destroy()
        endLabel.visible = true
    }

    Component.onDestruction: {
        console.log("on destruction")
        if(game != null){
            game.destroy()
        }
    }
}
