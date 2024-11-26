_: {
  plugins.todo-comments = {
    enable = true;
    settings = {
      colors = {
        error = [
          "DiagnosticError"
          "ErrorMsg"
          "#ED8796"
        ];
        warning = [
          "DiagnosticWarn"
          "WarningMsg"
          "#EED49F"
        ];
        info = [
          "DiagnosticInfo"
          "#EED49F"
        ];
        default = [
          "Identifier"
          "#F5A97F"
        ];
        test = [
          "Identifier"
          "#8AADF4"
        ];
      };
    };
  };
}
