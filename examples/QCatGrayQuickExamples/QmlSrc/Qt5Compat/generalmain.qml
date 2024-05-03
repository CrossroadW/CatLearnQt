﻿import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import Qt.labs.calendar 1.0
import QtQuick.Window 2.12
import GrayCatQtQuick 1.0
//import CatEncp 1.0
import "FunctionLayout"
import "./MoreFunctionViews"

Window {
    id: applicationWindow
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600
    visible: true


    //color: ProjectObject.appBackgroundColor

    ColumnLayout {
        id: rootLayout
        spacing: 0
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.maximumHeight: 40
            Layout.minimumHeight: 40
            GeneralTitleItem {
                id: win10titleitem
                anchors.fill: parent

            }

            CatDropShadow {
                anchors.fill: win10titleitem
                horizontalOffset: 0
                verticalOffset: 0
                radius: 8.0
                samples: 18
                color: ProjectObject.catPopupdropshadowColor
                source: win10titleitem
            }

        }


        Item {
            id: functionRect
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 20
            //color: ProjectObject.appBackgroundColor

            LayoutView {
                anchors.fill: functionRect
            }

            CatFps {
                id: catfps
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: -15
                anchors.topMargin: -15
                gradient0Color: ProjectObject.fpsgradient0Color
                gradient1Color: ProjectObject.fpsgradient1Color
                width: 120
                height: 32
            }
        }

    }

    MoreView {
        id: moreview
        visible: false
    }



    Component.onCompleted: {
        //catLog.debug_print("run ui, system is: " + Qt.platform.os);
        if(catconfig != undefined)
        {
            ProjectObject.currentTheme = catconfig.getValue("Style");
        }
        //var key = CatEncp.md5("123456")

        //var data = CatEncp.aes_256_Cbc_Encrypt("hello world", key);
        //data = CatEncp.aes_256_Cbc_Decrypt(data, key);

        //catLog.debug_print(data);

        if(Qt.platform.os === "osx")
        {
            catfps.anchors.rightMargin = 0
        }

        color = ProjectObject.appBackgroundColor
        ProjectObject.updateCurrentThemeed.connect(function(){
            animation.start();
        });
        //catLog.debug_print("system font familys: " + catconfig.systemFontFamily())
    }

    PropertyAnimation  {
        id: animation
        target: applicationWindow;
        property: "color";
        from: color
        to: ProjectObject.appBackgroundColor
        duration: ProjectObject.settingtransition ? 400 : 0
    }

}
