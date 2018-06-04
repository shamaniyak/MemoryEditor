import qbs
import qbs.FileInfo

AndroidApk {
    minimumQbsVersion: "1.7.1"
    name: "Basic Media Decoder"
        packageName: "com.example.android.basicmediadecoder"

        property string sourcesPrefix: "Application/src/main/"

        resourcesDir: sourcesPrefix + "/res"
        sourcesDir: sourcesPrefix + "/java"
        manifestFile: sourcesPrefix + "/AndroidManifest.xml"

// help
//    aggregate : bool
//    buildDirectory : path
//    builtByDefault : bool
//    condition : bool
//    consoleApplication : bool
//    destinationDirectory : string
//    excludeFiles : stringList
//    files : stringList
//    multiplexByQbsProperties : stringList
//    multiplexedType : stringList
//    name : string
//    qbsSearchPaths : stringList
//    sourceDirectory : path
//    targetName : string
//    type : stringList
//    version : string

//    property string globalPath: FileInfo.path(sourceDirectory + "/../")
//    property string globalBinPath: globalPath + "/bin"
//    property string globalModulesPath: globalBinPath + "/qml"
//    property string globalIncludePath: globalPath + "/Src"

//    references: [
//        "memorymanager/memorymanager.qbs",
//        "app/app.qbs"
//    ]
}
