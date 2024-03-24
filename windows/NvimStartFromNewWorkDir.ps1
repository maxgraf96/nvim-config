param(
    $x = ""
)

Start-Process powershell -ArgumentList ("-Command `"cd '$x'; neovide`"")
