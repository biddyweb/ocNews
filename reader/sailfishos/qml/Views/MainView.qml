import QtQuick 2.0
import Sailfish.Silica 1.0

import "../Delegates"
import "../Dialogs"
import "../Common"
import "../JS/globals.js" as GLOBALS


Page {
    id: mainView

    property int configState

    Component.onCompleted: {
        if (dbus.isConfigSet() && dbus.isAccountEnabled()) {
            configState = 0
        } else if (!dbus.isConfigSet()) {
            configState = 1
        } else if (dbus.isConfigSet() && !dbus.isAccountEnabled()) {
            configState = 2
        }
    }

    Connections {
        target: dbus
        onSavedConfig: {
            if (dbus.isConfigSet() && dbus.isAccountEnabled()) {
                configState = 0
            } else if (!dbus.isConfigSet()) {
                configState = 1
            } else if (dbus.isConfigSet() && !dbus.isAccountEnabled()) {
                configState = 2
            }
            if (viewMode !== 0 ) { combinedModelSql.refresh() }
        }
    }

    Connections {
        target: updater
        onUpdateStarted: if(GLOBALS.previousFlatContentY === 0) GLOBALS.previousFlatContentY = mainViewList.contentY
        onUpdateFinished: { if (viewMode !== 0) { GLOBALS.previousFlatContentY = mainViewList.contentY; combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
    }
    Connections {
        target: folders
        onCreatedFolderSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onDeletedFolderSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onMarkedReadFolderSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onRenamedFolderSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
    }
    Connections {
        target: feeds
        onCreatedFeedSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onDeletedFeedSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onMarkedReadFeedSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onMovedFeedSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
    }
    Connections {
        target: items
        onMarkedAllItemsReadSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onMarkedItemsSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onStarredItemsSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onUpdatedItemsSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
        onRequestedItemsSuccess: { if (viewMode !== 0) { combinedModelSql.refresh(); mainViewList.contentY = GLOBALS.previousFlatContentY } }
    }

    SilicaListView {
        id: mainViewList
        anchors.fill: parent
        anchors.bottomMargin: addActionsDock.open ? addActionsDock.height * 1.5 : 0

        header: PageHeader {
            id: pHeader
            title: operationRunning ? qsTr("Update running...") : "ocNews"
        }

        section {
            property: 'folderName'
            delegate: SectionHeader {
                visible: text != ""
                text: section
                height: Theme.itemSizeExtraSmall
            }
        }


        PullDownMenu {
            id: mainViewPully
            busy: operationRunning
            MenuItem {
                id: quit
                text: qsTr("Quit")
                onClicked: quitEngine()
            }
            MenuItem {
                id: about
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("../Pages/About.qml"))
            }
            MenuItem {
                id: settings
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("../Pages/Settings.qml"))
            }
            MenuItem {
                id: add
                enabled: configState === 0 && !operationRunning
                text: qsTr("Add")
                onClicked: addActionsDock.open = !addActionsDock.open
            }
            MenuItem {
                id: updateAll
                enabled: configState === 0 && !operationRunning
                text: qsTr("Update all")
                onClicked: { updater.startUpdate(); operationRunning = true }
            }
            MenuLabel {
                id: lastUpdated
                visible: configState === 0 && !operationRunning
                Connections {
                    target: dbus
                    onGotStatistics: lastUpdated.text = qsTr("Last update: ") + Qt.formatDateTime(new Date(stats["lastFullUpdate"]), Qt.DefaultLocaleShortDate);
                }
            }
        }

        ViewPlaceholder {
            enabled: configState > 0
            text: qsTr("With these app you can synchronize and view your ownCloud News App content on your smartphone. Before you can start, you have to setup your ownCloud server account in the settings.")
        }

        ViewPlaceholder {
            enabled: configState === 0 && mainViewList.count <= 1
            text: qsTr("The local database is empty. Please make an update or add new feeds and folders.")
        }

        model: viewMode === 0 ? folderModelSql : combinedModelSql

        delegate: FolderListDelegate { visible: configState === 0 && mainViewList.count > 1 }

        VerticalScrollDecorator {}

        FancyScroller {}

        PushUpMenu {
            id: mainViewPushy
            enabled: mainViewList.contentHeight >= mainViewList.height
            visible: mainViewList.contentHeight >= mainViewList.height
            MenuItem {
                id: goToTop
                text: qsTr("Scroll to top")
                onClicked: mainViewList.scrollToTop()
            }
        }
    }


    DockedPanel {
        id: addActionsDock
        width: parent.width
        height: Theme.itemSizeExtraLarge + Theme.paddingLarge
        dock: Dock.bottom

        Row {
            anchors.centerIn: parent

            Button {
                id: addFeed
                text: qsTr("Add feed")
                enabled: !operationRunning
                onClicked: {
                    addActionsDock.open = false
                    var dialog = pageStack.push(Qt.resolvedUrl("../Dialogs/CreateFeed.qml"))
                    dialog.accepted.connect(function() { operationRunning = true })
                }
            }

            Button {
                id: addFolder
                text: qsTr("Add folder")
                enabled: !operationRunning
                onClicked: {
                    addActionsDock.open = false
                    var dialog = pageStack.push(Qt.resolvedUrl("../Dialogs/CreateFolder.qml"))
                    dialog.accepted.connect(function() {operationRunning = true })
                }
            }
        }
    }

    function quitEngine()
    {
        remorsePop.execute(qsTr("Quit reader and engine"), function() { dbus.quitEngine(); Qt.quit() } );
    }

    RemorsePopup {
        id: remorsePop
    }
}
