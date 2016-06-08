import QtQuick 2.0

Item {
    id: btnNextItem
    Rectangle {
        id: btnNext
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
            id: textBtnNext;
            x: 14
            y: 10
            anchors.centerIn: btnNext;
            text: ">";
            font.bold: true
            font.pointSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            textFormat: Text.AutoText
        }
        MouseArea
        {
            anchors.fill: btnNext;
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
                controler.currentAlbum.next();
                currentAlbum.nextIndex();
                slidePart1.start();
            }

        }

        states:[
            State {
                name: "sExit"
                PropertyChanges {
                    target: btnNext;
                    border.color: "#591542";
                    color: "#00000000";
                }
                PropertyChanges {
                    target: textBtnNext;
                    color: "#591542";
                }
            },
            State{
                name:"sEnter";
                PropertyChanges {
                    target: btnNext;
                    border.color: "#585050";
                    color: "#591542";
                }
                PropertyChanges {
                    target: textBtnNext;
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
                    targets: [btnNext,textBtnNext];
                    properties: "border.color,color";
                    duration: 1000;
                }
            }
        ]

    }
}

