﻿import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import GrayCatQtQuick 1.0
import "../../"

Rectangle {
    id: cattreedemostrationview
    color: "transparent"
    property string controlname: "--------"


    Text {
        id: controlnametext
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 20
        anchors.leftMargin: 40
        text: controlname
        font.pixelSize: 26
        font.family: ProjectObject.fontFamily
        font.bold: true
        color: ProjectObject.controlNameColor
    }
    /*SwipeView {
        id: functionswipeview
        width: parent.width
        anchors.top: controlnametext.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        currentIndex: 0
        interactive: false
        spacing: 5

        DemoImageFlipable {
        }

        DemoImageFlicker {
        }

        DemoImageFlickerGradient {
        }

        DemoImageMove {
        }

        DemoImageScale {
        }

        DemoMarquee {
        }

        DemoTextOneByOneShow {
        }

        DemoCatRectangle {
        }

        DemoQParentQrenCode {
        }

        clip: true

        Component.onCompleted:{
            contentItem.highlightMoveDuration = 0       //将移动时间设为0
        }
    }*/

    Loader {
        id: pageloader
        anchors.top: controlnametext.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        asynchronous: true
        visible: status == Loader.Ready
        source: ProjectObject.defaultControl.control[0].qmlSource

        onProgressChanged: {
            console.log("Progress: " + progress)
        }
    }

    function updatedemo(demoname, qmlsource)
    {
        controlname = demoname
        pageloader.source = qmlsource
    }

    Component.onCompleted: {
        controlname = ProjectObject.defaultControl.control[0].name
        /*catconfig.updateLanguage.connect(function(){
            let source = pageloader.source;
            pageloader.source = "";
            pageloader.source = source;
        });*/
    }
}
