{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, wrapGAppsHook4
, gobject-introspection
, gtk4
, libadwaita
, gdk-pixbuf
, pango
, cairo
, glib
, gsettings-desktop-schemas
, adwaita-icon-theme
}:

buildGoModule (finalAttrs: {
  pname = "wiiudownloader";
  version = "3.2";

  src = fetchFromGitHub {
    owner = "Xpl0itU";
    repo = "WiiUDownloader";
    tag = "v${finalAttrs.version}";
    hash = "sha256-mCiYRoEwWtDQwQy9gFOAlcnsMyB4I1jW5h6NIIRLjGg=";
  };

  # Generated from https://napi.v10lator.de/db?t=go, the build-time database
  # upstream's CI fetches. Pinned here so the build is reproducible.
  postPatch = ''
    cp ${./wiiudownloader-db.go} db.go
  '';

  modRoot = "cmd/WiiUDownloader";
  vendorHash = "sha256-MfiKMzVKzDlZ77kGARkXEu9eynDQcqc74tGdQVwkKu4=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
    gobject-introspection
  ];

  buildInputs = [
    gtk4
    libadwaita
    gdk-pixbuf
    pango
    cairo
    glib
    gsettings-desktop-schemas
    adwaita-icon-theme
  ];

  postInstall = ''
    mv $out/bin/WiiUDownloader $out/bin/wiiudownloader
    install -Dm644 ${finalAttrs.src}/packaging/flatpak/io.github.xpl0itu.wiiudownloader.desktop \
      $out/share/applications/io.github.xpl0itu.wiiudownloader.desktop
    install -Dm644 ${finalAttrs.src}/cmd/WiiUDownloader/appicon.png \
      $out/share/icons/hicolor/512x512/apps/io.github.xpl0itu.wiiudownloader.png
  '';

  meta = {
    description = "Wii U NUS downloader";
    homepage = "https://github.com/Xpl0itU/WiiUDownloader";
    license = lib.licenses.gpl3Plus;
    mainProgram = "wiiudownloader";
    platforms = [ "x86_64-linux" ];
  };
})
