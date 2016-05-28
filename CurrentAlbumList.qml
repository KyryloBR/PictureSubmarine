import QtQuick 2.0

Item {
    id: item1
    function setModelCurrent(_model)
    {
        currentAlbumList.model = _model;
    }

    ListView {
        id: currentAlbumList;
        width: 420
        height: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        snapMode: ListView.NoSnap
        scale: 1
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        currentIndex: controler.currentAlbum.currentIndex;
        model: controler.currentAlbum.getModel();
        orientation: ListView.Horizontal
        flickableDirection: Flickable.AutoFlickDirection
        delegate: Row{
            id: rowCurrentAlbum;
            Rectangle
            {
                width : 10;
                height : 60;
                opacity: 0;
            }

            Rectangle {
                id : rectPhoto;
                width: 60;
                height: 60;
                Image
                {
                    id: imgAlbum;
                    width : 60;
                    height : 60;
                    source: modelData.sourceImage;
                    MouseArea
                    {
                        hoverEnabled: true;
                        anchors.fill: parent;
                        onClicked:
                        {
                            //currentImg.source = modelData.getQmlPath();
                            if(controler.currentAlbum.indexByImage(modelData) !== -1)
                            {
                                slidePart1.start();
                                controler.currentAlbum.setCurrentImage(controler.currentAlbum.indexByImage(modelData));
                            }
                        }
                    }
                }
            }
        }
    }
}

