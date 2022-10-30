# Lazycat Labs with Flutter Web

This is project for my personal web and created using **Flutter Web**


## Pre-requisites

| Technology | Minimum Version | Installation Guide                                                    |  
|------------|-----------------|-----------------------------------------------------------------------|  
| Flutter    | v3.3.6          | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |  
| Dart       | v2.18.2         | Installed automatically with Flutter                                  |  

<br/>

## Getting Started 🚀

- Clone this project
- Run `flutter pub get`
- Run `flutter gen-l10n` to generate localization files
- Run `flutter run --web-renderer html`

<br/>

## Project Structure 📈

<details>
<summary>Expand to show</summary>

```
.
├── README.md
├── analysis_options.yaml
├── assets
│   ├── fonts
│   │   ├── Circe.otf
│   │   └── visuelt
│   │       ├── VisueltPro-Black.ttf
│   │       ├── VisueltPro-BlackItalic.ttf
│   │       ├── VisueltPro-Bold.ttf
│   │       ├── VisueltPro-BoldItalic.ttf
│   │       ├── VisueltPro-ExtraLight.ttf
│   │       ├── VisueltPro-ExtraLightItalic.ttf
│   │       ├── VisueltPro-Italic.ttf
│   │       ├── VisueltPro-Light.ttf
│   │       ├── VisueltPro-LightItalic.ttf
│   │       ├── VisueltPro-Medium.ttf
│   │       ├── VisueltPro-MediumItalic.ttf
│   │       ├── VisueltPro-Regular.ttf
│   │       ├── VisueltPro-Thin.ttf
│   │       └── VisueltPro-ThinItalic.ttf
│   ├── images
│   │   ├── ic_avatar.png
│   │   ├── ic_close.svg
│   │   ├── ic_facebook.svg
│   │   ├── ic_github.svg
│   │   ├── ic_instagram.svg
│   │   ├── ic_launcher.jpg
│   │   ├── ic_launcher_staging.jpg
│   │   ├── ic_linkedin.svg
│   │   ├── ic_logo.svg
│   │   ├── ic_logo_text.svg
│   │   ├── ic_logo_text_oneline.svg
│   │   ├── ic_menu.svg
│   │   ├── ic_playstore.png
│   │   ├── ic_profile.jpg
│   │   ├── ic_settings.svg
│   │   ├── ic_tiktok.svg
│   │   ├── ic_upwork.svg
│   │   ├── ic_youtube.svg
│   │   └── portfolio
│   │       ├── brupedia
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   └── image_3.png
│   │       ├── eabsensi
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   ├── image_3.png
│   │       │   └── image_4.png
│   │       ├── myananda
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   ├── image_3.png
│   │       │   ├── image_4.png
│   │       │   └── image_5.png
│   │       ├── oifyoo
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   ├── image_3.png
│   │       │   ├── image_4.png
│   │       │   └── image_5.png
│   │       ├── patapaowners
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   └── image_3.png
│   │       ├── pataparking
│   │       │   ├── image_1.png
│   │       │   ├── image_2.png
│   │       │   └── image_3.png
│   │       └── wautils
│   │           ├── image_1.png
│   │           ├── image_2.png
│   │           ├── image_3.png
│   │           └── image_4.png
│   └── static_api
│       ├── portfolio_en.json
│       └── portfolio_id.json
├── l10n.yaml
├── lazycatlabs.iml
├── lib
│   ├── core
│   │   ├── core.dart
│   │   └── localization
│   │       ├── generated
│   │       │   ├── strings.dart
│   │       │   ├── strings_en.dart
│   │       │   └── strings_id.dart
│   │       ├── intl_en.arb
│   │       ├── intl_id.arb
│   │       ├── l10n.dart
│   │       └── localization.dart
│   ├── data
│   │   ├── data.dart
│   │   └── datasources
│   │       ├── datasources.dart
│   │       └── local
│   │           ├── data_helper.dart
│   │           ├── local.dart
│   │           ├── portfolio_response.dart
│   │           └── pref_manager.dart
│   ├── di
│   │   └── di.dart
│   ├── main.dart
│   ├── presentation
│   │   ├── pages
│   │   │   ├── app_route.dart
│   │   │   ├── main
│   │   │   │   ├── footer.dart
│   │   │   │   ├── footer_copy_right.dart
│   │   │   │   ├── home
│   │   │   │   │   ├── home.dart
│   │   │   │   │   ├── home_description.dart
│   │   │   │   │   ├── home_section.dart
│   │   │   │   │   └── home_title.dart
│   │   │   │   ├── main.dart
│   │   │   │   ├── main_cubit.dart
│   │   │   │   ├── main_drawer.dart
│   │   │   │   ├── main_menu.dart
│   │   │   │   ├── main_page.dart
│   │   │   │   ├── main_popup_menu.dart
│   │   │   │   ├── portfolio
│   │   │   │   │   ├── portfolio.dart
│   │   │   │   │   ├── portfolio_description.dart
│   │   │   │   │   ├── portfolio_section.dart
│   │   │   │   │   └── portfolio_title.dart
│   │   │   │   ├── profile
│   │   │   │   │   ├── profile.dart
│   │   │   │   │   ├── profile_button.dart
│   │   │   │   │   ├── profile_description.dart
│   │   │   │   │   ├── profile_section.dart
│   │   │   │   │   └── profile_title.dart
│   │   │   │   └── services
│   │   │   │       ├── services.dart
│   │   │   │       ├── services_description.dart
│   │   │   │       ├── services_section.dart
│   │   │   │       └── services_title.dart
│   │   │   └── pages.dart
│   │   ├── presentation.dart
│   │   ├── resources
│   │   │   ├── dimens.dart
│   │   │   ├── images.dart
│   │   │   ├── palette.dart
│   │   │   ├── resources.dart
│   │   │   └── styles.dart
│   │   └── widgets
│   │       ├── animated_box_slider.dart
│   │       ├── animated_button.dart
│   │       ├── animated_mouse.dart
│   │       ├── animated_text_box.dart
│   │       ├── animated_text_strikethrough.dart
│   │       ├── animated_widget_shape.dart
│   │       ├── animated_widget_slider.dart
│   │       ├── circle_image.dart
│   │       ├── image_network.dart
│   │       ├── indicator_slider.dart
│   │       ├── parent.dart
│   │       ├── responsive.dart
│   │       ├── scroll_indicator.dart
│   │       ├── spacer_h.dart
│   │       ├── spacer_v.dart
│   │       └── widgets.dart
│   └── utils
│       ├── ext
│       │   ├── context.dart
│       │   ├── double.dart
│       │   └── ext.dart
│       ├── helper
│       │   ├── common.dart
│       │   ├── constant.dart
│       │   └── helper.dart
│       ├── services
│       │   └── services.dart
│       └── utils.dart
├── pubspec.lock
├── pubspec.yaml
└── web
    ├── fav
    │   ├── android-chrome-192x192.png
    │   ├── android-chrome-512x512.png
    │   ├── apple-touch-icon.png
    │   ├── browserconfig.xml
    │   ├── favicon-16x16.png
    │   ├── favicon-32x32.png
    │   ├── favicon.ico
    │   ├── mstile-150x150.png
    │   ├── safari-pinned-tab.svg
    │   └── site.webmanifest
    ├── icon.svg
    ├── index.html
    └── manifest.json
```  

