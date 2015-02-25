import qbs

Product {
    type: "hpp"

    Depends { name: "QtHost.sync" }
    QtHost.sync.module: "QtNetwork"

    Group {
        name: "header_sync"
        fileTags: "header_sync"
        prefix: project.sourceDirectory + "/qtbase/src/"
        files: "network/access/qnetworkaccessmanager.h"
    }
}