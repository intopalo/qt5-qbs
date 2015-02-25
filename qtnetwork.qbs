import qbs

QtModule {
    name: "QtNetwork"
    readonly property path basePath: project.sourceDirectory + "/qtbase/src/network"

    Depends { name: "QtNetworkHeaders" }
    Depends { name: "zlib" } // ### only spdy needs this
    Depends { name: "QtCore" }
    QtHost.includes.modules: ["network", "network-private"]

    cpp.defines: base.concat([
        "QT_BUILD_NETWORK_LIB",
        "QT_NO_SSL", // ### tie to QtHost.config
    ])

    Properties {
        condition: qbs.targetOS.contains("windows")
        files: [
            "advapi32",
            "dnsapi",
            "ws2_32",
        ]
    }

    Group {
        id: headers_moc_p
        name: "headers (delayed moc)"
        prefix: basePath + "/"
        fileTags: "moc_hpp_p"
        files: [
            "access/qftp_p.h",
            "access/qnetworkreplydataimpl_p.h",
            "access/qhttpnetworkconnectionchannel_p.h",
            "access/qnetworkaccessmanager.h",
            "access/qhttpnetworkconnection_p.h",
            "access/qnetworkreplyimpl_p.h",
            "access/qnetworkreplyfileimpl_p.h",

            "bearer/qnetworksession.h",
            "bearer/qnetworkconfigmanager.h",
            "bearer/qbearerengine_p.h",

            "kernel/qdnslookup.h",

            "socket/qlocalserver.h",
            "socket/qabstractsocket.h",
            "socket/qlocalsocket.h",
            "socket/qtcpserver.h",
        ]
    }

    Group { // ### move to moc exclusions
        id: headers_no_moc
        prefix: basePath + "/"
        files: {
            var files = [];

            if (!qbs.targetOS.contains("winrt"))
                files.push("socket/qnativesocketengine_winrt_p.h");

            if (!qbs.targetOS.contains("osx"))
                files.push("access/qnetworkreplynsurlconnectionimpl_p.h");

            if (!QtHost.config.spdy)
                files.push("access/qspdyprotocolhandler*.h");

            if (!QtHost.config.ssl)
                files.push("ssl/*.h");

            return files;
        }
    }

    QtNetworkHeaders {
        fileTags: "moc_hpp"
        excludeFiles: headers_moc_p.files.concat(headers_no_moc.files)
    }

    Group {
        name: "sources (moc)"
        prefix: basePath + "/"
        files: [
            "access/qftp.cpp",
        ]
        fileTags: "moc_cpp"
        overrideTags: false
    }

    Group {
        name: "access"
        prefix: basePath + "/access/"
        files: [
            "qabstractnetworkcache.cpp",
            "qabstractprotocolhandler.cpp",
            "qhttpmultipart.cpp",
            "qhttpnetworkconnection.cpp",
            "qhttpnetworkconnectionchannel.cpp",
            "qhttpnetworkheader.cpp",
            "qhttpnetworkreply.cpp",
            "qhttpnetworkrequest.cpp",
            "qhttpprotocolhandler.cpp",
            "qhttpthreaddelegate.cpp",
            "qnetworkaccessauthenticationmanager.cpp",
            "qnetworkaccessbackend.cpp",
            "qnetworkaccesscache.cpp",
            "qnetworkaccesscachebackend.cpp",
            "qnetworkaccessdebugpipebackend.cpp",
            "qnetworkaccessfilebackend.cpp",
            "qnetworkaccessftpbackend.cpp",
            "qnetworkaccessmanager.cpp",
            "qnetworkcookie.cpp",
            "qnetworkcookiejar.cpp",
            "qnetworkdiskcache.cpp",
            "qnetworkreply.cpp",
            "qnetworkreplydataimpl.cpp",
            "qnetworkreplyfileimpl.cpp",
            "qnetworkreplyhttpimpl.cpp",
            "qnetworkreplyimpl.cpp",
            //"qnetworkreplynsurlconnectionimpl.mm",        // ### mac
            "qnetworkrequest.cpp",
            "qspdyprotocolhandler.cpp",
        ]
    }

    Group {
        name: "bearer"
        prefix: basePath + "/bearer/"
        files: [
            "qbearerengine.cpp",
            "qbearerplugin.cpp",
            "qnetworkconfigmanager.cpp",
            "qnetworkconfigmanager_p.cpp",
            "qnetworkconfiguration.cpp",
            "qnetworksession.cpp",
            "qsharednetworksession.cpp",
        ]
    }

    Group {
        name: "kernel"
        prefix: basePath + "/kernel/"
        files: [
            "qauthenticator.cpp",
            "qdnslookup.cpp",
            //"qdnslookup_android.cpp",     // ### android
            //"qdnslookup_winrt.cpp",       // ### winrt
            "qhostaddress.cpp",
            "qhostinfo.cpp",
            //"qhostinfo_winrt.cpp",        // ### winrt
            "qnetworkinterface.cpp",
            //"qnetworkinterface_winrt.cpp", // ### winrt
            "qnetworkproxy.cpp",
            //"qnetworkproxy_blackberry.cpp", // ### bb
            //"qnetworkproxy_mac.cpp",      // ### mac
            "qurlinfo.cpp",
        ]
    }

    Group {
        name: "kernel_unix"
        condition: qbs.targetOS.contains("unix")
        prefix: basePath + "/kernel/"
        files: [
            "qdnslookup_unix.cpp",
            "qhostinfo_unix.cpp",
            "qnetworkinterface_unix.cpp",
            "qnetworkproxy_generic.cpp",
        ]
    }

    Group {
        name: "kernel_windows"
        condition: qbs.targetOS.contains("windows")
        prefix: basePath + "/kernel/"
        files: [
            "qdnslookup_win.cpp",
            "qhostinfo_win.cpp",
            "qnetworkinterface_win.cpp",
            "qnetworkproxy_win.cpp",
        ]
    }

    Group {
        name: "socket"
        prefix: basePath + "/socket/"
        files: [
            "qabstractsocket.cpp",
            "qabstractsocketengine.cpp",
            "qhttpsocketengine.cpp",
            "qlocalserver.cpp",
            //"qlocalserver_tcp.cpp",               // ### QT_LOCALSOCKET_TCP
            "qlocalsocket.cpp",
            //"qlocalsocket_tcp.cpp",               // ### QT_LOCALSOCKET_TCP
            "qnativesocketengine.cpp",
            //"qnativesocketengine_winrt.cpp",      // ### winrt
            "qsocks5socketengine.cpp",
            "qtcpserver.cpp",
            "qtcpsocket.cpp",
            "qudpsocket.cpp",
        ]
    }

    Group {
        name: "socket_unix"
        condition: qbs.targetOS.contains("unix")
        prefix: basePath + "/socket/"
        files: [
            "qlocalserver_unix.cpp",
            "qlocalsocket_unix.cpp",
            "qnativesocketengine_unix.cpp",
        ]
    }


    Group {
        name: "socket_windows"
        condition: qbs.targetOS.contains("windows")
        prefix: basePath +"/socket/"
        files: [
            "qlocalserver_win.cpp",
            "qlocalsocket_win.cpp",
            "qnativesocketengine_win.cpp",
        ]
    }

    Group {
        name: "ssl"
        prefix: basePath + "/ssl/"
        condition: false
        files: [
            "qasn1element.cpp",
            "qssl.cpp",
            "qsslcertificate.cpp",
            "qsslcertificate_openssl.cpp",
            "qsslcertificate_qt.cpp",
            "qsslcertificate_winrt.cpp",
            "qsslcertificateextension.cpp",
            "qsslcipher.cpp",
            "qsslconfiguration.cpp",
            "qsslcontext_openssl.cpp",
            "qsslellipticcurve.cpp",
            "qsslellipticcurve_dummy.cpp",
            "qsslellipticcurve_openssl.cpp",
            "qsslerror.cpp",
            "qsslkey_openssl.cpp",
            "qsslkey_p.cpp",
            "qsslkey_qt.cpp",
            "qsslkey_winrt.cpp",
            "qsslsocket.cpp",
            "qsslsocket_openssl.cpp",
            "qsslsocket_openssl_android.cpp",
            "qsslsocket_openssl_symbols.cpp",
            "qsslsocket_winrt.cpp",
        ]
    }

    Export {
        Depends { name: "QtHost.includes" }
        QtHost.includes.modules: ["network", "network-private"]
    }
}