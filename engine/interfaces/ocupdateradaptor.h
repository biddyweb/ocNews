/*
 * This file was generated by qdbusxml2cpp version 0.7
 * Command line was: qdbusxml2cpp -c OcUpdaterAdaptor -a ocupdateradaptor.h:ocupdateradaptor.cpp de.buschmann23.ocNewsEngine.Updater.xml
 *
 * qdbusxml2cpp is Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
 *
 * This is an auto-generated file.
 * This file may have been hand-edited. Look for HAND-EDIT comments
 * before re-generating it.
 */

#ifndef OCUPDATERADAPTOR_H
#define OCUPDATERADAPTOR_H

#include <QtCore/QObject>
#include <QtDBus/QtDBus>
class QByteArray;
template<class T> class QList;
template<class Key, class Value> class QMap;
class QString;
class QStringList;
class QVariant;

/*
 * Adaptor class for interface de.buschmann23.ocNewsEngine.Updater
 */
class OcUpdaterAdaptor: public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "de.buschmann23.ocNewsEngine.Updater")
    Q_CLASSINFO("D-Bus Introspection", ""
"  <interface name=\"de.buschmann23.ocNewsEngine.Updater\">\n"
"    <method name=\"startUpdate\"/>\n"
"    <signal name=\"updateStarted\"/>\n"
"    <signal name=\"updateFinished\"/>\n"
"    <signal name=\"updateError\">\n"
"      <arg direction=\"out\" type=\"s\" name=\"updateErrorMessage\"/>\n"
"    </signal>\n"
"    <method name=\"isUpdateRunning\">\n"
"      <arg direction=\"out\" type=\"b\"/>\n"
"    </method>\n"
"    <method name=\"isFetchImagesRunning\">\n"
"      <arg type=\"i\" direction=\"out\"/>\n"
"    </method>\n"
"    <signal name=\"startedFetchingImages\">\n"
"      <arg name=\"numberOfItems\" type=\"i\" direction=\"out\"/>\n"
"    </signal>\n"
"    <signal name=\"finishedFetchingImages\"/>\n"
"    <signal name=\"fetchingImages\">\n"
"      <arg name=\"currentItem\" type=\"i\" direction=\"out\"/>\n"
"    </signal>\n"
"  </interface>\n"
        "")
public:
    OcUpdaterAdaptor(QObject *parent);
    virtual ~OcUpdaterAdaptor();

public: // PROPERTIES
public Q_SLOTS: // METHODS
    bool isUpdateRunning();
    void startUpdate();
    int isFetchImagesRunning();
Q_SIGNALS: // SIGNALS
    void updateError(const QString &updateErrorMessage);
    void updateFinished();
    void updateStarted();
    void startedFetchingImages(const int &numberOfItems);
    void finishedFetchingImages();
    void fetchingImages(const int &currentItem);
};

#endif
