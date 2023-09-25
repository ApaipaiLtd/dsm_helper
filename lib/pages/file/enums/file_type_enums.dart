enum FileTypeEnum {
  folder(icon: "assets/icons/file_icons/folder.png"),
  image(icon: "assets/icons/file_icons/image.png"),
  movie(icon: "assets/icons/file_icons/video.png"),
  music(icon: "assets/icons/file_icons/music.png"),
  ps(icon: "assets/icons/file_icons/psd.png"),
  html(icon: "assets/icons/file_icons/code.png"),
  word(icon: "assets/icons/file_icons/word.png"),
  ppt(icon: "assets/icons/file_icons/ppt.png"),
  excel(icon: "assets/icons/file_icons/excel.png"),
  text(icon: "assets/icons/file_icons/txt.png"),
  zip(icon: "assets/icons/file_icons/zip.png"),
  code(icon: "assets/icons/file_icons/code.png"),
  other(icon: "assets/icons/file_icons/other.png"),
  pdf(icon: "assets/icons/file_icons/pdf.png"),
  apk(icon: "assets/icons/file_icons/apk.png"),
  iso(icon: "assets/icons/file_icons/iso.png");

  final String icon;
  const FileTypeEnum({required this.icon});
}
