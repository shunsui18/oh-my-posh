#!/usr/bin/env bash
# =============================================================================
#  yozakura-install.sh
#  Installs the Yozakura oh-my-posh theme into every detected shell config.
#
#  Usage:
#    ./yozakura-install.sh                  # interactive prompt
#    ./yozakura-install.sh --theme yoru     # non-interactive, night theme
#    ./yozakura-install.sh --theme hiru     # non-interactive, day theme
# =============================================================================
set -euo pipefail

YORU_URL="https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-yoru.omp.json"
HIRU_URL="https://raw.githubusercontent.com/shunsui18/oh-my-posh/refs/heads/main/yozakura-hiru.omp.json"

# ── colours ───────────────────────────────────────────────────────────────────
if [[ -t 1 ]]; then
  R='\033[0m' BOLD='\033[1m' DIM='\033[2m'
  PETAL='\033[38;2;184;152;208m'
  LANTERN='\033[38;2;242;212;184m'
  BLUSH='\033[38;2;216;170;196m'
  EMBER='\033[38;2;176;120;136m'
  SKY='\033[38;2;122;176;200m'
  MOSS='\033[38;2;122;168;152m'
else
  R='' BOLD='' DIM='' PETAL='' LANTERN='' BLUSH='' EMBER='' SKY='' MOSS=''
fi

log_step() { echo -e "${PETAL}${BOLD}  ❀ ${R}${BOLD}${1}${R}"; }
log_ok()   { echo -e "${MOSS}    ✔ ${R}${1}"; }
log_skip() { echo -e "${DIM}    ─ ${1}${R}"; }
log_warn() { echo -e "${EMBER}    ⚠ ${R}${1}"; }
log_info() { echo -e "${SKY}    · ${R}${1}"; }
log_new()  { echo -e "${LANTERN}    + ${R}${1}"; }

usage() {
  echo -e "
  ${BOLD}Usage:${R}
    ${PETAL}./yozakura-install.sh${R}                 interactive
    ${PETAL}./yozakura-install.sh --theme yoru${R}    night theme (non-interactive)
    ${PETAL}./yozakura-install.sh --theme hiru${R}    day theme (non-interactive)
  "
  exit 0
}

# ── argument parsing ──────────────────────────────────────────────────────────
THEME_ARG=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --theme)
      [[ -z "${2:-}" ]] && { echo "  --theme requires a value: yoru or hiru"; exit 1; }
      THEME_ARG="${2,,}"
      shift 2
      ;;
    -h|--help) usage ;;
    *) echo "  Unknown option: $1"; usage ;;
  esac
done

# ── header ────────────────────────────────────────────────────────────────────
echo
echo -e "${PETAL}${BOLD}  ╭─────────────────────────────────────╮"
echo -e "  │   Yozakura · oh-my-posh installer  │"
echo -e "  ╰─────────────────────────────────────╯${R}"
echo

# ── theme selection ───────────────────────────────────────────────────────────
if [[ -n "$THEME_ARG" ]]; then
  case "$THEME_ARG" in
    yoru) CHOSEN_URL="$YORU_URL"; CHOSEN_LABEL="Yoru (night)" ;;
    hiru) CHOSEN_URL="$HIRU_URL"; CHOSEN_LABEL="Hiru (day)"   ;;
    *)
      echo -e "  ${EMBER}Unknown theme '${THEME_ARG}'. Valid values: yoru, hiru.${R}"
      exit 1
      ;;
  esac
  log_step "Theme: ${CHOSEN_LABEL} ${DIM}(from --theme flag)${R}"
else
  echo -e "  ${BOLD}Which theme?${R}"
  echo -e "  ${BLUSH}[1]${R} Yoru — night  ${DIM}(dark, deep indigo)${R}"
  echo -e "  ${LANTERN}[2]${R} Hiru — day   ${DIM}(light, soft lavender)${R}"
  echo
  read -rp "  Choice [1]: " theme_choice
  theme_choice="${theme_choice:-1}"
  case "$theme_choice" in
    2) CHOSEN_URL="$HIRU_URL"; CHOSEN_LABEL="Hiru (day)"   ;;
    1) CHOSEN_URL="$YORU_URL"; CHOSEN_LABEL="Yoru (night)" ;;
    *)
      echo -e "  ${EMBER}Invalid choice. Enter 1 or 2.${R}"
      exit 1
      ;;
  esac
  log_step "Selected: ${CHOSEN_LABEL}"
fi

# ── oh-my-posh binary check ───────────────────────────────────────────────────
echo
log_step "Checking oh-my-posh installation"
if command -v oh-my-posh &>/dev/null; then
  log_ok "oh-my-posh found at $(command -v oh-my-posh)"
else
  log_warn "oh-my-posh not found in PATH"
  log_info "Init lines will still be written — install oh-my-posh first:"
  log_info "https://ohmyposh.dev/docs/installation/linux"
fi

# ── shell definitions ─────────────────────────────────────────────────────────
declare -A SHELL_CONFIGS
declare -A SHELL_INIT

