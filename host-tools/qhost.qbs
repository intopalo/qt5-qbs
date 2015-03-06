import qbs

QtProduct {
    type: "application"
    destinationDirectory: project.buildDirectory + "/bin"

    includeDependencies: ["QtCore"]

    files: "qhost_main.cpp"

    Depends { name: "QtBootstrap" }

    Properties {
        condition: qbs.targetOS.contains("gcc")
        cpp.cxxFlags: base.concat(["-std=c++11"])
    }

    Properties {
        condition: qbs.targetOS.contains("windows")
        cpp.dynamicLibraries: base.concat([
            "shell32",
            "ole32",
        ])
    }

    Group {
        fileTagsFilter: "application"
        qbs.install: true
        qbs.installDir: "bin"
    }
}
