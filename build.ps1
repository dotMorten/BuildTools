#!/usr/bin/env powershell
#requires -version 4
[CmdletBinding(PositionalBinding = $false)]
param(
    [Alias('p')]
    [string]$Path = $PSScriptRoot,
    [string]$ConfigFile = $null,
    [Alias('d')]
    [string]$DotNetHome = $null,
    [Alias('s')]
    [string]$ToolsSource = 'https://aspnetcore.blob.core.windows.net/buildtools',
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

$ErrorActionPreference = 'Stop'

if (!$DotNetHome) {
    $DotNetHome = if ($env:DOTNET_HOME) { $env:DOTNET_HOME } `
        elseif ($env:USERPROFILE) { Join-Path $env:USERPROFILE '.dotnet'} `
        elseif ($env:HOME) {Join-Path $env:HOME '.dotnet'}`
        else { Join-Path $PSScriptRoot '.dotnet'}
}

if (!($ConfigFile)) {
    $ConfigFile = Join-Path $Path 'korebuild.json'
}

try {
    Import-Module -Force -Scope Local "$PSScriptRoot/files/KoreBuild/KoreBuild.psd1"

    Set-KoreBuildSettings -ToolsSource $ToolsSource -DotNetHome $DotNetHome -RepoPath $Path -ConfigFile $ConfigFile
    Invoke-KoreBuildCommand "default-build" @Arguments
}
finally {
    Remove-Module 'KoreBuild' -ErrorAction Ignore
}
