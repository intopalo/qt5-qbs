import qbs

QtPlugin {
    targetName: name + "-integration"
    readonly property string basePath: project.sourcePath + "/qtbase/src/plugins/platforms/eglfs/deviceintegration"

    category: "egldeviceintegrations"

    cpp.includePaths: [
        project.sourcePath + "/qtbase/src/plugins/platforms/eglfs",
    ].concat(base)

    includeDependencies: ["QtCore-private", "QtGui-private", "QtPlatformSupport-private"]

    Depends { name: "egl" }
    Depends { name: "QtCore" }
    Depends { name: "QtGui" }
    Depends { name: "QtEglDeviceIntegration" }
}
