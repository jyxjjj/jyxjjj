#!/bin/zsh

set -eu
setopt pipefail

bundle_ids=()
app_names=()
app_group_ids=()
icloud_container_ids=()
custom_paths=()
include_system_locations=0

usage() {
  print -r -- 'Usage: check-storage.zsh [options]'
  print -r -- ''
  print -r -- 'Options:'
  print -r -- '  --bundle-id VALUE                 Add a bundle identifier.'
  print -r -- '  --app-name VALUE                  Add a product, display, or executable name.'
  print -r -- '  --app-group-id VALUE              Add an App Group identifier.'
  print -r -- '  --icloud-container-id VALUE       Add an iCloud or CloudKit container identifier.'
  print -r -- '  --custom-path PATH                Add an explicitly confirmed path.'
  print -r -- '  --include-system-locations        Include helper and system-level locations.'
  print -r -- '  --help                            Show this help.'
}

while (( $# > 0 )); do
  case "$1" in
    --bundle-id)
      if (( $# < 2 )) || [[ -z "$2" ]]; then
        print -u2 -r -- 'Error: --bundle-id requires a non-empty value.'
        exit 2
      fi
      bundle_ids+=("$2")
      shift 2
      ;;
    --app-name)
      if (( $# < 2 )) || [[ -z "$2" ]]; then
        print -u2 -r -- 'Error: --app-name requires a non-empty value.'
        exit 2
      fi
      app_names+=("$2")
      shift 2
      ;;
    --app-group-id)
      if (( $# < 2 )) || [[ -z "$2" ]]; then
        print -u2 -r -- 'Error: --app-group-id requires a non-empty value.'
        exit 2
      fi
      app_group_ids+=("$2")
      shift 2
      ;;
    --icloud-container-id)
      if (( $# < 2 )) || [[ -z "$2" ]]; then
        print -u2 -r -- 'Error: --icloud-container-id requires a non-empty value.'
        exit 2
      fi
      icloud_container_ids+=("$2")
      shift 2
      ;;
    --custom-path)
      if (( $# < 2 )) || [[ -z "$2" ]]; then
        print -u2 -r -- 'Error: --custom-path requires a non-empty value.'
        exit 2
      fi
      custom_paths+=("$2")
      shift 2
      ;;
    --include-system-locations)
      include_system_locations=1
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      print -u2 -r -- "Error: unknown option: $1"
      usage >&2
      exit 2
      ;;
  esac
done

if ((
  ${#bundle_ids} == 0 &&
  ${#app_names} == 0 &&
  ${#app_group_ids} == 0 &&
  ${#icloud_container_ids} == 0 &&
  ${#custom_paths} == 0
)); then
  print -u2 -r -- 'Error: provide at least one confirmed identifier or custom path.'
  exit 2
fi

print -r -- "Bundle IDs: ${bundle_ids[*]}"
print -r -- "App names: ${app_names[*]}"
print -r -- "App Groups: ${app_group_ids[*]}"
print -r -- "iCloud containers: ${icloud_container_ids[*]}"
print -r -- "Custom paths: ${custom_paths[*]}"

if (( include_system_locations )); then
  print -r -- 'System locations: included'
else
  print -r -- 'System locations: not included'
fi

exact_paths=()

for bundle_id in "${bundle_ids[@]}"; do
  exact_paths+=(
    "$HOME/Library/Containers/$bundle_id"
    "$HOME/Library/Application Scripts/$bundle_id"
    "$HOME/Library/Application Support/$bundle_id"
    "$HOME/Library/Caches/$bundle_id"
    "$HOME/Library/Preferences/$bundle_id.plist"
    "$HOME/Library/Saved Application State/$bundle_id.savedState"
    "$HOME/Library/WebKit/$bundle_id"
    "$HOME/Library/HTTPStorages/$bundle_id"
    "$HOME/Library/Cookies/$bundle_id"
    "$HOME/Library/Logs/$bundle_id"
  )
done

for app_name in "${app_names[@]}"; do
  exact_paths+=(
    "$HOME/Library/Application Support/$app_name"
    "$HOME/Library/Caches/$app_name"
    "$HOME/Library/WebKit/$app_name"
    "$HOME/Library/HTTPStorages/$app_name"
    "$HOME/Library/Cookies/$app_name"
    "$HOME/Library/Logs/$app_name"
  )
done

for app_group_id in "${app_group_ids[@]}"; do
  exact_paths+=(
    "$HOME/Library/Group Containers/$app_group_id"
    "$HOME/Library/Application Scripts/$app_group_id"
  )
done

if (( include_system_locations )); then
  for bundle_id in "${bundle_ids[@]}"; do
    exact_paths+=(
      "$HOME/Library/LaunchAgents/$bundle_id.plist"
      "/Library/Application Support/$bundle_id"
      "/Library/Caches/$bundle_id"
      "/Library/Logs/$bundle_id"
      "/Library/LaunchAgents/$bundle_id.plist"
      "/Library/LaunchDaemons/$bundle_id.plist"
      "/Library/PrivilegedHelperTools/$bundle_id"
    )
  done

  for app_name in "${app_names[@]}"; do
    exact_paths+=(
      "$HOME/Library/LaunchAgents/$app_name.plist"
      "/Library/Application Support/$app_name"
      "/Library/Caches/$app_name"
      "/Library/Logs/$app_name"
      "/Library/LaunchAgents/$app_name.plist"
      "/Library/LaunchDaemons/$app_name.plist"
      "/Library/PrivilegedHelperTools/$app_name"
    )
  done
fi

exact_paths+=("${custom_paths[@]}")

for exact_path in "${exact_paths[@]}"; do
  if [[ -d "$exact_path" ]]; then
    print -r -- "FOUND DIRECTORY: $exact_path"
    find "$exact_path" -print
  elif [[ -e "$exact_path" || -L "$exact_path" ]]; then
    print -r -- "FOUND FILE: $exact_path"
  fi
done

search_roots=(
  "$HOME/Library/Containers"
  "$HOME/Library/Group Containers"
  "$HOME/Library/Application Scripts"
  "$HOME/Library/Application Support"
  "$HOME/Library/Caches"
  "$HOME/Library/Preferences"
  "$HOME/Library/Saved Application State"
  "$HOME/Library/WebKit"
  "$HOME/Library/HTTPStorages"
  "$HOME/Library/Cookies"
  "$HOME/Library/Logs"
  "$HOME/Library/Autosave Information"
  "$HOME/Library/Metadata"
  "$HOME/Library/Mobile Documents"
)

if (( include_system_locations )); then
  search_roots+=(
    "$HOME/Library/LaunchAgents"
    "/Library/Application Support"
    "/Library/Caches"
    "/Library/Logs"
    "/Library/LaunchAgents"
    "/Library/LaunchDaemons"
    "/Library/PrivilegedHelperTools"
    "/Library/SystemExtensions"
  )
fi

identities=(
  "${bundle_ids[@]}"
  "${app_names[@]}"
  "${app_group_ids[@]}"
  "${icloud_container_ids[@]}"
)

{
  for search_root in "${search_roots[@]}"; do
    [[ -d "$search_root" ]] || continue
    find "$search_root" -mindepth 1 -maxdepth 1 -print0
  done
} |
while IFS= read -r -d $'\0' candidate; do
  candidate_name=${candidate:t}

  for identity in "${identities[@]}"; do
    if [[ "$candidate_name" == *"$identity"* ]]; then
      print -r -- "$candidate"
      break
    fi
  done
done |
sort -u
