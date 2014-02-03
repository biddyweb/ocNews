/*
 * This file was generated by qdbusxml2cpp version 0.7
 * Command line was: qdbusxml2cpp -c OcUpdaterAdaptor -a ocupdateradaptor.h:ocupdateradaptor.cpp de.buschmann23.ocNewsEngine.Updater.xml
 *
 * qdbusxml2cpp is Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
 *
 * This is an auto-generated file.
 * Do not edit! All changes made to it will be lost.
 */

#include "ocupdateradaptor.h"
#include <QtCore/QMetaObject>
#include <QtCore/QByteArray>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QVariant>

/*
 * Implementation of adaptor class OcUpdaterAdaptor
 */

OcUpdaterAdaptor::OcUpdaterAdaptor(QObject *parent)
    : QDBusAbstractAdaptor(parent)
{
    // constructor
    setAutoRelaySignals(true);
}

OcUpdaterAdaptor::~OcUpdaterAdaptor()
{
    // destructor
}

bool OcUpdaterAdaptor::isUpdateRunning()
{
    // handle method call de.buschmann23.ocNewsEngine.Updater.isUpdateRunning
    bool out0;
    QMetaObject::invokeMethod(parent(), "isUpdateRunning", Q_RETURN_ARG(bool, out0));
    return out0;
}

void OcUpdaterAdaptor::startUpdate()
{
    // handle method call de.buschmann23.ocNewsEngine.Updater.startUpdate
    QMetaObject::invokeMethod(parent(), "startUpdate");
}

int OcUpdaterAdaptor::isFetchImagesRunning()
{
    // handle method call de.buschmann23.ocNewsEngine.Updater.isFetchImagesRunning
    int out0;
    QMetaObject::invokeMethod(parent(), "isFetchImagesRunning", Q_RETURN_ARG(int, out0));
    return out0;
}

