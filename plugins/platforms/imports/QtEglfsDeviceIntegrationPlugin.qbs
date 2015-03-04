import qbs

QtPlugin {
    readonly property string basePath: project.sourceDirectory + "/qtbase/src/plugins/platforms/eglfs/deviceintegration"

    category: "platforms"

    cpp.cxxFlags: base.concat(cxxFlags)
    cpp.dynamicLibraries: base.concat(eglDynamicLibraries)
    cpp.includePaths: base.concat(includePaths)
    cpp.libraryPaths: base.concat(libraryPaths)

    includeDependencies: ["QtCore-private", "QtGui-private", "QtPlatformSupport-private"]

    Depends { name: "QtCore" }
    Depends { name: "QtGui" }
    Depends { name: "QtEglDeviceIntegration" }
}
