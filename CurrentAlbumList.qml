import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: item1
    function setModelCurrent(_model)
    {
        currentAlbumList.model = _model;
    }

    function setEnabledDelegate(_enabled)
    {
        currentAlbumList.enabled = _enabled;
    }

    ListView {
        id: currentAlbumList;
        width: 420
        height: 80
        enabled: true;
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
        flickableDirection: Flickable.AutoFlickDirection;
        highlightFollowsCurrentItem: true;
        highlight: Item
        {
            z:9;
            Rectangle
            {
                id:rectHighlight;
                x : 10;
                width: 60;
                height: 60;
                z:10;
                color:"#00000000";
                border.color: "#591542"
                border.width: 2;            }
        }

        delegate: Row{
            id: rowCurrentAlbum;
            smooth: false;
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
                color: "#00000000";
                z:7;
                Image
                {
                    id: imgAlbum;
                    z:8;
                    width : 60;
                    height : 60;
                    source: modelData.sourceImage;
                    fillMode: Image.PreserveAspectFit;
                    MouseArea
                    {
                        id:maListDelegate;
                        hoverEnabled: true;
                        anchors.fill: parent;
                        enabled: true;
                        onClicked:
                        {
                            if(controler.currentAlbum.indexByImage(modelData) !== -1)
                            {
                                slidePart1.start();
                                currentAlbumList.currentIndex = index;
                                controler.currentAlbum.setCurrentImage(controler.currentAlbum.indexByImage(modelData));
                            }
                        }
                    }
                }
            }
        }
    }
}

