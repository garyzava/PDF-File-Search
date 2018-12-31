# Search Through PDF File
#
# Date: 08-Nov-2018
# Author: GZ

Add-Type -Path ".\dll\itextsharp.dll"
$pdfs = gci ".\pdf_here" *.pdf
$export = ".\output\export $(get-date -f yyyyMMdd-HHmmss).csv"
$log = ".\output\log $(get-date -f yyyyMMdd-HHmmss).txt"
$results = @()
$keywords = @('error','cancel')

foreach($pdf in $pdfs) {

    Write-Host "processing -" $pdf.FullName

    try
    {

    # prepare the pdf
    $reader = New-Object iTextSharp.text.pdf.pdfreader -ArgumentList $pdf.FullName
    
    # for each page
    for($page = 1; $page -le $reader.NumberOfPages; $page++) {

        # set the page text
        $pageText = [iTextSharp.text.pdf.parser.PdfTextExtractor]::GetTextFromPage($reader,$page).Split([char]0x000A)

        # if the page text contains any of the keywords we're evaluating
        foreach($keyword in $keywords) {
            if($pageText -match $keyword) {
                $response = @{
                    keyword = $keyword
                    file = $pdf.FullName
                    page = $page
                }
                Write-Host "Found Keyword" $response.keyword "file" $response.file "page" $response.page
                $results += New-Object PSObject -Property $response
            }
        }
    }
    $reader.Close()

    }
    catch [Exception]
    {
        $pdf.FullName | Out-File $log -Append
        $_ | Out-File $log -Append
    }
}

Write-Host ""
Write-Host "Writing Output to:" $export
$results | Export-Csv -notypeinformation -delimiter ',' -Path $export  -Encoding default

Write-Host ""
Write-Host "Done"