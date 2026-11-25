{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.sops) secrets;

  # 9router detects headroom via `which headroom` + `python -m pip show headroom-ai`,
  # so put the uv tool venv on PATH like `source activate.fish` does.
  _9router' = pkgs.writeShellApplication {
    name = "9router";
    text = ''
      venv="''${XDG_DATA_HOME:-$HOME/.local/share}/uv/tools/headroom-ai"
      export VIRTUAL_ENV="$venv"
      export PATH="$venv/bin:$PATH"
      exec ${lib.getExe pkgs._9router} "$@"
    '';
  };
in
{
  home.packages = with pkgs; [
    _9router'
    uv
  ];

  programs.mcp = {
    enable = true;
    servers = {
      mcp-nixos = {
        command = lib.getExe pkgs.mcp-nixos;
        args = [ ];
      };
      mcp-server-git = {
        command = lib.getExe pkgs.mcp-server-git;
        args = [ ];
      };
      web-search = {
        command = lib.getExe pkgs.open-websearch;
        args = [ ];
        env = {
          MODE = "stdio";
          DEFAULT_SEARCH_ENGINE = "brave";
          ALLOWED_SEARCH_ENGINES = "brave,duckduckgo,bing";
        };
      };
      trilium = {
        type = "http";
        url = "https://notes.connor.home.arpa/mcp";
        headers = {
          Authorization = "Bearer {file:${secrets."trilium/api-key".path}}";
        };
      };
    };
  };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      lsp = true;
      plugin = [
        "superpowers@git+https://github.com/obra/superpowers.git"
        "opencode-power-pack@git+https://github.com/waybarrios/opencode-power-pack.git"
      ];
      provider = {
        "9router" = {
          npm = "@ai-sdk/openai-compatible";
          name = "9router";
          options = {
            baseURL = "http://localhost:20128/v1";
            apiKey = "{file:${secrets."9router/api-key".path}}";
          };
          models = {
            "oc/deepseek-v4.1-flash-free" = {
              name = "Deepseek V4.1 Flash Free";
            };
          };
        };
        llama-swap = {
          npm = "@ai-sdk/openai-compatible";
          name = "Local";
          options = {
            baseURL = "https://llama.home.arpa/v1";
          };
          models = {
            "gemma-4-12b-qat" = {
              id = "gemma-4-12b-qat";
              name = "Gemma 4 12B QAT";
              tool_call = true;
            };
            "qwopus3.5-9b-coder-mtp" = {
              id = "qwopus3.5-9b-coder-mtp";
              name = "Qwopus3.5 9B Coder MTP";
              tool_call = true;
            };
          };
        };
      };
    };
  };

  programs.zed-editor = {
    enableMcpIntegration = true;
    userSettings.context_servers.trilium.enabled = false;
  };
}
