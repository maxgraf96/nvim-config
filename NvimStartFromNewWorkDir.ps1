param(
    $x = ""
)

Start-Process powershell -ArgumentList ("-NoExit -Command `"cd '$x'; nvim`"") -WindowStyle ([System.Diagnostics.ProcessWindowStyle]::Maximized)
