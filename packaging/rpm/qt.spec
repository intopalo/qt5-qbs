Summary: Qt
Name: Qt
Version: %{qtversion}
Release: git+%(git --git-dir=%{_sourcedir}/qt5/.git rev-parse --short HEAD)
License: LGPL2.1
Group: Frameworks
URL: https://github.com/intopalo/qt5-qbs
Vendor: Qt Project
Packager: Andrew Knight <andrew.knight@intopalo.com>
# Make sure the git checkouts (or symlinks) are in $HOME/rpmbuild/SOURCES
Source0: qt5-qbs
Source1: qt5

%description
Qt is a cross-platform C++ application framework.
Qt's primary feature is its rich set of widgets that
provide standard GUI functionality.
This package was built using QBS, the Qt Build Suite.

%prep

%build
qbs install --install-root %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/opt/Qt/%{qtversion} \
    -f %{_sourcedir}/qt5-qbs/qt.qbs project.sourcePath:%{_sourcedir}/qt5 project.prefix:/opt/Qt/%{qtversion} %{qbsargs}

%files
/opt/Qt/%{qtversion}/bin/*
/opt/Qt/%{qtversion}/include/*
/opt/Qt/%{qtversion}/lib/*
/opt/Qt/%{qtversion}/mkspecs/*
/opt/Qt/%{qtversion}/plugins/*
/opt/Qt/%{qtversion}/qml/*