SHELL_CONFIGS[bash]="${HOME}/.bashrc:${HOME}/.bash_profile:${HOME}/.profile"
SHELL_INIT[bash]='eval "$(oh-my-posh init bash --config '"'"'THEME_URL'"'"')"'

SHELL_CONFIGS[zsh]="${HOME}/.zshrc:${HOME}/.zprofile"
SHELL_INIT[zsh]='eval "$(oh-my-posh init zsh --config '"'"'THEME_URL'"'"')"'

SHELL_CONFIGS[fish]="${HOME}/.config/fish/config.fish"
SHELL_INIT[fish]="oh-my-posh init fish --config 'THEME_URL' | source"

SHELL_CONFIGS[ksh]="${HOME}/.kshrc:${HOME}/.profile"
SHELL_INIT[ksh]='eval "$(oh-my-posh init ksh --config '"'"'THEME_URL'"'"')"'

SHELL_CONFIGS[mksh]="${HOME}/.mkshrc"
SHELL_INIT[mksh]='eval "$(oh-my-posh init ksh --config '"'"'THEME_URL'"'"')"'

SHELL_CONFIGS[elvish]="${HOME}/.config/elvish/rc.elv"
SHELL_INIT[elvish]="eval (oh-my-posh init elvish --config 'THEME_URL')"

SHELL_CONFIGS[xonsh]="${HOME}/.xonshrc"
SHELL_INIT[xonsh]='execx($(oh-my-posh init xonsh --config '"'"'THEME_URL'"'"'))'

SHELL_CONFIGS[nu]="${HOME}/.config/nushell/config.nu"
SHELL_INIT[nu]='oh-my-posh init nu --config '"'"'THEME_URL'"'"'
source ~/.oh-my-posh.nu'

ACTIVE_SHELL="$(basename "${SHELL:-}" | sed 's/^-//')"

# ── helpers ───────────────────────────────────────────────────────────────────
resolve_config() {
  local shell_name="$1"
  local candidates="${SHELL_CONFIGS[$shell_name]:-}"
  [[ -z "$candidates" ]] && return 1

  local IFS=':'
  read -ra files <<< "$candidates"
  for f in "${files[@]}"; do
    [[ -f "$f" ]] && { echo "$f"; return 0; }
  done

  echo "${files[0]}"
  return 1
}

process_config() {
  local shell_name="$1"
  local config_file="$2"
  local init_line="${SHELL_INIT[$shell_name]//THEME_URL/$CHOSEN_URL}"

  if [[ -f "$config_file" ]] && grep -q "oh-my-posh init" "$config_file" 2>/dev/null; then
    local count
    count=$(grep -c "oh-my-posh init" "$config_file")
    sed -i.bak \
      "/oh-my-posh init/{ /^[[:space:]]*#/! s|^|# [yozakura disabled] | }" \
      "$config_file"
    log_warn "Commented out ${count} existing oh-my-posh line(s) in ${config_file}"
  fi

  {
    printf '\n'
    printf '# ── Yozakura oh-my-posh (%s) ──\n' "$CHOSEN_LABEL"
    printf '%s\n' "$init_line"
  } >> "$config_file"

  log_ok "Written to ${config_file}"
}

# ── main loop ─────────────────────────────────────────────────────────────────
echo
log_step "Scanning for installed shells"

processed=()

for shell_name in "${!SHELL_CONFIGS[@]}"; do
  if ! command -v "$shell_name" &>/dev/null; then
    log_skip "${shell_name} — not installed"
    continue
  fi

  log_info "${shell_name} found"

  config_file=""
  if config_file="$(resolve_config "$shell_name")"; then
    process_config "$shell_name" "$config_file"
    processed+=("$shell_name")
  else
    if [[ "$(basename "$ACTIVE_SHELL")" == "$shell_name" ]]; then
      local_dir="$(dirname "$config_file")"
      [[ ! -d "$local_dir" ]] && { mkdir -p "$local_dir"; log_new "Created directory: ${local_dir}"; }
      touch "$config_file"
      log_new "Created ${config_file}"
      process_config "$shell_name" "$config_file"
      processed+=("$shell_name")
    else
      log_skip "${shell_name} — no config found (not active shell, skipping)"
    fi
  fi
done

# ── summary ───────────────────────────────────────────────────────────────────
echo
log_step "Done"
echo
if [[ ${#processed[@]} -eq 0 ]]; then
  log_warn "No shell configs were modified."
else
  echo -e "  ${BOLD}Modified:${R} ${processed[*]}"
  echo
  echo -e "  ${DIM}Reload your shell or source the config:${R}"
  for shell_name in "${processed[@]}"; do
    config_file="$(resolve_config "$shell_name" 2>/dev/null || true)"
    [[ -n "$config_file" ]] && \
      echo -e "    ${PETAL}source ${config_file}${R}  ${DIM}# ${shell_name}${R}"
  done
fi
echo