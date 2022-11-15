/// classical_desktop : "classical"
/// customize_color : false
/// customize_wallpaper : true
/// index : 6
/// menu_style : "classical"
/// newImage : false
/// wallpaper : 17
/// wallpaper_ext : ""
/// wallpaper_path : "/usr/syno/etc/preference/admin/3.png"
/// wallpaper_position : "fill"
/// wallpaper_type : "history"

class WallpaperModel {
  WallpaperModel({
    this.classicalDesktop,
    this.customizeColor,
    this.customizeWallpaper: false,
    this.index,
    this.menuStyle,
    this.newImage,
    this.wallpaper,
    this.wallpaperExt,
    this.wallpaperPath,
    this.wallpaperPosition,
    this.wallpaperType,
  });

  WallpaperModel.fromJson(dynamic json) {
    if (json != null) {
      classicalDesktop = json['classical_desktop'];
      customizeColor = json['customize_color'];
      customizeWallpaper = json['customize_wallpaper'] ?? false;
      index = json['index'];
      menuStyle = json['menu_style'];
      newImage = json['newImage'];
      wallpaper = json['wallpaper'];
      wallpaperExt = json['wallpaper_ext'];
      wallpaperPath = json['wallpaper_path'];
      wallpaperPosition = json['wallpaper_position'];
      customizeBackground = json['customize_background'] ?? false;
      customizeBackgroundType = json['customize_background_type'];
      wallpaperType = json['wallpaper_type'];
    }
  }
  String classicalDesktop;
  bool customizeColor;
  bool customizeWallpaper = false;
  bool customizeBackground = false;
  String customizeBackgroundType = "image";
  int index;
  String menuStyle;
  bool newImage;
  int wallpaper;
  String wallpaperExt;
  String wallpaperPath;
  String wallpaperPosition;
  String wallpaperType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classical_desktop'] = classicalDesktop;
    map['customize_color'] = customizeColor;
    map['customize_wallpaper'] = customizeWallpaper;
    map['customize_background'] = customizeBackground;
    map['customize_background_type'] = customizeBackgroundType;
    map['index'] = index;
    map['menu_style'] = menuStyle;
    map['newImage'] = newImage;
    map['wallpaper'] = wallpaper;
    map['wallpaper_ext'] = wallpaperExt;
    map['wallpaper_path'] = wallpaperPath;
    map['wallpaper_position'] = wallpaperPosition;
    map['wallpaper_type'] = wallpaperType;
    return map;
  }
}
