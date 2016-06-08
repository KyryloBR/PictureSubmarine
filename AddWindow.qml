import QtQuick 2.0

Item {
    property string nameCreatedAlbum: "";

    id: addWindow;
    state : "sHide";

    function show()
    {
        addWindow.state = "sShow";
    }

    function hide()
    {
        addWindow.state = "sHide";
    }

    Rectangle
    {
        id: formNewAlbum
        x: 0
        y: 0
        width: 352
        height: 84
        color: "#585050"
        radius : 15
        border.width: 2
        border.color: "#591542";
        TextEdit
        {
            id: nameAlbum;
            x: 101
            width: 150
            color: "#ffffff"
            text: "New Album"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 52
            font.bold: true
            textFormat: Text.AutoText
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 10
            selectionColor: "#591542"
        }

        Rectangle {
            id: btnOk
            y: 47
            height: 20
            color: "#00000000"
            radius: 10;
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 17
            anchors.right: parent.right
            anchors.rightMargin: 198
            border.width: 2
            border.color: "#591542"
            anchors.left: parent.left
            anchors.leftMargin: 80
            Text {
                id: txtBtnOk
                color: "#ffffff"
                text: qsTr("Ok")
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                style: Text.Outline
                styleColor: "#591542"
                font.pointSize: 10
            }
            MouseArea
            {
                anchors.fill: btnOk;
                hoverEnabled: true;
                onEntered:
                {
                    parent.state = "sEnter";
                }
                onExited:
                {
                    parent.state = "sExit";
                }
                onClicked:
                {
                    if(nameAlbum.text !== "")
                    {
                        controler.addAlbum(nameAlbum.text.toString());
                        addWindow.state = "sHide";
                    }
                    else
                    {
                        nameAlbum.text = "Input name for new album";
                    }
                }
            }
            states:[
                State {
                    name: "sExit"
                    PropertyChanges {
                        target: btnOk;
                        border.color: "#591542";
                        color: "#00000000";
                    }
                    PropertyChanges {
                        target: txtBtnOk;
                        color: "#591542";
                    }
                },
                State{
                    name:"sEnter";
                    PropertyChanges {
                        target: btnOk;
                        border.color: "#585050";
                        color: "#591542";
                    }
                    PropertyChanges {
                        target: txtBtnOk;
                        color: "#585050";

                    }

                }
            ]
            transitions: [
                Transition {
                    from: "*";
                    to: "*";
                    PropertyAnimation
                    {
                        targets: [btnOk,txtBtnOk];
                        properties: "border.color,color";
                        duration: 1000;
                    }
                }
            ]
        }

        Rectangle {
            id: btnCancel
            y: 47
            height: 20
            color: "#00000000"
            radius: 10;
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 17
            anchors.left: parent.left
            anchors.leftMargin: 198
            border.width: 2
            border.color: "#591542"
            anchors.right: parent.right
            anchors.rightMargin: 80
            Text {
                id: txtBtnCancel
                x: 0
                y: -1
                width: 74
                height: 21
                color: "#ffffff"
                text: qsTr("Cancel")
                style: Text.Outline
                styleColor: "#591542"
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            MouseArea
            {
                anchors.fill: btnCancel;
                hoverEnabled: true;
                onEntered:
                {
                    parent.state = "sEnter";
                }
                onExited:
                {
                    parent.state = "sExit";
                }
                onClicked:
                {
                    addWindow.state = "sHide";
                }
            }
            states:[
                State {
                    name: "sExit"
                    PropertyChanges {
                        target: btnCancel;
                        border.color: "#591542";
                        color: "#00000000";
                    }
                    PropertyChanges {
                        target: txtBtnCancel;
                        color: "#591542";
                    }
                },
                State{
                    name:"sEnter";
                    PropertyChanges {
                        target: btnCancel;
                        border.color: "#585050";
                        color: "#591542";
                    }
                    PropertyChanges {
                        target: txtBtnCancel;
                        color: "#585050";

                    }

                }
            ]
            transitions: [
                Transition {
                    from: "*";
                    to: "*";
                    PropertyAnimation
                    {
                        targets: [btnCancel,txtBtnCancel];
                        properties: "border.color,color";
                        duration: 1000;
                    }
                }
            ]
        }
    }
    states:[
        State {
            name: "sShow"
            PropertyChanges {
                target: formNewAlbum;
                opacity : 1;
                enabled : true;
            }
        },
        State{
            name:"sHide";
            PropertyChanges {
                target: formNewAlbum;
                opacity : 0;
                enabled : false;
            }
        }
    ]
    transitions: [
        Transition {
            from: "*";
            to: "*";
            PropertyAnimation
            {
                target: formNewAlbum;
                properties: "opacity";
                duration: 1000;
            }
        }
    ]
}

