{
  "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
  "name": "Omarchy",
  "author": "simaocurado",
  "themes": [
    {
      "name": "Omarchy",
      "appearance": "{{ mode }}",
      "style": {
        "background": "{{ background }}",
        "surface.background": "{{ background }}",
        "elevated_surface.background": "{{ lighter_background }}",
        "panel.background": "{{ background }}",
        "status_bar.background": "{{ dark_background }}",
        "title_bar.background": "{{ dark_background }}",
        "title_bar.inactive_background": "{{ background }}",
        "toolbar.background": "{{ background }}",
        "tab_bar.background": "{{ dark_background }}",
        "tab.active_background": "{{ background }}",
        "tab.inactive_background": "{{ dark_background }}",
        "editor.background": "{{ background }}",
        "editor.foreground": "{{ foreground }}",
        "editor.gutter.background": "{{ background }}",
        "editor.line_number": "{{ muted }}",
        "editor.active_line_number": "{{ accent }}",
        "editor.active_line.background": "{{ lighter_background }}",
        "text": "{{ foreground }}",
        "text.muted": "{{ dark_foreground }}",
        "text.accent": "{{ accent }}",
        "border": "{{ muted }}",
        "border.focused": "{{ accent }}",
        "element.selected": "{{ selection }}",
        "element.hover": "{{ lighter_background }}",
        "terminal.background": "{{ background }}",
        "terminal.foreground": "{{ foreground }}",
        "terminal.ansi.black": "{{ dark_background }}",
        "terminal.ansi.red": "{{ red }}",
        "terminal.ansi.green": "{{ green }}",
        "terminal.ansi.yellow": "{{ yellow }}",
        "terminal.ansi.blue": "{{ blue }}",
        "terminal.ansi.magenta": "{{ magenta }}",
        "terminal.ansi.cyan": "{{ cyan }}",
        "terminal.ansi.white": "{{ foreground }}",
        "terminal.ansi.bright_black": "{{ muted }}",
        "terminal.ansi.bright_red": "{{ bright_red }}",
        "terminal.ansi.bright_green": "{{ bright_green }}",
        "terminal.ansi.bright_yellow": "{{ bright_yellow }}",
        "terminal.ansi.bright_blue": "{{ bright_blue }}",
        "terminal.ansi.bright_magenta": "{{ bright_magenta }}",
        "terminal.ansi.bright_cyan": "{{ bright_cyan }}",
        "terminal.ansi.bright_white": "{{ bright_foreground }}",
        "players": [
          {
            "cursor": "{{ accent }}",
            "background": "{{ accent }}",
            "selection": "{{ selection }}"
          }
        ],
        "syntax": {
          "comment": {
            "color": "{{ dark_foreground }}"
          },
          "keyword": {
            "color": "{{ magenta }}"
          },
          "string": {
            "color": "{{ green }}"
          },
          "number": {
            "color": "{{ orange }}"
          },
          "function": {
            "color": "{{ blue }}"
          },
          "type": {
            "color": "{{ yellow }}"
          },
          "variable": {
            "color": "{{ foreground }}"
          },
          "constant": {
            "color": "{{ orange }}"
          },
          "operator": {
            "color": "{{ cyan }}"
          },
          "punctuation": {
            "color": "{{ foreground }}"
          }
        }
      }
    }
  ]
}
