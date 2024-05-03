﻿#ifndef SERIALSERVERWEBSOCKET_H
#define SERIALSERVERWEBSOCKET_H

#include <QObject>
#include <QWebSocketServer>
#include <QWebSocket>

class SerialServerWebSocket : public QObject
{
    Q_OBJECT
    Q_ENUMS(PROTOCOL_CMD)
public:
    enum PROTOCOL_CMD {
        NEWCONNECTSOCKET = 1,
        ADDDEV,
        DELDEV,
        SERIALERROR,
        READDATA,
        SERIALOPENSUCCEED,
        SERIALCLOSESUCCEED,
        SERIALDISCONNECT,
        SERIALDEVLIST,
        OPENSERIALPORT,
        CLOSESERIALPORT,
        WRITEDATA
    };
    explicit SerialServerWebSocket(QObject *parent = nullptr);
    ~SerialServerWebSocket();

private:
    void InitProperty();
    void InitConnect();

    void DecodeData(QString data);

    QString NewConnectSocket();
    QString AddDev(QString port);
    QString DelDev(QString port);
    QString SerialError(QString port, quint64 error);
    QString ReadData(QString port, QByteArray data);
    QString SerialOpenSucceed(QString port);
    QString SerialCloseSucceed(QString port);
    QString SerialDisconnect(QString port);

    void DecodeNewConnectSocket(QString data);
    void DecodeAddDev(QString data);
    void DecodeDelDev(QString data);
    void DecodeSerialError(QString data);
    void DecodeReadData(QString data);
    void DecodeSerialOpenSucceed(QString data);
    void DecodeSerialCloseSucceed(QString data);
    void DecodeSerialDisconnect(QString data);
    void DecodeSerialDevList(QString data);
    void DecodeOpenSerialPort(QString data);
    void DecodeCloseSerialPort(QString data);
    void DecodeWriteData(QString data);

private slots:
    void onNewConnection();
    void ontextMessageReceived(const QString &message);
    void ontextFrameReceived(const QByteArray &message);
    void onDisconnected();

private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket*> m_pSockets;
};

#endif // SERIALSERVERWEBSOCKET_H
