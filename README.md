# Office 365 PowerShell Tools

A curated collection of PowerShell scripts and modules for managing and automating tasks within Microsoft Office 365 (Microsoft 365) environments.

## Overview

These tools assist with administrative automation across various Office 365 services, including:

- User and group management  
- License assignment and reporting  
- Mailbox and Exchange Online configuration  
- SharePoint Online and Teams automation  
- Security and compliance checks  

## Repository Contents

- `/user-management/`  
  Scripts to create, modify, and manage Office 365 users and groups.

- `/license-management/`  
  Tools to assign, revoke, and report on Office 365 licenses.

- `/mailbox-management/`  
  Scripts for Exchange Online mailbox configuration and reporting.

- `/teams-sharepoint/`  
  Automation around Microsoft Teams and SharePoint Online.

- `/security-compliance/`  
  Scripts for auditing and enforcing security policies.

## Requirements

- PowerShell 5.1 or later / PowerShell Core (7+)  
- Microsoft Exchange Online Management Module (`ExchangeOnlineManagement`)  
- Microsoft Teams PowerShell Module (`MicrosoftTeams`)  
- AzureAD or Microsoft Graph modules, depending on the script  
- Appropriate admin permissions and consent

## Usage

- Always test scripts in a controlled environment before production use.  
- Review and configure parameters or variables as needed.  
- Ensure secure handling of credentials, using secure prompts or managed identities where possible.

## Security & Disclaimer

- No credentials or sensitive data should be stored in the repo.  
- These scripts are provided as-is with no warranties.  
- Users are responsible for verifying compatibility and effects before use.

## Contribution & Support

Issues and pull requests are welcomed. Please provide detailed descriptions and test cases.

## License

Include your license details here.

---

# Contact

Odell Duffins  
odell@duppinstech.com
