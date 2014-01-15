import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id : root
   property string name
    signal stopped(var this_)

   Audio {
       id : audio
   source: "../Resources/Sounds/" + name + ".mp3"
   autoLoad: true
   autoPlay: false
   onStopped: root.stopped.call(root, root)
   }

   function play(){
       audio.play()
   }

}
