{ config, pkgs, ... }:
let
  gtk-css = pkgs.writeText "gtk.css" ''
    /* Special */
    @define-color cursor {{cursor}};
    @define-color background {{background}};
    @define-color foreground {{foreground}};

    /* Colors */
    @define-color color0  {{color0 }};
    @define-color color1  {{color1 }};
    @define-color color2  {{color2 }};
    @define-color color3  {{color3 }};
    @define-color color4  {{color4 }};
    @define-color color5  {{color5 }};
    @define-color color6  {{color6 }};
    @define-color color7  {{color7 }};
    @define-color color8  {{color8 }};
    @define-color color9  {{color9 }};
    @define-color color10 {{color10}};
    @define-color color11 {{color11}};
    @define-color color12 {{color12}};
    @define-color color13 {{color13}};
    @define-color color14 {{color14}};
    @define-color color15 {{color15}};
  '';
in {
  programs.wallust = {
    enable = true;
    settings = {
      backend = "full";
      color_space = "lch";
      palette = "dark16";
      check_contrast = true;
      templates = with config.xdg; {
        hyprland =  {
          template = pkgs.writeText "hyprland-colors.conf" ''
            general {
                col.active_border = rgb({{color14 | strip}})
                # color0 is almost the same as the background color,
                col.inactive_border = rgba({{color6 | strip}}{{alpha | alpha_hexa}})
            }
          '';
          target = "${configHome}/hypr/colors.conf";
        };
        foot = {
          template = pkgs.writeText "foot-colors.ini" ''
            [colors]
            background={{background | strip}}
            foreground={{foreground | strip}}

            flash={{cursor | strip}}

            ## Normal/regular colors (color palette 0-7)
            regular0={{color0 | strip}}  # black
            regular1={{color1 | strip}}  # red
            regular2={{color2 | strip}}  # green
            regular3={{color3 | strip}}  # yellow
            regular4={{color4 | strip}}  # blue
            regular5={{color5 | strip}}  # magenta
            regular6={{color6 | strip}}  # cyan
            regular7={{color7 | strip}}  # white

            ## Bright colors (color palette 8-15)
            bright0={{color8 | strip}}   # bright black
            bright1={{color9 | strip}}   # bright red
            bright2={{color10 | strip}}   # bright green
            bright3={{color11 | strip}}   # bright yellow
            bright4={{color12 | strip}}   # bright blue
            bright5={{color13 | strip}}   # bright magenta
            bright6={{color14 | strip}}   # bright cyan
            bright7={{color15 | strip}}   # bright white
          '';
          target = "${configHome}/foot/colors.ini";
        };
        alacritty = {
          template = pkgs.writeText "alacritty-colors.toml" ''
            [colors.primary]
            background = "{{background}}"
            foreground = "{{foreground}}"

            [colors.normal]
            black = "{{color0}}"
            red = "{{color1}}"
            green = "{{color2}}"
            yellow = "{{color3}}"
            blue = "{{color4}}"
            magenta = "{{color5}}"
            cyan = "{{color6}}"
            white = "{{color7}}"

            [colors.bright]
            black = "{{color8}}"
            red = "{{color9}}"
            green = "{{color10}}"
            yellow = "{{color11}}"
            blue = "{{color12}}"
            magenta = "{{color13}}"
            cyan = "{{color14}}"
            white = "{{color15}}"
          '';
          target = "${configHome}/alacritty/colors.toml";
        };
        ghostty = {
          template = pkgs.writeText "ghostty-colors" ''
            background = {{background}}
            foreground = {{foreground}}
            selection-background = {{background | complementary}}
            selection-foreground = {{foreground | complementary}}
            palette = 0={{color0}}
            palette = 1={{color1}}
            palette = 2={{color2}}
            palette = 3={{color3}}
            palette = 4={{color4}}
            palette = 5={{color5}}
            palette = 6={{color6}}
            palette = 7={{color7}}
            palette = 8={{color8}}
            palette = 9={{color9}}
            palette = 10={{color10}}
            palette = 11={{color11}}
            palette = 12={{color12}}
            palette = 13={{color13}}
            palette = 14={{color14}}
            palette = 15={{color15}}
            cursor-color = {{cursor}}
            cursor-text = {{cursor | complementary}}
          '';
          target = "${configHome}/ghostty/colors";
        };
        yazi = {
          template = pkgs.writeText "yazi-theme.toml" ''
            # : Manager

            [manager]
            cwd = { fg = "{{color6}}" }

            # Hovered
            hovered = { reversed = true }
            preview_hovered = { underline = true }

            # Find
            find_keyword = { fg = "{{color5}}", bold = true, italic = true, underline = true }
            find_position = { fg = "{{color4}}", bg = "reset", bold = true, italic = true }

            # Marker
            marker_copied = { fg = "{{color10}}", bg = "{{color10}}" }
            marker_cut = { fg = "{{color9}}", bg = "{{color9}}" }
            marker_marked = { fg = "{{color13}}", bg = "{{color13}}" }
            marker_selected = { fg = "{{color11}}", bg = "{{color11}}" }

            # Tab
            tab_active = { reversed = true }
            tab_inactive = {}
            tab_width = 1

            # Count
            count_copied = { fg = "{{color7}}", bg = "{{color10}}" }
            count_cut = { fg = "{{color7}}", bg = "{{color9}}" }
            count_selected = { fg = "{{color7}}", bg = "{{color11}}" }

            # Border
            border_symbol = "│"
            border_style = { fg = "{{color1}}" }

            # : Mode

            [mode]
            normal_main = { fg = "{{color9}}", bg = "{{color14}}", bold = true }
            normal_alt = { fg = "{{color14}}", bg = "{{color9}}" }

            # Select mode
            select_main = { fg = "{{color14}}", bg = "{{color10}}", bold = true }
            select_alt = { fg = "{{color9}}", bg = "{{color14}}" }

            # Unset mode
            unset_main = { fg = "{{color14}}", bg = "{{color9}}", bold = true }
            unset_alt = { fg = "{{color9}}", bg = "{{color14}}" }

            # : Status bar

            [status]
            separator_open = ""
            separator_close = ""

            # Progress
            progress_label = { fg = "{{foreground}}", bold = true }
            progress_normal = { fg = "{{color1}}", bg = "{{color14}}" }
            progress_error = { fg = "{{color6}}", bg = "{{color9}}" }

            # Permissions
            perm_sep = { fg = "{{color6}}" }
            perm_type = { fg = "{{color4}}" }
            perm_read = { fg = "{{color2}}" }
            perm_write = { fg = "{{color3}}" }
            perm_exec = { fg = "{{color1}}" }

            # : Pick

            [pick]
            border = { fg = "{{color6}}" }
            active = { fg = "{{color7}}", bold = true }
            inactive = {}

            # : Input

            [input]
            border = { fg = "{{color6}}" }
            title = {}
            value = {}
            selected = { reversed = true }

            # : Completion

            [completion]
            border = { fg = "{{color6}}" }

            # : Tasks

            [tasks]
            border = { fg = "{{color6}}" }
            title = {}
            hovered = { fg = "{{color7}}", underline = true }

            # : Which

            [which]
            mask = { bg = "{{color9}}" }
            cand = { fg = "{{color14}}", bold = true }
            rest = { fg = "{{color0}}" }
            desc = { fg = "{{color14}}" }
            separator = "  "
            separator_style = { fg = "{{color7}}" }

            # : Help

            [help]
            on = { fg = "{{color9}}", bold = true }
            run = { fg = "{{color6}}" }
            hovered = { reversed = true, bold = true }
            footer = { fg = "{{color6}}", bg = "{{color9}}" }

            # : Notify

            [notify]
            title_info = { fg = "{{color10}}" }
            title_warn = { fg = "{{color11}}" }
            title_error = { fg = "{{color9}}" }


            # : File-specific styles

            [filetype]
            rules = [
                # Images
                { mime = "image/*", fg = "{{color1}}" },

                # Media
                { mime = "{audio,video}/*", fg = "{{color2}}" },

                # Archives
                { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "{{color3}}" },

                # Documents
                { mime = "application/{pdf,doc,rtf}", fg = "{{color12}}" },

                # Fallback
                { name = "*", fg = "{{color15}}" },
                { name = "*/", fg = "{{color14}}" },
            ]
          '';
          target = "${configHome}/yazi/theme.toml";
        };
        anyrun = {
          template = gtk-css;
          target = "${configHome}/anyrun/colors.css";
        };
      };
    };
  };
}
