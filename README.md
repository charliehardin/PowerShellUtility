# PowerShell Utility Project

## Overview

This PowerShell Utility project is designed to automate various administrative tasks, making system management more efficient. It includes a set of scripts to streamline operations such as user management, system diagnostics, and more. Additionally, the utility features a basic GUI for easily launching the scripts.

![Image](https://github.com/user-attachments/assets/0dee1be7-d7b7-4c9f-a480-84f67150feed)

### **This project is a work in progress - all features may not be available or fully functional at this moment.**

## Use Cases

Automating Active Directory (AD) user and group management

System diagnostics and performance monitoring

Bulk user creation and modification

Log analysis and reporting

## Requirements

This project requires the ActiveDirectory module, which is essential for interacting with Active Directory environments.

### Installing the ActiveDirectory Module

The ActiveDirectory module can be installed through one of the following methods:

Install RSAT (Remote Server Administration Tools) on Windows, which includes the ActiveDirectory module.

Use the provided Install.ps1 script to automatically install the required components.

## Installation Instructions

Running the Install.ps1 Script

Before executing the installation script, ensure that it is unblocked and run with administrative privileges.

Steps:

Unblock the script (since it is not digitally signed):

`Unblock-File -Path .\Install.ps1`

Change the execution policy (if necessary):

`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force`

Run the script as an administrator:

`Start-Process PowerShell -ArgumentList "-ExecutionPolicy Bypass -File .\Install.ps1" -Verb RunAs`

This will install all necessary dependencies, including the ActiveDirectory module if it is not already present.

## Notes

Ensure that PowerShell is running with administrator privileges before executing the scripts.

If you encounter execution policy restrictions, you can temporarily bypass them using:

`Set-ExecutionPolicy Bypass -Scope Process -Force`

This project is intended for system administrators and IT professionals managing Active Directory environments.

The included GUI allows users to launch scripts more conveniently without needing to execute them manually from the command line.

### License

This project is provided under the MIT License. Feel free to modify and distribute it as needed.
