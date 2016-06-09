import QtQuick 2.0

Item {
     id:item;
     height:65;
     width:600

     function setTitleCurrentAlbum(_title)
     {
        title.setTitle(_title);
     }

     Rectangle
     {
         id: rectangle1
         width: 600
         color: "#ffffff"
         radius: 20
         anchors.top: parent.top
         anchors.topMargin: -15
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 0
         anchors.right: parent.right
         anchors.rightMargin: 0
         anchors.left: parent.left
         anchors.leftMargin: 0
         border.color: "#591542"
         border.width: 2
         ButtonOpen
         {
             y: 15
             height: 50
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.left
             anchors.leftMargin: 540
             anchors.right: parent.right
             anchors.rightMargin: 10
         }
         ButtonNext
         {
             y: 15
             height: 50
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.left
             anchors.leftMargin: 385
             anchors.right: parent.right
             anchors.rightMargin: 165
         }
         ButtonPrevious
         {
             y: 15
             height: 50
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.left
             anchors.leftMargin: 165
             anchors.right: parent.right
             anchors.rightMargin: 385

         }
         ButtonAlbumsOpen
         {
             y: 15
             height: 50
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.left
             anchors.leftMargin: 10
             anchors.right: parent.right
             anchors.rightMargin: 540
         }
         ButtonCurrentTitle
         {
             id:title;
             x: 225
             y: 15
             width: 150
             height: 50
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenter: parent.verticalCenter
         }
     }

}

