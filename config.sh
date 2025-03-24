#!/bin/bash

usage()
{
  echo "Usage: $0 TARGET [OPTIONS]"
  echo ""
  echo "TARGETS:"
  echo "  install (default)       - Install (reinstalls) the configuration for launching Steam in single mode. This is the default action."
  echo "  clear                   - Removes the installation of this project."
  echo "  update                  - Updates the specified packages from the configuration."
  echo ""
  echo "OPTIONS:"
  echo "  -b, --base              - Process the base project (Gamescope session plus)."
  echo "  -m, --module            - Process the Steam Gamescope session plus module."
}

install_base()
{
  echo "copy base files..."
  sudo cp -f gamescope-session/usr/bin/export-gpu /usr/bin/export-gpu
  sudo cp -f gamescope-session/usr/bin/gamescope-session-plus /usr/bin/gamescope-session-plus
  sudo cp -f gamescope-session/usr/lib/systemd/user/gamescope-session-plus@.service /usr/lib/systemd/user/gamescope-session-plus@.service
  sudo mkdir -p /usr/share/gamescope-session-plus 
  sudo cp -f gamescope-session/usr/share/gamescope-session-plus/device-quirks /usr/share/gamescope-session-plus/device-quirks
  sudo cp -f gamescope-session/usr/share/gamescope-session-plus/gamescope-session-plus /usr/share/gamescope-session-plus/gamescope-session-plus 
}

install_module()
{
  echo "copy module files..."
  sudo cp -f gamescope-session-steam/usr/bin/jupiter-biosupdate /usr/bin/jupiter-biosupdate
  sudo cp -f gamescope-session-steam/usr/bin/steam-http-loader /usr/bin/steam-http-loader
  sudo cp -f gamescope-session-steam/usr/bin/steamos-select-branch /usr/bin/steamos-select-branch
  sudo cp -f gamescope-session-steam/usr/bin/steamos-session-select /usr/bin/steamos-session-select
  sudo cp -f gamescope-session-steam/usr/bin/steamos-update /usr/bin/steamos-update
  sudo mkdir -p /usr/bin/steamos-polkit-helpers
  sudo cp -f gamescope-session-steam/usr/bin/steamos-polkit-helpers/* /usr/bin/steamos-polkit-helpers/

  sudo cp -f gamescope-session-steam/usr/share/applications/gamescope-mimeapps.list /usr/share/applications/gamescope-mimeapps.list 
  sudo cp -f gamescope-session-steam/usr/share/applications/steam_http_loader.desktop /usr/share/applications/steam_http_loader.desktop

  sudo mkdir -p /usr/share/gamescope-session-plus/sessions.d
  sudo cp -f gamescope-session-steam/usr/share/gamescope-session-plus/sessions.d/steam /usr/share/gamescope-session-plus/sessions.d/steam

  sudo cp -f gamescope-session-steam/usr/share/polkit-1/actions/org.chimeraos.update.policy /usr/share/polkit-1/actions/org.chimeraos.update.policy
  sudo cp -f gamescope-session-steam/usr/share/wayland-sessions/gamescope-session-steam.desktop /usr/share/wayland-sessions/gamescope-session-steam.desktop 
  if [ -f /usr/share/wayland-sessions/gamescope-session.desktop ]; then
      sudo rm /usr/share/wayland-sessions/gamescope-session.desktop
  fi
  sudo ln -s /usr/share/wayland-sessions/gamescope-session-steam.desktop /usr/share/wayland-sessions/gamescope-session.desktop
}

remove_base()
{
  sudo rm /usr/bin/export-gpu
  sudo rm /usr/bin/gamescope-session-plus
  sudo rm /usr/lib/systemd/user/gamescope-session-plus@.service
  sudo rm /usr/libexec/gamescope-sdl-workaround
  sudo rm -rf /usr/share/gamescope-session-plus 
}

remove_module()
{
  sudo rm /usr/bin/jupiter-biosupdate
  sudo rm /usr/bin/steam-http-loader
  sudo rm /usr/bin/steamos-select-branch
  sudo rm /usr/bin/steamos-session-select
  sudo rm /usr/bin/steamos-update
  sudo rm -rf /usr/bin/steamos-polkit-helpers

  sudo rm /usr/share/applications/gamescope-mimeapps.list 
  sudo rm /usr/share/applications/steam_http_loader.desktop

  sudo rm -rf /usr/share/gamescope-session-plus

  sudo rm /usr/share/polkit-1/actions/org.chimeraos.update.policy
  sudo rm /usr/share/wayland-sessions/gamescope-session-steam.desktop 
  sudo rm /usr/share/wayland-sessions/gamescope-session.desktop
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -m|--module)
      MODES="module $MODES"
      shift
    ;;
    -b|--base)
      MODES="base $MODES"
      shift
    ;;
    -h|--help)
      usage
      exit 0
    ;;
    -*)
      echo "Unknown option $1"
      usage
      exit 1
    ;;
    install)
      if [ -n "$TARGET" ]; then
        echo "Only one target is supported."
        usage
        exit 1
      fi
      TARGET="install"
      shift
    ;;
    clear)
      if [ -n "$TARGET" ]; then
        echo "Only one target is supported."
        usage
        exit 1
      fi
      TARGET="clear"
      shift
    ;;
    update)
      if [ -n "$TARGET" ]; then
        echo "Only one target is supported."
        usage
        exit 1
      fi
      TARGET="update"
      shift
    ;;
    *)
      echo "Unknown target: $1"
      usage
      exit 1
  esac
done

if [ -z "$TARGET" ]; then
  TARGET="install"
fi

if [ -z "$MODES" ]; then
  MODES="base module"
fi

function exists_in_list() {
    LIST=$1
    DELIMITER=$2
    VALUE=$3
    LIST_WHITESPACES=`echo $LIST | tr "$DELIMITER" " "`
    for x in $LIST_WHITESPACES; do
        if [ "$x" = "$VALUE" ]; then
            return 0
        fi
    done
    return 1
}

if [ "${TARGET}" = "update" ]; then
  if exists_in_list "$MODES" " " base; then
    echo "update base..."
    pushd gamescope-session || exit 1
      git reset --hard HEAD
      git checkout main
      git pull
    popd || exit 1
  fi

  if exists_in_list "$MODES" " " module; then
    echo "update module..."
    pushd gamescope-session-steam || exit 1
      git reset --hard HEAD
      git checkout main
      git pull
    popd || exit 1
  fi
fi


if [ "${TARGET}" != "clear" ]; then
  if exists_in_list "$MODES" " " base; then
    install_base
  fi

  if exists_in_list "$MODES" " " module; then
    install_module
  fi
else
  if exists_in_list "$MODES" " " base; then
    echo "clear base..."
    remove_base
  fi

  if exists_in_list "$MODES" " " module; then
    echo "clear module..."
    remove_module
  fi
fi