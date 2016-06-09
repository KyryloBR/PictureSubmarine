import QtQuick 2.0

Item {
    id:itemAlbumList;
    function setEnabledDelegate(_enabled)
    {
        lvAlbumList.enabled = _enabled;
    }

    function setModel(_model)
    {
        lvAlbumList.model = _model;
    }

    ListView
    {
        id:lvAlbumList;
        width: 420
        height: 130
        enabled: true;
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
                    id:rowAlbumList;
                    state: "sExit";
                    property bool selected: false;
                    Rectangle
                    {
                       height : 130;
                       width: 10;
                       opacity: 0;
                    }

                    Rectangle
                    {
                        id: delAlbumList;
                        border.color: "#591542";
                        border.width: 3;
                        color : "#ffffff"
                        height : 130;
                        width: 130;
                        Column
                        {
                            y: 10;
                            Image
                            {
                                id:coverAlbum;
                                x : 15;
                                width:100;
                                height: 100;
                                source: modelData.countImage() === 0 ? "Images/logo.png" : modelData.currentImage.sourceImage;
                                onSourceChanged:
                                {
                                  animationChangeCover.start();
                                }
                                SequentialAnimation
                                {
                                    id:animationChangeCover;
                                    PropertyAnimation
                                    {
                                        target: coverAlbum;
                                        property: "scale";
                                        from: 1;
                                        to: 1.1;
                                        duration: 800;
                                    }
                                    PropertyAnimation
                                    {
                                        target: coverAlbum;
                                        property: "scale";
                                        from: 1.1;
                                        to: 1;
                                        duration: 800;
                                    }
                                }
                            }
                            Text {
                                id: albumName;
                                text: modelData.name;
                                font.family: "Verdana"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 10
                                color: "#591542";
                                x:(130 - (albumName.text.length * 8))/2;
                            }
                        }
                        MouseArea
                        {
                            anchors.fill: parent;
                            hoverEnabled: true;
                            onEntered:
                            {
                                if(rowAlbumList.state !== "sSelected")
                                {
                                    rowAlbumList.state = "sEnter";
                                }
                            }
                            onExited:
                            {
                                if(rowAlbumList.state !== "sSelected")
                                {
                                    rowAlbumList.state = "sExit";
                                }
                            }
                            onClicked:
                            {
                                if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier))
                                {
                                    rowAlbumList.selected = !rowAlbumList.selected;
                                }
                                else
                                {
                                    controler.setCurrentAlbum(modelData.name);
                                    btnGroup.setTitleCurrentAlbum(modelData.name);
                                    currentAlbum.setCurrentIndex(controler.currentAlbum.currentIndex);
                                    slidePart1.start();
                                    currentAlbum.setModelCurrent(controler.currentAlbum.getModel());
                                    generalWindow.state = "sCurrentAlbumShow";
                                }
                            }
                        }

                        PropertyAnimation {
                            id: aSelected
                            target: delAlbumList
                            property: "color";
                            from: "#ffffff"
                            to: "#591542"
                            duration: 500;
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAnimation {
                            id: aUnSelected
                            target: delAlbumList
                            property: "color";
                            from: "#591542"
                            to : "#ffffff"
                            duration: 500;
                            easing.type: Easing.InOutQuad
                        }
                    }
                    states :[
                        State {
                            name: "sExit"
                            PropertyChanges {
                                target: delAlbumList;
                                color: "#ffffff"
                            }
                        },
                        State {
                            name: "sEnter"
                            PropertyChanges {
                                target: delAlbumList;
                                color:"#00000000"
                            }
                        },
                        State {
                            name: "sSelect"
                            PropertyChanges {
                                target: delAlbumList
                                color: "#591542"
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "*";
                            to: "*";
                            PropertyAnimation
                            {
                                target: delAlbumList;
                                properties: "color";
                                duration: 1000;
                            }
                        }
                    ]
                    onSelectedChanged:
                    {
                        if(selected === true)
                        {
                            controler.removePush(modelData.name);
                            console.log("Selected");
                            delAlbumList.state = "sSelect";
                        }
                        else
                        {
                            controler.removePop(modelData.name);
                            console.log("UnSelected");
                            delAlbumList.state = "sExit";
                        }
                    }
        }
    }
}

