import qbs
import qbs.Probes
import "../../qbs/utils.js" as Utils

Project {
    readonly property stringList includePaths: [
        project.sourceDirectory + "/qtbase/src/plugins/platforms/eglfs",
    ]

    qbsSearchPaths: ["../../qbs", "."]

    references: "eglfs-integration.qbs"

    QtPlugin {
        condition: configure.egl && qbs.targetOS.contains("linux")
        category: "platforms"
        targetName: "qeglfs"

        includeDependencies: ["QtCore", "QtGui-private", "QtPlatformSupport-private"]

        Depends { name: "egl" }
        Depends { name: "QtCore" }
        Depends { name: "QtGui" }
        Depends { name: "QtEglDeviceIntegration" }

        Group {
            name: "sources"
            prefix: project.sourceDirectory + "/qtbase/src/plugins/platforms/eglfs/"
            files: "qeglfsmain.cpp"
            fileTags: "moc"
            overrideTags: false
        }
    }

    SubProject {
        filePath: "eglfs-imx6.qbs"
    }

    SubProject {
        filePath: "eglfs-kms.qbs"
    }

    SubProject {
        filePath: "eglfs-x11.qbs"
    }
}
