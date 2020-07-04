<h1>KARO</h1>

![KARO](https://cdn.discordapp.com/attachments/718781431144251454/728028916828209273/cf236637-f8f5-4c04-91ed-20ef3d281574_200x200_1_3.png)
<h2> University Community Cross-Platform Application</h2>

<h3>Installation steps</h3>

**Get the Flutter SDK**
- Download the [installation bundle](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.17.5-stable.zip) to get the latest stable release of the Flutter SDK.
- Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (for example, C:\src\flutter; do not install Flutter in a directory like C:\Program Files\ that requires elevated privileges).

**Run flutter doctor**
- From a console window that has the Flutter directory in the path, run the following command to see if there are any platform dependencies you need to complete the setup:
```
C:\src\flutter>flutter doctor
```
<h4>Android setup</h4>

**Install Android Studio**
- Download and install Android Studio.
- Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, which are required by Flutter when developing for Android.

**Set up your Android device**
To prepare to run and test your Flutter app on an Android device, you need an Android device running Android 4.1 (API level 16) or higher.

**1.** Enable Developer options and USB debugging on your device. Detailed instructions are available in the Android documentation.

**2.** Windows-only: Install the Google USB Driver.

**3.** Using a USB cable, plug your phone into your computer. If prompted on your device, authorize your computer to access your device.

**4.** In the terminal, run the flutter devices command to verify that Flutter recognizes your connected Android device. By default, Flutter uses the version of the Android SDK where your adb tool is based. If you want Flutter to use a different installation of the Android SDK, you must set the ANDROID_SDK_ROOT environment variable to that installation directory.

**Set up the Android emulator**
To prepare to run and test your Flutter app on the Android emulator, follow these steps:

- Enable VM acceleration on your machine.
- Launch **Android Studio > Tools > Android > AVD Manager** and select **Create Virtual Device**. (The **Android** submenu is only present when inside an Android project.)
- Choose a device definition and select **Next**.
- Select one or more system images for the Android versions you want to emulate, and select **Next**. An x86 or x86_64 image is recommended.
- Under Emulated Performance, select **Hardware - GLES 2.0** to enable hardware acceleration.
Verify the AVD configuration is correct, and select **Finish**.

For details on the above steps, see Managing AVDs.

In Android Virtual Device Manager, click **Run** in the toolbar. The emulator starts up and displays the default canvas for your selected OS version and device.

**Install the Flutter and Dart plugins**

To install these:

**1.** Start Android Studio.

**2.** Open plugin preferences (**Configure > Plugins** as of v3.6.3.0 or later).

**3.** Select the Flutter plugin and click **Install**.

**4.** Click **Yes** when prompted to install the Dart plugin.

**5.** Click **Restart** when prompted.

> **Note**: Prior to v3.6.3.0, access plugin preferences as follows:
>Open plugin preferences (**Preferences > Plugins** on macOS, **File > Settings > Plugins** on Windows & Linux).
>Select **Marketplace**, select the Flutter plugin and click **Install**.

**Run App**

```
flutter run karo
flutter build apk
```

