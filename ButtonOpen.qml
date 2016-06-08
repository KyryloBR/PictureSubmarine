import QtQuick 2.0

Item {
    id: item1
    Rectangle {
        id: btnOpen
        x: -40
        y: -40
        width: 45;
        height: 45;
        radius: 23;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        state: "sExit";
        border.width: 2
        Text
        {
            id: textBtnOpen;
            anchors.centerIn: btnOpen;
            text: "...";
            font.bold: true
            font.pointSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            textFormat: Text.AutoText
        }
        MouseArea
        {
            anchors.fill: btnOpen;
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
                fdOpenImage.nameCalledFunction = "Button Open";
                fdOpenImage.open();
            }
        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnOpen;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnOpen;
                    color: "#591542";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnOpen;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnOpen;
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
                    targets: [btnOpen,textBtnOpen];
                    properties: "border.color,color";
                    duration: 1000;
                }
            }
        ]

    }
}

