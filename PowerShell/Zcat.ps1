Function Zcat {

    [cmdletbinding()]
    Param( [Parameter(Mandatory, ValueFromPipeline)][System.IO.FileInfo]$File )

    Process {

        If ($File.Exists -eq $false) {

            Write-Error "$File : No such file or directory"
            return
        }

        $BUFFER_SIZE = 65536

        $fileHandle = New-Object System.IO.FileStream $File.FullName, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
        $gzipStream = New-Object System.IO.Compression.GzipStream $fileHandle, ([IO.Compression.CompressionMode]::Decompress)

        try {

            $buffer = New-Object byte[]($BUFFER_SIZE)

            While (($read = $gzipstream.Read($buffer, 0, $BUFFER_SIZE)) -gt 0) {

                $str = [System.Text.Encoding]::UTF8.GetString($buffer, 0, $read)
                $tmp = $str -split "`r`n"

                if ($tmp.Length -gt 0) {

                    if ($lastLine) {
                        $tmp[0] = $lastLine + $tmp[0]
                    }
                    if ($tmp.Length -gt 1) {
                        Write-Output $tmp[0..($tmp.Length - 2)]
                    }
                    $lastLine = $tmp[($tmp.Length - 1)]
                }
            }
        }
        finally {

            $gzipStream.Close()
            $fileHandle.Close()
        }
    }
}