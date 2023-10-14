class DsmImage {
  final String loginBackgroundImage;
  final String desktopBackgroundImage;

  const DsmImage.v6()
      : loginBackgroundImage = 'webman/resources/images/default/1x/default_login_background/dsm6_01.jpg',
        desktopBackgroundImage = 'webman/resources/images/default/1x/default_wallpaper/dsm6_01.jpg';
  const DsmImage.v7()
      : loginBackgroundImage = 'webman/resources/images/2x/default_login_background/dsm7_01.jpg',
        desktopBackgroundImage = 'webman/resources/images/2x/default_wallpaper/dsm7_01.jpg';
  const DsmImage({
    required this.loginBackgroundImage,
    required this.desktopBackgroundImage,
  });
}
