#!/bin/bash
echo "----------------------------------------------------------------------------------------------------------"
echo "Checking file permissions..."

# List of sensitive files
sensitive_files=(
    "/etc/shadow" 
    "/etc/passwd" 
    "/etc/sudoers"   # Corrected the typo in "/etc/sudores" 
    "/root" 
    "/var/log/auth.log" 
    "/etc/ssh/ssh_host_*_key" 
    "/etc/gshadow" 
    "/etc/hosts" 
    "/etc/hostname" 
    "/etc/crypttab" 
    "/etc/fstab"
)
weak_permissions=("777" "666" "755" "644")
permissions=()  # This will store all the permissions for each file

#"${sensitive_files[@]} iterate each element in array
for file in "${sensitive_files[@]}"; do
    file_permission=$(stat -c "%a" "$file") # stat cmd provide information about file -c option customize the output
   #"%a display the octal format
    permissions+=("$file_permission")  # Append permission to the array
done

# Now check all permissions
for (( i=0; i<${#sensitive_files[@]}; i++ )); do
    weak_found=false
    for weak_perm in "${weak_permissions[@]}"; do 
        if [[ "${permissions[$i]}" == "$weak_perm" ]]; then
            echo "${sensitive_files[$i]} has weak permissions: ${permissions[$i]}"
            weak_found=true
            break
        fi
    done

    if [[ "$weak_found" == false ]]; then
        echo "${sensitive_files[$i]} has strong permissions: ${permissions[$i]}"
    fi
done  