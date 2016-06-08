import QtQuick 2.0

Item {
    id:infoBox;
    state:"sHide";
    signal buttonOkClicked();

    property string message: "";

    function setMessage(_msg)
    {
        infoBox.message = _msg;
    }
    function show()
    {
        infoBox.state = "sShow";
    }

    function hide()
    {
        infoBox.state = "sHide";
    }

    Rectangle {
        id: infoBoxRect
        x: 0
        y: 0
        width: 352
        height: 84
        color: "#585050"
        radius : 15
        border.width: 2
        border.color: "#591542";

        Text {
            id: msg
            text: qsTr("Text")
            font.pixelSize: 14
            font.family: "Times New Roman"
            color: "#591542"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 33
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 8
        }

        Rectangle {
            id: btnApply
            x: 141
            width: 70
            state : "sExit"
            color: "#00000000"
            radius: 10
            anchors.top: parent.top
            anchors.topMargin: 57
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            border.width: 2
            border.color: "#591542"
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: txtBtnApply
                text: qsTr("Ok")
                font.family: "Times New Roman"
                color: "#591542"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }
            MouseArea
            {
                anchors.fill: btnApply;
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
                    buttonOkClicked();
                    infoBox.state = "sHide";
                }
            }
            states:[
                State {
                    name: "sExit"
                    PropertyChanges {
                        target: btnApply;
                        border.color: "#591542";
                        color: "#00000000";
                    }
                    PropertyChanges {
                        target: txtBtnApply;
                        color: "#591542";
                    }
                },
                State{
                    name:"sEnter";
                    PropertyChanges {
                        target: btnApply;
                        border.color: "#585050";
                        color: "#591542";
                    }
                    PropertyChanges {
                        target: txtBtnApply;
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
                        targets: [btnApply,txtBtnApply];
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
                target: infoBox;
                opacity : 1;
                enabled : true;
            }
        },
        State{
            name:"sHide";
            PropertyChanges {
                target: infoBox;
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
                target: infoBox;
                properties: "opacity";
                duration: 1000;
            }
        }
    ]
}
