
TARGET = stellariumMobile
VERSION = 0.12.3
MOBILE_VERSION = 1.30.4
INCLUDEPATH += \
	. src/ src/core src/core/modules src/core/external \
	src/core/external/glues_stel/source src/core/external/kfilter \
	src/core/external/gsatellite \
	src/core/external/glues_stel/source src/core/external/qtcompress \
	src/core/planetsephems src/scripting

TEMPLATE = app
QT += network gui sensors qml quick positioning concurrent widgets

android {
	QT += androidextras
}
CONFIG += qt thread
#CONFIG += release

LIBS += -lz

QMAKE_CFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-unused-parameter


CONFIG(debug, debug|release) {

} else {
  DEFINES += NDEBUG QT_NO_DEBUG
  message(Building release version)
}

RESOURCES += data/mainRes.qrc

QMAKE_CXXFLAGS_RELEASE += -Ofast

android {
	QT += androidextras
	ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
	ANDROID_PACKAGE = com.ultrapre.stellarium
        ANDROID_MINIMUM_VERSION = 26
        ANDROID_TARGET_VERSION = 26
	ANDROID_APP_NAME = Stellarium Mobile

	data_dir.source = mobileData/data
	data_dir.path = data
	landscapes_dir.source = mobileData/landscapes
	landscapes_dir.path = landscapes
	nebulae_dir.source = mobileData/nebulae
	nebulae_dir.path = nebulae
	skycultures_dir.source = mobileData/skycultures
	skycultures_dir.path = skycultures
	stars_dir.source = mobileData/stars
	stars_dir.path = stars
	textures_dir.source = mobileData/textures
	textures_dir.path = textures
	translations_dir.source = mobileData/translations
	translations_dir.path = translations
	DEPLOYMENTFOLDERS = data_dir textures_dir landscapes_dir nebulae_dir skycultures_dir stars_dir translations_dir

	include(deployment.pri)

        ANDROID_EXTRA_LIBS = \
        $$PWD/libcrypto_1_1.so \
        $$PWD/libssl_1_1.so

}

ios {
	data_dir.files = $$PWD/mobileData/data
	landscapes_dir.files = $$PWD/mobileData/landscapes
	nebulae_dir.files = $$PWD/mobileData/nebulae
	skycultures_dir.files = $$PWD/mobileData/skycultures
	stars_dir.files = $$PWD/mobileData/stars
	textures_dir.files = $$PWD/mobileData/textures
	translations_dir.files = $$PWD/mobileData/translations
	app_launch_images.files = $$PWD/ios/Launch.xib
	QMAKE_BUNDLE_DATA += data_dir landscapes_dir nebulae_dir skycultures_dir stars_dir textures_dir translations_dir app_launch_images
	QMAKE_INFO_PLIST = ios/Info.plist
	OBJECTIVE_SOURCES += src/core/modules/SensorsMgr.mm
	# QMAKE_ASSET_CATALOGS += ios/Images.xcassets
}

HEADERS += \
	src/config.h \
	src/core/StelOpenGL.hpp \
	src/core/StelToast.hpp \
	src/core/StelToastGrid.hpp \
	src/core/modules/CCD.hpp \
	src/core/modules/Lens.hpp \
	src/core/modules/Ocular.hpp \
	src/core/modules/Oculars.hpp \
	src/core/modules/SolarSystemEditor.hpp \
	src/core/modules/Telescope.hpp \
	src/core/modules/ToastMgr.hpp \
	src/core/modules/updatecomets.h \
	src/translations.h \
	src/CLIProcessor.hpp \
	src/StelAndroid.hpp \
	src/StelLogger.hpp \
	src/StelMainView.hpp

SOURCES += \
	src/CLIProcessor.cpp \
	src/core/StelOpenGL.cpp \
	src/core/StelToast.cpp \
	src/core/StelToastGrid.cpp \
	src/core/modules/CCD.cpp \
	src/core/modules/Lens.cpp \
	src/core/modules/Ocular.cpp \
	src/core/modules/Oculars.cpp \
	src/core/modules/SolarSystemEditor.cpp \
	src/core/modules/Telescope.cpp \
	src/core/modules/ToastMgr.cpp \
	src/core/modules/updatecomets.cpp \
	src/main.cpp \
	src/StelLogger.cpp \
	src/StelMainView.cpp

