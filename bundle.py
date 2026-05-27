import os

# Configuration
SRC_DIR = "src"
MAIN_FILE = os.path.join(SRC_DIR, "main.lua")
OUTPUT_FILE = "void_packed.lua"

def get_all_modules():
    """Dynamically maps out explicit core files and sweeps the entire tabs folder."""
    modules = {
        "core/json.lua": os.path.join(SRC_DIR, "core", "json.lua"),
        "core/memory.lua": os.path.join(SRC_DIR, "core", "memory.lua"),
        "core/scheduler.lua": os.path.join(SRC_DIR, "core", "scheduler.lua"),
        "core/patches.lua": os.path.join(SRC_DIR, "core", "patches.lua"),
        "modules/init.lua": os.path.join(SRC_DIR, "modules", "init.lua"),
        "ui/ui.lua": os.path.join(SRC_DIR, "ui", "ui.lua")
    }
    
    # Automatically grab everything inside modules/tabs/
    tabs_dir = os.path.join(SRC_DIR, "modules", "tabs")
    if os.path.exists(tabs_dir):
        for file in os.listdir(tabs_dir):
            if file.endswith(".lua"):
                virtual_name = f"modules/tabs/{file}"
                real_path = os.path.join(tabs_dir, file)
                modules[virtual_name] = real_path
                
    return modules

def bundle():
    if not os.path.exists(MAIN_FILE):
        print(f"[-] Error: Entry point not found at {MAIN_FILE}")
        print("    Make sure you are running this script from your root 'void/' folder.")
        return

    modules_to_bundle = get_all_modules()
    packed_content = []
    
    packed_content.append("-- ─────────────────────────────────────────────")
    packed_content.append("-- VOID v1.0 — SECURE VIRTUAL EXTENSION FILE")
    packed_content.append("-- ─────────────────────────────────────────────\n")
    packed_content.append("local __vfs = {}")

    # Pack files into the memory table
    for virtual_name, real_path in modules_to_bundle.items():
        if os.path.exists(real_path):
            print(f"[+] Embedding module: {virtual_name}")
            with open(real_path, "r", encoding="utf-8") as f:
                content = f.read()
            
            packed_content.append(f"__vfs['{virtual_name}'] = function(...)")
            packed_content.append(content)
            packed_content.append("end\n")
        else:
            print(f"[-] Warning: File skipped (not found): {real_path}")

    # Read original main.lua lines
    with open(MAIN_FILE, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # Locate the exact boundaries of the loadModule block safely using block depth tracking
    start_idx = None
    end_idx = None
    scope_depth = 0
    
    for idx, line in enumerate(lines):
        clean_line = line.strip()
        
        # Detect the start of the function
        if "function loadModule" in clean_line:
            start_idx = idx
            scope_depth = 1
            continue
            
        # Track depth if we are inside the function block
        if start_idx is not None and scope_depth > 0:
            # Increase depth for nested statements
            # (Matches 'then', 'do', or inline 'function' blocks)
            if " then" in clean_line or clean_line.endswith("then") or " do " in clean_line or clean_line.endswith("do") or "function(" in clean_line:
                scope_depth += 1
                
            # Decrease depth when finding an end statement
            if clean_line == "end" or clean_line.startswith("end ") or clean_line.endswith(" end"):
                scope_depth -= 1
                
            # If scope depth hits zero, we found the TRUE end of the loadModule function
            if scope_depth == 0:
                end_idx = idx
                break

    # If found, wipe out the entire section completely including the wrapper function lines
    if start_idx is not None and end_idx is not None:
        print(f"[+] Safely stripped old native loader function (Lines {start_idx+1}-{end_idx+1})")
        
        # Backtrack up to 6 lines to clean up the native scriptDir definition and headers
        while start_idx > 0:
            prev_line = lines[start_idx-1]
            if "local scriptDir" in prev_line or "MODULE LOADER" in prev_line or "───" in prev_line:
                start_idx -= 1
            else:
                break
                
        del lines[start_idx:end_idx+1]
    else:
        print("[-] Warning: Native loadModule signature not found or already processed. Skipping strip step.")

    # Convert cleaned lines back to string asset block
    main_content = "".join(lines)

    # Clean virtual loader definition block
    virtual_loader = """
local scriptDir = gg.getFile():match("(.*/)") or ""
function loadModule(name)
    local clean_name = name:gsub("^./", "")
    if not clean_name:match("%.lua$") then
        clean_name = clean_name .. ".lua"
    end

    local v_chunk = __vfs[clean_name]
    if v_chunk then
        return v_chunk()
    end
    
    local path = scriptDir .. name
    local chunk, err = loadfile(path)
    if not chunk then
        gg.alert("VFS Error: Failed to load " .. name .. ":\\n" .. tostring(err))
        os.exit()
    end
    return chunk()
end
"""

    packed_content.append(virtual_loader)
    packed_content.append("\n-- ─────────────────────────────────────────────\n-- MAIN CODE ENTRYPOINT\n-- ─────────────────────────────────────────────\n")
    packed_content.append(main_content)

    # Write the master clean single file
    with open(OUTPUT_FILE, "w", encoding="utf-8") as out:
        out.write("\n".join(packed_content))
    
    print(f"\n[✔] Done! Single file generated: '{OUTPUT_FILE}'")
    print("[!] Pass this file directly into your encrypter.")

if __name__ == "__main__":
    bundle()
