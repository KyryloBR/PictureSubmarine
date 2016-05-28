import QtQuick 2.0

Item {
     id:item;
     height:65;
     width:300
     Rectangle
     {
         id: rectangle1
         width: 300
         color: "#585050"
         radius: 22
         anchors.top: parent.top
         anchors.topMargin: -15
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 0
         anchors.right: parent.right
         anchors.rightMargin: 0
         anchors.left: parent.left
         anchors.leftMargin: 0
         border.color: "#591542"
         border.width: 3
         ButtonOpen
         {
             anchors.top: parent.top
             anchors.topMargin: 15
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 15
             anchors.left: parent.left
             anchors.leftMargin: 10
             anchors.right: parent.right
             anchors.rightMargin: 230
         }
         ButtonNext
         {
             anchors.top: parent.top
             anchors.topMargin: 15
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 15
             anchors.right: parent.right
             anchors.rightMargin: 10
             anchors.left: parent.left
             anchors.leftMargin: 230
         }
         ButtonPrevious
         {
             anchors.top: parent.top
             anchors.topMargin: 15
             anchors.bottom: parent.bottom
             anchors.bottomMargin: 15
             anchors.right: parent.right
             anchors.rightMargin: 120
             anchors.left: parent.left
             anchors.leftMargin: 120

         }
     }

}