android {
	HEADERS += \
		src/StelAndroid.hpp
	SOURCES += \
		src/StelAndroid.cpp
}

DEFINES += DISABLE_SCRIPTING
DEFINES += ENABLE_NLS
DEFINES += PACKAGE_VERSION_NOSTR=$${VERSION}
DEFINES += MOBILE_GUI_VERSION_NOSTR=$${MOBILE_VERSION}
DEFINES += INSTALL_DATADIR_NOSTR=

contains(QT, quick) {
	DEFINES += USE_QUICKVIEW
	SOURCES += src/StelQuickView.cpp src/StelQuickStelItem.cpp
	HEADERS += src/StelQuickView.hpp src/StelQuickStelItem.hpp
}

# Core files
HEADERS += \
	src/CLIProcessor.hpp \
	src/StelLogger.hpp \
	src/core/MultiLevelJsonBase.hpp \
	src/core/OctahedronPolygon.hpp \
	src/core/RefractionExtinction.hpp \
	src/core/SimbadSearcher.hpp \
	src/core/SphericMirrorCalculator.hpp \
	src/core/StelActionMgr.hpp \
	src/core/StelApp.hpp \
	src/core/StelAudioMgr.hpp \
	src/core/StelCore.hpp \
	src/core/StelFader.hpp \
	src/core/StelFileMgr.hpp \
	src/core/StelGeodesicGrid.hpp \
	src/core/StelGuiBase.hpp \
	src/core/StelIniParser.hpp \
	src/core/StelJsonParser.hpp \
	src/core/StelLocaleMgr.hpp \
	src/core/StelLocation.hpp \
	src/core/StelLocationMgr.hpp \
	src/core/StelModule.hpp \
	src/core/StelModuleMgr.hpp \
	src/core/StelMovementMgr.hpp \
	src/core/StelObject.hpp \
	src/core/StelObjectMgr.hpp \
	src/core/StelObjectModule.hpp \
	src/core/StelObjectType.hpp \
	src/core/StelObserver.hpp \
	src/core/StelPainter.hpp \
	src/core/StelPluginInterface.hpp \
	src/core/StelProjectorClasses.hpp \
	src/core/StelProjector.hpp \
	src/core/StelProjectorType.hpp \
	src/core/StelProgressController.hpp \
	src/core/StelRegionObject.hpp \
	src/core/StelSkyCultureMgr.hpp \
	src/core/StelSkyDrawer.hpp \
	src/core/StelSkyImageTile.hpp \
	src/core/StelSkyLayer.hpp \
	src/core/StelSkyLayerMgr.hpp \
	src/core/StelSkyPolygon.hpp \
	src/core/StelSphereGeometry.hpp \
	src/core/StelSphericalIndex.hpp \
	src/core/StelTexture.hpp \
	src/core/StelTextureMgr.hpp \
	src/core/StelTextureTypes.hpp \
	src/core/StelToneReproducer.hpp \
	src/core/StelTranslator.hpp \
	src/core/StelUtils.hpp \
	src/core/StelVertexArray.hpp \
	src/core/StelVideoMgr.hpp \
	src/core/StelViewportEffect.hpp \
	src/core/TrailGroup.hpp \
	src/core/VecMath.hpp \
	src/core/modules/Atmosphere.hpp \
	src/core/modules/Comet.hpp \
	src/core/modules/Constellation.hpp \
	src/core/modules/ConstellationMgr.hpp \
	src/core/modules/GPSMgr.hpp \
	src/core/modules/GridLinesMgr.hpp \
	src/core/modules/LabelMgr.hpp \
	src/core/modules/Landscape.hpp \
	src/core/modules/LandscapeMgr.hpp \
	src/core/modules/Meteor.hpp \
	src/core/modules/MeteorMgr.hpp \
	src/core/modules/MilkyWay.hpp \
	src/core/modules/MinorPlanet.hpp \
	src/core/modules/Nebula.hpp \
	src/core/modules/NebulaMgr.hpp \
	src/core/modules/Orbit.hpp \
	src/core/modules/Planet.hpp \
	src/core/modules/Satellites.hpp \
	src/core/modules/Satellite.hpp \
	src/core/modules/Skybright.hpp \
	src/core/modules/Skylight.hpp \
	src/core/modules/SensorsMgr.hpp \
	src/core/modules/SolarSystem.hpp \
	src/core/modules/Solve.hpp \
	src/core/modules/Star.hpp \
	src/core/modules/StarMgr.hpp \
	src/core/modules/StarWrapper.hpp \
	src/core/modules/ZoneArray.hpp \
	src/core/modules/ZoneData.hpp \
	src/core/external/glues_stel/source/glues_error.h \
	src/core/external/glues_stel/source/glues.h \
	src/core/external/glues_stel/source/libtess/dict.h \
	src/core/external/glues_stel/source/libtess/dict-list.h \
	src/core/external/glues_stel/source/libtess/geom.h \
	src/core/external/glues_stel/source/libtess/memalloc.h \
	src/core/external/glues_stel/source/libtess/mesh.h \
	src/core/external/glues_stel/source/libtess/normal.h \
	src/core/external/glues_stel/source/libtess/priorityq.h \
	src/core/external/glues_stel/source/libtess/priorityq-heap.h \
	src/core/external/glues_stel/source/libtess/priorityq-sort.h \
	src/core/external/glues_stel/source/libtess/render.h \
	src/core/external/glues_stel/source/libtess/sweep.h \
	src/core/external/glues_stel/source/libtess/tess.h \
	src/core/external/glues_stel/source/libtess/tessmono.h \
	src/core/external/qtcompress/qzipreader.h \
	src/core/external/qtcompress/qzipwriter.h \
	src/core/planetsephems/calc_interpolated_elements.h \
	src/core/planetsephems/elliptic_to_rectangular.h \
	src/core/planetsephems/elp82b.h \
	src/core/planetsephems/gust86.h \
	src/core/planetsephems/l1.h \
	src/core/planetsephems/marssat.h \
	src/core/planetsephems/pluto.h \
	src/core/planetsephems/sideral_time.h \
	src/core/planetsephems/stellplanet.h \
	src/core/planetsephems/tass17.h \
	src/core/planetsephems/vsop87.h

