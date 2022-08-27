# Social Share Kit
[![pub package](https://img.shields.io/pub/v/social_share_kit.svg)](https://pub.dartlang.org/packages/social_share_kit)
![GitHub Repo stars](https://img.shields.io/github/stars/kaiquegazola/social_share_kit)
![MIT License](https://img.shields.io/github/license/kaiquegazola/social_share_kit)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A Flutter plugin that's support share files to social media like Tiktok, Instagram, Facebook, WhatsApp, Telegram and more.

This plugin was heavily inspired on [social_share](https://pub.dev/packages/social_share).

🚧 CAVEAT: Work in progress 🚧

# Table of Contents
* [📱 Supported platforms](#-supported-platforms)
* [✨ Features](#-features)
* [🗺 Requirements](#-requirements)
* [🤖 Android Setup](#-android-setup)
* [🍎 iOS Setup](#-ios-setup)
* [📚 Usage](#-usage)
* [📑 License](#-license)

## 📱 Supported platforms
- Android 4.1+
- iOS 8.0+

## ✨ Features
- [ ] Copy to clipboard
- [ ] Native Share Options
- [ ] Facebook Share
  - [ ] Story
  - [ ] Post
- [ ] Instagram Share
  - [ ] Story
  - [ ] Post
  - [ ] Direct
- [ ] Messenger Share
  - [ ] Video
  - [ ] Image
- [ ] Telegram
  - [ ] Image
  - [ ] Video
- [ ] TikTok Share
  - [x] Green Screen
    - [x] Video
    - [x] Image
- [ ] WhatsApp
  - [ ] Status
  - [ ] Image
  - [ ] Video

## 🗺 Requirements

### Facebook
You will need an application registered with [Facebook Developers](https://developers.facebook.com/apps/).
When setting up Android and iOS platforms, you will enter the Facebook AppID in some configuration files.

### TikTok
You will need an application registered with [TikTok Developers](https://developers.tiktok.com/doc/getting-started-create-an-app/).
When setting up Android and iOS platforms, you will enter the TikTok Client Key in some configuration files.

## 🤖 Android Setup

### First, you need to declare a FileProvider in `AndroidManifest.xml`.
To use the package's FileProvider, you will have to replace any other low priority authorities, in `manifest` tag import android `tools` namespace:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.example">
</manifest>
```

Register the package's FileProvider authority by putting the following configuration in `<manifest><application>`:

```xml
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.dev.kaique.social_share_kit"
    android:exported="false"
    android:grantUriPermissions="true"
    tools:replace="android:authorities">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            android:resource="@xml/file_provider_paths" />
</provider>
```

🕵 Tip: if you use other packages that use FileProvider, you can declare multiple authorities separated by semicolons, as in the example:

```xml
<!-- other attributes suppressed for better readability -->
<provider
    android:authorities="${applicationId}.dev.kaique.social_share_kit;${applicationId}.com.shekarmudaliyar.social_share">
</provider>
```

Now create a file named `file_provider_paths.xml` in `res/xml`, putting the following content:

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
  <cache-path name="image" path="/"/>
</paths>
```

---

If you are going to share in **Facebook**, insert the following block of code in `<manifest><application>`:
```xml
<!-- Facebook App ID -->
<meta-data android:name="com.facebook.sdk.ApplicationId"
        android:value="INSERT YOUR APP ID FROM FACEBOOK DEVELOPERS"/>
```

If you are going to share in **TikTok**, insert the following block of code in `<manifest><application>`:
```xml
<!-- TikTok Client key -->
<meta-data android:name="TikTokAppID"
    android:value="INSERT YOUR CLIENT KEY FROM TIKTOK DEVELOPERS"/>
```

## 🍎 iOS Setup

## 📚 Usage

## 📑 License
[MIT License](LICENSE)
