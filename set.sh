# this files changes the app icon and sets the key files in respective places for generating build
cd android/app/src/main/res
rm -rf mipmap-hdpi && rm -rf mipmap-mdpi && rm -rf mipmap-xhdpi && rm -rf mipmap-xxhdpi && rm -rf mipmap-xxxhdpi
cd .. && cd .. && cd .. && cd .. && cd ..
# replacing the logo
cp -R assets/AppIcons/android/mipmap-hdpi android/app/src/main/res
cp -R assets/AppIcons/android/mipmap-mdpi android/app/src/main/res
cp -R assets/AppIcons/android/mipmap-xhdpi android/app/src/main/res
cp -R assets/AppIcons/android/mipmap-xxhdpi android/app/src/main/res
cp -R assets/AppIcons/android/mipmap-xxxhdpi android/app/src/main/res
# key store config files added inside android folder
cp key.properties android/
cp key.properties android/app
# updating the keystore files inside android folder
cp keystore android/
cp keystore android/app