SOURCES += \
	src/core/MultiLevelJsonBase.cpp \
	src/core/OctahedronPolygon.cpp \
	src/core/RefractionExtinction.cpp \
	src/core/SimbadSearcher.cpp \
	src/core/SphericMirrorCalculator.cpp \
	src/core/StelActionMgr.cpp \
	src/core/StelApp.cpp \
	src/core/StelAudioMgr.cpp \
	src/core/StelCore.cpp \
	src/core/StelFileMgr.cpp \
	src/core/StelGeodesicGrid.cpp \
	src/core/StelGuiBase.cpp \
	src/core/StelIniParser.cpp \
	src/core/StelJsonParser.cpp \
	src/core/StelLocaleMgr.cpp \
	src/core/StelLocation.cpp \
	src/core/StelLocationMgr.cpp \
	src/core/StelModule.cpp \
	src/core/StelModuleMgr.cpp \
	src/core/StelMovementMgr.cpp \
	src/core/StelObject.cpp \
	src/core/StelObjectMgr.cpp \
	src/core/StelObjectModule.cpp \
	src/core/StelObserver.cpp \
	src/core/StelPainter.cpp \
	src/core/StelProjectorClasses.cpp \
	src/core/StelProjector.cpp \
	src/core/StelSkyCultureMgr.cpp \
	src/core/StelSkyDrawer.cpp \
	src/core/StelSkyImageTile.cpp \
	src/core/StelSkyLayer.cpp \
	src/core/StelSkyLayerMgr.cpp \
	src/core/StelSkyPolygon.cpp \
	src/core/StelSphereGeometry.cpp \
	src/core/StelSphericalIndex.cpp \
	src/core/StelTexture.cpp \
	src/core/StelTextureMgr.cpp \
	src/core/StelToneReproducer.cpp \
	src/core/StelTranslator.cpp \
	src/core/StelUtils.cpp \
	src/core/StelVertexArray.cpp \
	src/core/StelVideoMgr.cpp \
	src/core/StelViewportEffect.cpp \
	src/core/TrailGroup.cpp \
    src/core/modules/gSatWrapper.cpp \
	src/core/modules/Atmosphere.cpp \
	src/core/modules/Comet.cpp \
	src/core/modules/Constellation.cpp \
	src/core/modules/ConstellationMgr.cpp \
	src/core/modules/GPSMgr.cpp \
	src/core/modules/GridLinesMgr.cpp \
	src/core/modules/LabelMgr.cpp \
	src/core/modules/Landscape.cpp \
	src/core/modules/LandscapeMgr.cpp \
	src/core/modules/Meteor.cpp \
	src/core/modules/MeteorMgr.cpp \
	src/core/modules/MilkyWay.cpp \
	src/core/modules/MinorPlanet.cpp \
	src/core/modules/Nebula.cpp \
	src/core/modules/NebulaMgr.cpp \
	src/core/modules/Orbit.cpp \
	src/core/modules/Planet.cpp \
	src/core/modules/SensorsMgr.cpp \
	src/core/modules/Satellite.cpp \
	src/core/modules/Satellites.cpp \
	src/core/modules/Skybright.cpp \
	src/core/modules/Skylight.cpp \
	src/core/modules/SolarSystem.cpp \
	src/core/modules/Star.cpp \
	src/core/modules/StarMgr.cpp \
	src/core/modules/StarWrapper.cpp \
	src/core/modules/ZoneArray.cpp \
	src/core/external/glues_stel/source/glues_error.c \
	src/core/external/glues_stel/source/libtess/dict.c \
	src/core/external/glues_stel/source/libtess/geom.c \
	src/core/external/glues_stel/source/libtess/memalloc.c \
	src/core/external/glues_stel/source/libtess/mesh.c \
	src/core/external/glues_stel/source/libtess/normal.c \
	src/core/external/glues_stel/source/libtess/priorityq.c \
	src/core/external/glues_stel/source/libtess/render.c \
	src/core/external/glues_stel/source/libtess/sweep.c \
	src/core/external/glues_stel/source/libtess/tess.c \
	src/core/external/glues_stel/source/libtess/tessmono.c \
        src/core/external/gsatellite/gSatTEME.cpp \
        src/core/external/gsatellite/gTime.cpp \
        src/core/external/gsatellite/gTimeSpan.cpp \
        src/core/external/gsatellite/gVector.cpp \
        src/core/external/gsatellite/sgp4ext.cpp \
        src/core/external/gsatellite/sgp4io.cpp \
        src/core/external/gsatellite/sgp4unit.cpp \
	src/core/external/qtcompress/qzip.cpp \
	src/core/planetsephems/calc_interpolated_elements.c \
	src/core/planetsephems/elliptic_to_rectangular.c \
	src/core/planetsephems/elp82b.c \
	src/core/planetsephems/gust86.c \
	src/core/planetsephems/l1.c \
	src/core/planetsephems/marssat.c \
	src/core/planetsephems/pluto.c \
	src/core/planetsephems/sideral_time.c \
	src/core/planetsephems/stellplanet.c \
	src/core/planetsephems/tass17.c \
        src/core/planetsephems/vsop87.c \
        src/core/VecMath.cpp \

