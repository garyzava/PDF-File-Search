# PDF File Search

This Powershell app searches for keywords within PDF files and throws an output file and a error log file.

To change the search keywords, go to the ps1 file, look for the $keywords variable and edit it accordingly. 

Library: itextsharp hosted on https://github.com/itext 

Latest itextsharp release here: https://github.com/itext/itextsharp/releases/latest 

The itextsharp dll is already compiled and can be found in the dll folder, so there is no need to worry about compiling it again.

# Requirements
Powershell 2.0 or above 

# Instructions

Download the repo
```
git clone https://github.com/garyzava/PDF-File-Search.git
```

Place the pdfs files into the directory */pdfhere/*. Open the Command Prompt window and within the directory run:

```
Powershell .\SearchPDF.ps1
```