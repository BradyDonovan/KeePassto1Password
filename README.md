# KeePassto1Password
I need to convert a CSV exported from KeePass to one able to be imported by 1Password. This works by simply rearranging the columns so that data falls within the right order expected by 1Password [per their documentation](https://support.1password.com/create-csv-files/). There is currently only support for Login-type items in 1Password, which follow CSV fields like such:
```
title,website,username,password,notes,custom field 1,custom field 2, custom field …
```

# Usage
```
.\KeePassto1Password.ps1 -KeePassCSVPath <Path to file> -1PasswordCSVSavePath <Path to save folder>
```

Or for the lazy,
```
.\KeePassto1Password.ps1 -kpp <Path to file> -1pp <Path to save folder>
```
Or for the very lazy (yay positional parameters),
```
.\KeePassto1Password.ps1 <Path to file> <Path to save folder>
```