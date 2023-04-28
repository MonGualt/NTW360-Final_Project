#!/bin/bash

# Defines a function for generating a password
password_generation() {
    # Prompts the user for the password length
    read -p "Enter length of password: " length
    # Generates a password using openssl and saves it to a variable
    password=$(openssl rand -base64 32 | cut -c1-$length)
    # Displays the generated password
    echo "Generated password: $password"  
}

# Defines a function for file encryption/decryption
encryption_decryption() {
    # Prompts the user to choose encryption or decryption
    read -p "Enter 1 for encryption or 2 for decryption: " choice
    # If the choice is encryption
    if [ $choice -eq 1 ]; then
    # Prompts the user to enter the filename to be encrypted
        read -p "Enter filename to encrypt: " filename
        # Encrypts the file using gpg
        gpg -c $filename
        # Displays a message indicating successful encryption
        echo "File encrypted successfully!"
     # If the choice is decryption
    elif [ $choice -eq 2 ]; then
        # Prompts the user to enter the filename to be decrypted
        read -p "Enter filename to decrypt: " filename 
        # Decrypts the file using gpg and saves it to a file with the same name but without the .gpg extension
        gpg -d $filename > $(basename $filename .gpg)
        # Displays a message indicating successful decryption
        echo "File decrypted successfully!"
        # If the choice is not 1 or 2 displays an error message
    else
        echo "Invalid choice. Please select 1 or 2." 
    fi
}

# Defines a function for file hashing
file_hashing() {
    # Prompts the user to enter the filename to be hashed
    read -p "Enter filename to hash: " filename
    # Computes the SHA-256 hash of the file and saves it to a variable
    hash=$(sha256sum $filename)
    # Displays the computed hash
    echo "SHA-256 hash of file $filename is: $hash"
}

# Defines the main function
main() {
    # Loops until the user chooses to exit
    while true
    do
        # Displays the menu options
        echo "Menu:"        
        echo "1. Password Generation"
        echo "2. Encryption/Decryption"
        echo "3. File Hashing"
        echo "4. Exit"
        # Prompts the user to select an option
        read -p "Select an option: " choice
        # Executes the corresponding function based on the user's choice
        case $choice in  
            1)
                password_generation
                ;;
            2)
                encryption_decryption
                ;;
            3)
                file_hashing
                ;;
            4)
               # Exits the loop and the script
                break
                ;;
            *)
                # Displays an error message for invalid choices
                echo "Invalid choice. Please select an option from the menu."
                ;;
        esac
    done
}

# Call main function to start the program
main
