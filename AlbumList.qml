import QtQuick 2.0

Item {
    id:itemAlbumList;
    ListView
    {
        id:albumList;
        width: 420
        height: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        snapMode: ListView.NoSnap
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: ListView.Horizontal
        flickableDirection: Flickable.AutoFlickDirection
        model : controler.getModelAlbum();
        delegate:Row{
                    Rectangle
                    {
                       height : 80;
                       width: 10;
                       opacity: 0;
                    }

                    Rectangle
                    {
                        id: delAlbumList;
                        border.color: "#591542";
                        border.width: 3;
                        color : "#ffffff"
                        height : 80;
                        width: 80;
                        Column
                        {
                            y: 10;
                            Image
                            {
                                x : 15;
                                width:50;
                                height: 50;
                                source: modelData.currentImage.sourceImage;
                            }
                            Text {
                                id: albumName;
                                text: modelData.name;
                                font.family: "Verdana"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                color: "#591542";
                                x:(80 - (albumName.text.length * 8))/2;
                            }
                        }
                    }
        }
    }
}

