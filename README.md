# s_todo

A TODO Application build using Flutter.

# Configure firebase 
- lib/firebase_options.dart will be missing, configuration commands below.

# Commmands

- dart pub global activate flutterfire_cli
- npm install -g firebase-tools
- flutterfire configure
- export PATH="$PATH":"$HOME/.pub-cache/bin"
these commands generates the firebase_options.dart file.

# Logo Generater
- https://www.appicon.co/ - generates logo image
- Go to android/app/src/main/res folder delete mipmap folders and replace with the mipmap folders from generated logo  

# Run 
firebase clean 
firebase run

# Generate apk dev ( mobile )
flutter build apk

# Generate release build ( mobile )
 ### Generate a keystore for release build 
 - command : keytool -genkey -v -keystore "Nameofthefile" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias "aliasname"
 ### Create a keystore file in root folder
 - Update the keystore file and password
    storePassword=demo0909
    keyPassword=key0909
    keyAlias=aliasname
    storeFile=./Nameofthefile.jks
 - Run command in root : ./set.sh ( This command copy file and update it inside android folder and replaces the app icon ).

add these lines into android/app/build.gradle

- def keystorePropertiesFile = rootProject.file('key.properties')
- def keystoreProperties = new Properties()
- keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
- applicationId "com.example.nexttime" ( change app id here )
- minSdkVersion set based on your config
# Release Command 
APK : flutter build apk --release or flutter build apk --release --no-tree-shake-icons
Bundle : flutter build appbundle --release --no-tree-shake-icons