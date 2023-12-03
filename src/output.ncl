# run: nickel eval % -- --override 'profile_id="home"'
#run: nickel export % -- 'profile_id="home"' --override 'external=""'

let lib = import "meta/lib.ncl" in
let profile_list = import "profiles/_shared.ncl" in
let filegen = (import "filegen.ncl") | Array {
  path | lib.RelativePath,
  # 'DirL means symlink a directory  in phase 2
  # 'Skip means do not symlink in phase 2
  # 'Make means nickel will create a file in phase 1 for symlinking in phase 2
  # 'Copy means copy
  type | [| 'make, 'dirl |],
  ..
  #need | Array String | optional,
  #body | _ | optional,
  #mode | String | optional,
} in

{
  # overrides
  profile_id: String | default | not_exported = "work",
  external                     | not_exported = "",

  _profile | not_exported = profile_list.profiles."%{profile_id}" external
    |> std.record.map (fun key val => if std.record.has_field key profile_list.shared
      then val & profile_list.shared."%{key}"
      else val
    )
    |> (&) profile_list.xdg
  ,

  _files | not_exported = {
    dirl                 = ((filegen |> std.array.filter (fun e => e.type == 'dirl) ) | Array { path, type, }) |> std.array.map (fun x => x.path),
    #skip                 = ((filegen |> std.array.filter (fun e => e.type == 'skip) ) | Array { path, type, }) |> std.array.map (fun x => x.path),
    #copy                 = ((filegen |> std.array.filter (fun e => e.type == 'copy) ) | Array { path, type, from | lib.RelativePath, }),
    _make | not_exported = ((filegen |> std.array.filter (fun e => e.type == 'make) ) | Array { path, type, body | {..} -> String, }),
  },
  _total_len | not_exported = _files |> std.record.values |> std.array.fold_left (fun acc x => acc + (std.array.length x)) 0,
  _all_variants_used | not_exported =
    if _total_len == (std.array.length filegen) then true
    else std.fail_with "We are missing one of the variants"
  ,

  files = _files & { make = files._make
    |> std.array.map (fun entry => {
      field = entry.path,
      value = { text = (entry.body _profile) },
    })
    |> std.record.from_array
  },

  packages = _profile.packages,
  named_directories = _profile.shortcuts
    |> std.record.to_array
    |> std.array.map (fun x => { field = "%{_profile.XDG_CONFIG_HOME}/named_directories/%{x.field}", value = x.value })
    |> std.record.from_array
  ,
}
