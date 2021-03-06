import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property string imageRSrc: ""
    property string imageTSrc: ""
    property real currentZoomLevel: 1.0
    Rectangle {
        id: redRect
        anchors.fill: parent

        Rectangle {
            id: leftRect
            color: "transparent"

            anchors.left: parent.left
            anchors.right: splitHandler.left
            anchors.top: parent.top
            anchors.bottom: footer.top
            width: (parent.width/2) -5
            ImageScrollArea {
                id: imageR
                anchors.fill: parent
                zoomController.visible: false
                zoomScale: currentZoomLevel
                imageSrc: imageRSrc
                controlAlignment: Qt.AlignRight
            }

        }

        Rectangle {
            id:splitHandler
            color: "lightGray"
            anchors.bottom: footer.top
            anchors.top: parent.top
            width: 10
//            height: parent.height - footer.height

            x: Math.round(parent.width/2)
            y:0
            onXChanged: {
                if(x< 0)
                    x = 0
                else if(x > parent.width) {
                    x = parent.width - width
                }
            }

            MouseArea {
                anchors.fill: parent
                drag.target: parent
            }
        }

        Rectangle {
            id: rightRect
            color: "transparent"

            anchors.left: splitHandler.right
            anchors.top: parent.top
            anchors.bottom: footer.top
            anchors.right: parent.right

            width: (parent.width/2) -5

            ImageScrollArea {
                id: imageT
                anchors.fill: parent
                zoomController.visible: false
                zoomScale: currentZoomLevel
                imageSrc: imageTSrc
                controlAlignment: Qt.AlignRight
            }
        }

        Rectangle {
            id:footer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            height: 60
            /*ControlSlider {
                anchors.centerIn: parent
                id: zoomSlider
                title: "Zoom"
                from:0.7
                to:15.0
                value: 1.0
            }*/
            Row{
                x: parent.width/2 - childrenRect.width/2
                y: 10
                spacing: 10
                ToolButton {
                    iconSource: "qrc:/icons/zoom_in.png"
                    onClicked: {
                        currentZoomLevel = Math.min(currentZoomLevel+0.5, 20)
                    }
                }
                ToolButton {
                    iconSource: "qrc:/icons/zoom_out.png"
                    onClicked: {
                        currentZoomLevel -= 0.5
                    }
                }
                ToolButton {
                    iconSource: "qrc:/icons/zoom_reset.png"
                    onClicked: {
                        currentZoomLevel = 1.0
                    }
                }

                ToolButton {
                    iconSource: "qrc:/icons/reset.png"
                    onClicked: {
                        imageR.updateImageLocation()
                        imageT.updateImageLocation()
                    }
                }
            }

        }

    }
}