OTHER_FILES += \
	data/qml/AboutDialog.qml \
	data/qml/ImageButton.qml \
	data/qml/InfoPanel.qml \
	data/qml/LandscapesDialog.qml \
	data/qml/LocationCityPicker.qml \
	data/qml/LocationDialog.qml \
	data/qml/LocationMap.qml \
	data/qml/main.qml \
	data/qml/QuickBar.qml \
	data/qml/SearchInput.qml \
	data/qml/Splash.qml \
	data/qml/StarloreDialog.qml \
	data/qml/SettingsPanel.qml \
	data/qml/StelButton.qml \
	data/qml/StelCheckBox.qml \
	data/qml/StelDialog.qml \
	data/qml/StelListItem.qml \
	data/qml/StelMessage.qml \
	data/qml/StelSpinBox.qml \
	data/qml/StelTimeSpinBox.qml \
	data/qml/TimeBar.qml \
	data/qml/TimeDialog.qml \
	data/qml/TouchPinchArea.qml \
	data/qml/AdvancedDialog.qml \
	data/qml/AnglePicker.qml \
	data/qml/ValuePicker.qml \
        data/qml/AdvancedSetting.qml \
        data/qml/Comets.qml \
        data/qml/Observation.qml \
        data/qml/ViewDSO.qml \
        data/qml/ViewDialog.qml \
        data/qml/ViewSky.qml \

DISTFILES += \
    mobile-guide/guide.md \
    android/AndroidManifest.xml \

ANDROID_ABIS = armeabi-v7a

contains(ANDROID_TARGET_ARCH,) {
    ANDROID_ABIS = \
        armeabi-v7a
}
TRANSLATIONS+=mobileData/translations/stellarium/stellarium.ts
