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

    function nextIndex()
    {
        if(currentAlbumList.currentIndex === currentAlbumList.count - 1)
        {
             currentAlbumList.currentIndex = 0;
        }
        else
        {
            currentAlbumList.currentIndex++;
        }
    }

    function previousIndex()
    {
        if(currentAlbumList.currentIndex === 0)
        {
             currentAlbumList.currentIndex = currentAlbumList.count - 1;
        }
        else
        {
             currentAlbumList.currentIndex--;
        }
    }

    function setCurrentIndex(_index)
    {
        currentAlbumList.currentIndex = _index;
    }

    ListView {
        id: currentAlbumList;
        width: 420
        height: 130
        boundsBehavior: Flickable.DragOverBounds
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
        
        delegate: Row{
            id: rowCurrentAlbum;
            property bool selected: false;
            smooth: false;
            Rectangle
            {
                width : 10;
                height : 110;
                opacity: 0;
            }
            Rectangle {
                id : rectPhoto;
                width: 110;
                height: 110;
                color: "#00000000";
                z:7;
                Image
                {
                    id: imgAlbum;
                    z:8;
                    width : 110;
                    height : 110;
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
                                currentAlbumList.currentIndex = index;
                                controler.currentAlbum.setCurrentImage(controler.currentAlbum.indexByImage(modelData));
                                slidePart1.start();
                            }
                            if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                            {
                                rowCurrentAlbum.selected = !rowCurrentAlbum.selected;
                            }
                        }
                    }
                }

                NumberAnimation {
                    id: aSelected
                    target: rowCurrentAlbum
                    property: "scale"
                    from : 1;
                    to : 0.8;
                    duration: 500;
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation
                {
                    id: aUnSelected
                    target: rowCurrentAlbum
                    property: "scale"
                    from : 0.8;
                    to : 1;
                    duration: 500;
                    easing.type: Easing.InOutQuad
                }
            }
            onSelectedChanged:
            {
                if(selected === true)
                {
                    controler.removePush(index);
                    console.log(index);
                    aSelected.start();
                }
                else
                {
                    controler.removePop(index);
                    console.log(index);
                    aUnSelected.start();
                }
            }
        }
    }
}