</details>

<br/>

## Preview 🧑🏻‍💻

### Website 🌎

https://lazycatlabs.com/

### Video 📹

<div align="left">
  <a href="https://www.youtube.com/watch?v=y07lDPzfVgk">
    <img src="https://img.youtube.com/vi/y07lDPzfVgk/0.jpg" style="width:60%;">
  </a>
</div>

<br/>

## Support Me 🎗️

<p>
  <a href="https://www.buymeacoffee.com/Lzyct" target="_blank">
    <img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" alt="buymeacoffe" style="vertical-align:top; margin:8px" height="36" />
  </a>
  <a href="https://ko-fi.com/Lzyct" target="_blank">
    <img src="https://help.ko-fi.com/system/photos/3604/0095/9793/logo_circle.png" alt="ko-fi" style="vertical-align:top; margin:8px" height="36" />
  </a>
  <a href="https://paypal.me/ukieTux" target="_blank">
    <img src="https://blog.zoom.us/wp-content/uploads/2019/08/paypal.png" alt="paypal" style="vertical-align:top; margin:8px" height="36" />
  </a>
  <a href="https://saweria.co/Lzyct" target="_blank">
    <img src="https://1.bp.blogspot.com/-7OuHSxaNk6A/X92QPg8L9kI/AAAAAAAAG0E/lUzKf_uuVP8jCqvXpA7juh_l-TfK2jnbwCLcBGAsYHQ/s16000/SAWERIA.webp" style="vertical-align:top; margin:8px" height="36" />
  </a>
</p>

<br/>

## Follow Me 🫰🏻

<p>
  <a href="https://github.com/lazycatlabs" target="_blank">
    <img src="https://github.com/fluidicon.png" alt="github" style="vertical-align:top; margin:8px" height="36">
  </a>
  <a href="https://www.facebook.com/lazycatlabs/" target="_blank">
    <img src="https://img.icons8.com/color/344/facebook-new.png" alt="facebook" style="vertical-align:top; margin:8px" height="36">
  </a>
  <a href="https://www.instagram.com/lazycatlabs/" target="_blank">
    <img src="https://img.icons8.com/fluency/344/instagram-new.png" alt="instagram" style="vertical-align:top; margin:8px" height="36">
  </a>
  <a href="https://www.tiktok.com/@lazycatlabs" target="_blank">
    <img src="https://img.icons8.com/fluency/344/tiktok.png" alt="tiktok" style="vertical-align:top; margin:8px" height="36">
  </a>
  <a href="https://www.youtube.com/channel/UCzXKJlJHPIsQKhvuzHQ7ImA" target="_blank">
    <img src="https://img.icons8.com/fluency/344/youtube-play.png" alt="youtube" style="vertical-align:top; margin:8px" height="36">
  </a>
</p> 

<br/>

<a href="https://play.google.com/store/apps/dev?id=6313853259913767184" target="_blank">
  <img src="https://www.pngall.com/wp-content/uploads/10/Google-Play-PNG-Clipart.png" alt="playstore" style="vertical-align:top; margin:8px" height="136">
</a>
