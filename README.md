<img width="280" alt="Screenshot 2023-08-22 at 6 08 41 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/807e5349-00a1-46e3-ae45-22819210a59c"><img width="280" alt="Screenshot 2023-08-22 at 6 08 33 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/0cfcc045-db28-4c9c-995b-d243a4659022"># s_todo

A TODO Application build using Flutter.
# Available in Android 
- link : https://play.google.com/store/apps/details?id=io.cordova.s_todo
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

- signingConfigs{
        release{
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    
- applicationId "com.example.nexttime" ( change app id here )
- minSdkVersion set based on your config
# Release Command 
APK : flutter build apk --release or flutter build apk --release --no-tree-shake-icons
Bundle : flutter build appbundle --release --no-tree-shake-icons
# Screenshots

<img width="280" alt="Screenshot 2023-08-22 at 6 08 48 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/372e1fee-5529-43d8-9e52-04d70377af5f">
<img width="280" alt="Screenshot 2023-08-22 at 6 08 45 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/60e98d6f-e885-45c9-b8d3-ba103a5d5a7b">
<img width="280" alt="Screenshot 2023-08-22 at 6 08 41 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/41c0390e-75b1-4b69-b4c3-cbdd089576b4">
<img width="280" alt="Screenshot 2023-08-22 at 6 08 37 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/82c56249-72d3-4077-93e9-721afeab21bb">
<img width="280" alt="Screenshot 2023-08-22 at 6 08 33 PM" src="https://github.com/sivajaffey/stodo/assets/53942949/8d2acb1e-2378-4b90-8167-bc3cfce81d89">

