#===========================================================================
# Hide console window
#===========================================================================

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

$Console = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($Console, 0)

#===========================================================================
# XAML
#===========================================================================
$BackgroundColor = "#34495e"
$RolloverColor = "#2b3c4e"
$ToolsTextForeground = "#353E47"
$ToolsTextRollover = "#B2292E"

$inputXML = @"
<Window x:Class="PSUtil.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:PSUtil"
        mc:Ignorable="d"
        Title="PowerShell Utility (GUI v0.1)" Height="450" Width="450" MinWidth="362" MinHeight="435" Background="#f1f1f1" ResizeMode="CanResize" Topmost="False" WindowStartupLocation="CenterScreen" >
    <Window.Resources>
        <SolidColorBrush x:Key="TextBox.Static.Border" Color="#FFABAdB3"/>
        <SolidColorBrush x:Key="TextBox.MouseOver.Border" Color="#FF7EB4EA"/>
        <SolidColorBrush x:Key="TextBox.Focus.Border" Color="#FF569DE5"/>
        <Style x:Key="TextBoxStyle1" TargetType="{x:Type TextBox}">
            <Setter Property="Background" Value="{DynamicResource {x:Static SystemColors.WindowBrushKey}}"/>
            <Setter Property="BorderBrush" Value="{StaticResource TextBox.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="KeyboardNavigation.TabNavigation" Value="None"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="AllowDrop" Value="true"/>
            <Setter Property="ScrollViewer.PanningMode" Value="VerticalFirst"/>
            <Setter Property="Stylus.IsFlicksEnabled" Value="False"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type TextBox}">
                        <Border x:Name="border" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" SnapsToDevicePixels="True">
                            <ScrollViewer x:Name="PART_ContentHost" Focusable="false" HorizontalScrollBarVisibility="Hidden" VerticalScrollBarVisibility="Hidden"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsEnabled" Value="false">
                                <Setter Property="Opacity" TargetName="border" Value="0.56"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <MultiTrigger>
                    <MultiTrigger.Conditions>
                        <Condition Property="IsInactiveSelectionHighlightEnabled" Value="true"/>
                        <Condition Property="IsSelectionActive" Value="false"/>
                    </MultiTrigger.Conditions>
                    <Setter Property="SelectionBrush" Value="{DynamicResource {x:Static SystemColors.InactiveSelectionHighlightBrushKey}}"/>
                </MultiTrigger>
            </Style.Triggers>
        </Style>
        <SolidColorBrush x:Key="Button.Static.Background" Color="$BackgroundColor"/>
        <SolidColorBrush x:Key="Button.MouseOver.Background" Color="$RolloverColor"/>
        <SolidColorBrush x:Key="Button.Pressed.Background" Color="$BackgroundColor"/>
        <Style x:Key="ButtonStyle" TargetType="{x:Type Button}">
            <Setter Property="Background" Value="{StaticResource Button.Static.Background}"/>
            <Setter Property="Foreground" Value="#FFF"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Center"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
            <Setter Property="Padding" Value="5"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type Button}">
                        <Border x:Name="border" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" SnapsToDevicePixels="true">
                            <ContentPresenter x:Name="contentPresenter" Focusable="False" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" RecognizesAccessKey="True" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="true">
                                <Setter Property="Background" TargetName="border" Value="{StaticResource Button.MouseOver.Background}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="true">
                                <Setter Property="Background" TargetName="border" Value="{StaticResource Button.Pressed.Background}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Grid Height="Auto" Width="Auto"  >
        <Grid.ColumnDefinitions >
            <ColumnDefinition Width="15*"/>
            <ColumnDefinition Width="126*"/>
            <ColumnDefinition Width="112*"/>
            <ColumnDefinition Width="15*"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="55"/>
            <RowDefinition Height="35"/>
            <RowDefinition Height="34"/>
            <RowDefinition Height="200*"/>
            <RowDefinition Height="80*"/>
        </Grid.RowDefinitions>
        <Border Background="#f1f1f1" Grid.Row="1" Grid.ColumnSpan="4" Grid.RowSpan="4"/>
        <Border Background="$BackgroundColor" Grid.Row="0" Grid.ColumnSpan="4"/>
        <Border Grid.Row="0" Background="$BackgroundColor"  Grid.Column="2" Grid.ColumnSpan="2">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center" >
                <Label Foreground="White" FontSize="15"  Margin="0,0,10,0" Content="PowerShell Utility"  />
            </StackPanel>
        </Border>
        <Border Grid.Row="0" Background="$BackgroundColor"  Grid.Column="0" Grid.ColumnSpan="2" >
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" VerticalAlignment="Center" >
                <Image x:Name="Logo_Image" Source="C:\Users\jdespadmin\Pictures\polsinelli_white.png"  Margin="10,0,0,0" Height="36" Width="33"/>
            </StackPanel>
        </Border>
        <Border Background="$BackgroundColor" Grid.Row="2" Grid.Column="1" Grid.ColumnSpan="2">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" VerticalAlignment="Center" >
                <Label x:Name="Header_Label" Foreground="White" FontSize="15"  Margin="10,0,0,0" Content="Device Information" />
            </StackPanel>
        </Border>
        <Border Background="#FFF" Grid.Row="3" Grid.Column="1" Grid.ColumnSpan="2">
            <ScrollViewer ScrollViewer.HorizontalScrollBarVisibility="Auto" ScrollViewer.VerticalScrollBarVisibility="Auto">
                <TextBlock x:Name="AboutMe_TextBox" Height="Auto" TextWrapping="Wrap" Width="Auto" FontSize="14" xml:space="preserve" Margin="10" FontFamily="Segoe UI" Foreground="#353E47">
                    <TextBlock.Triggers>
                        <EventTrigger RoutedEvent="TextBlock.Loaded">
                            <BeginStoryboard>
                            <Storyboard>
                                <DoubleAnimation Storyboard.TargetName="AboutMe_TextBox" Storyboard.TargetProperty="(TextBlock.Opacity)" From="0" To="1.0" Duration="0:0:1" AutoReverse="False"/>
                            </Storyboard>
                            </BeginStoryboard>
                        </EventTrigger>
                    </TextBlock.Triggers>
                </TextBlock>
            </ScrollViewer>
        </Border>
        <Button x:Name="Tools_Button" Style="{DynamicResource ButtonStyle}" Content="Tools" HorizontalAlignment="Left" Grid.Column="1"  Grid.Row="4" VerticalAlignment="Center" Width="100">
        <Button.Triggers>
            <EventTrigger RoutedEvent="Button.Click">
                <BeginStoryboard>
                <Storyboard>
                    <DoubleAnimation Storyboard.TargetName="AboutMe_TextBox" Storyboard.TargetProperty="(TextBlock.Opacity)" From="0" To="1.0" Duration="0:0:1" AutoReverse="False"/>
                </Storyboard>
                </BeginStoryboard>
            </EventTrigger>
        </Button.Triggers>
        </Button>
        
        
    </Grid>
</Window>
"@ 

$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML

#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
Try{

    $Form=[Windows.Markup.XamlReader]::Load($reader)

}
Catch{

    Write-Warning "Unable to parse XML, with error: $($Error[0])`n Ensure that there are NO SelectionChanged or TextChanged properties in your textboxes (PowerShell cannot process them)"
    throw

}

$XAML.SelectNodes("//*[@Name]") | ForEach-Object {

    Try {Set-Variable -Name "WPF_$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop}
    Catch{throw}

}

#===========================================================================
# Functions
#===========================================================================



#Set Variable Paths For Scripts



 # Get the current user's home directory
 $UserHome = [System.Environment]::GetFolderPath("UserProfile")
 
# Scripts folder path
$ScriptsFolder = "$UserHome\PowerShellUtility\PowerShellUtility-main\PSUtilScripts\"



Function Get-Tools {

        # Update TextBlock
        ($JSONTools.PSObject.Properties | Where-Object { $_.TypeNameOfValue -eq "System.Object" }).Value | ForEach-Object {

            # Inspired by https://github.com/kunaludapi/Powershell/blob/master/Powershell%20GUI%20format%20text/Format-TextFomattingOnGUi.ps1
            $script:ObjRun = New-Object System.Windows.Documents.Run
            $ObjRun.Text = ([char]0x2022 + " " + $_.Name + "`n")

            $Process = $_.Process
            $Argument = $_.Argument
            
            If($_.Header -eq $False -and $_.Argument -ne $False) {
                
                $ObjRun.Cursor = "Hand" 
                $ObjRun.Tag = $Process + " " + $Argument

                $ObjRun.Add_MouseDown{param($ObjRun)

                    Start-Process ($ObjRun.Tag -replace "\s.*").Trim() -ArgumentList ($ObjRun.Tag -replace "^([^\s]+)\s+")

                }
                $ObjRun.Add_MouseEnter{param($ObjRun) $ObjRun.Foreground = "$ToolsTextRollover" }
                $ObjRun.Add_MouseLeave{param($ObjRun) $ObjRun.Foreground = "$ToolsTextForeground" }

            }
            ElseIf($_.Header -eq $False -and $_.Argument -eq $False) {
                
                $ObjRun.Cursor = "Hand"
                $ObjRun.Tag = $Process

                $ObjRun.Add_MouseDown{param($ObjRun)

                    Start-Process $ObjRun.Tag

                }
                $ObjRun.Add_MouseEnter{param($ObjRun) $ObjRun.Foreground = "$ToolsTextRollover" }
                $ObjRun.Add_MouseLeave{param($ObjRun) $ObjRun.Foreground = "$ToolsTextForeground" }

            }
            Else { $ObjRun.Text = ($_.Name + "`n") ; $ObjRun.FontWeight = "Bold" ; $ObjRun.FontSize = "15"   }
            
            $WPF_AboutMe_TextBox.Inlines.Add($ObjRun)

        }

}






#===========================================================================
# Begin Functions
#===========================================================================
























#===========================================================================
# End Functions
#===========================================================================






#===========================================================================
# Tools menu items
#===========================================================================

$JSONTools = @"
[
   {
      "Name":"PowerShell Scripts:",
      "Process":"",
      "Argument":"",
      "Header":"$True"
   },
   {
      "Name":"Get User Groups",
      "Process":"powershell.exe",
      "Argument":"$ScriptsFolder\Get-UserGroups.ps1",
      "Header":"$False"
   },
   {
    "Name":"Compare AD Groups",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Compare-ADGroups.ps1",
    "Header":"$False"
 },
 {
    "Name":"Get Group Members",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Get-GroupMembers.ps1",
    "Header":"$False"
 },

 {
    "Name":"Get Logged On User",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Get-LoggedOnUser.ps1",
    "Header":"$False"
 },
 {
    "Name":"Get User Computer",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Get-UserComputer.ps1",
    "Header":"$False"
 },
 {
    "Name":"Get Computer User/AD Description",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Get-ComputerUser.ps1",
    "Header":"$False"
 },

 {
    "Name":"Get Folder Permissions",
    "Process":"powershell.exe",
    "Argument":"$ScriptsFolder\Get-FolderACL.ps1",
    "Header":"$False"
 },

   {
      "Name":"Other Tools:",
      "Process":"",
      "Argument":"",
      "Header":"$True"
    },
    {
        "Name":"Coming Soon",
        "Process":"",
        "Argument":"",
        "Header":"$True"
      }
    

]
"@ -replace '\\', '\\' # Fixes JSON parsing errors that occur when using a folder directory














#===========================================================================
# Use this space to add code to the various form elements in your GUI
#===========================================================================


# Setup icons
[string]$base64_Black=@"
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
"@


[string]$base64_White=@"
iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAAkzElEQVR42u2daVQUx97Gye6GWxRlVMSFERTXURZBRBZxYRQ3lLhFUNS4IjG4JZK4JbmouXG7GGNiFuKuCS6JGsmqV0Mk4RoMSkJCDLm8l3uJeHnf4zmcU29VT/dMD/QMMz093T3V/+ec58t8nt9TXVVPVXl5gUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEokxXK1E0djZ2HnahO3zld/v++q59f/WbfX9Z0bS/+NW2P/+laX9Wbt8FP9v35Z/s+9Oypn3pjm1fvN20L5Ta9yc/Nu2Pb9n2+ZKmfe4H+z57077P/MO+84sFnY+djW0A4i3gG7Hz3QW9p8DvSAC4Cn9TAeAq/I4EgIbht/JH36NcbJ2Wwddh53KAXrx9v2j9vvwK46Ittf1Hz0fSOg31j7c42OxUa8cRz7Nyv9inG3iuxTEm942ZY/Eo4tmsZ6Eg4mjOMy0e+RTjQLNTUGAU5xkocMQM1IfxdIsjk83WR04zOYJ4qsXDp6AAxpNRQDjnSag3cRhxksWhExn3YjwB9QohNjLuOSyR5/Go51CTewwdZ7JhLM9jkP8QzgnIf/Boxt2JB8WzjmPsN5A4lnUM8htgcrcBo1C3/sTRjLsGj2Qdhbr24zwCdSHuG8k6AnUJikA6xsORLjCcsS9xnzDWochXH4o660NMDiAexrhTwFDUqTexweReQ5APcc/BrAehjj2IB5rsP4BxB8b9UYfuxMGMn/Trh90XPdmNOAi1J+4aaHGXPsgQM7V2+aZ3yjH4hawLsPVahF+PXcCBn7H9SOWwCUvrpQeftVj4GwWAM/CzASAGfnMAiIWfHwDOw28dAE7CzwaA/PAPVxj+fnbhb8dYj9rp9KhvaELdjsM3SnghoNMS/AYO/ve/KCsZkfzsA7eB32D0lx3+Ua7AP8Nj4fd3AX5LADgPv3UAOAe/dQCIgJ8d/ZuCv50ugHHnngPrc8/+XMyGQK7mRn4Cv1tHfZuf/mLgf9oF+Ge5Bj8vAJyDnw0A0fBbAsBp+M0BIBb+kS7CH+YC/INFw99o9LcBf1vf3oyHRE+q5aYDH35H+cIght6bW+xTDv40bcHfMABkhT9ePPzBLsLPH/2dhN9q9Hcj/G19e6G2nXuhl/ZfLsXwkwDIpj0A0rk5v0fCH+sC/GwAiIXfHAAyw28OAJHwWweAs/CzAaAU/GwAiIIf2xH423TuiYxzs6rYAMinfcWfWe2fu25vtafCbxUATsIf5Cr8kS7AzwaAKPitAkAs/LHi4DcHgAj4eQEgFv6OIuE3j/5NwE88OCqplg2AQupH/9M3/lmsOPwCASAf/PwAmCF+u08E/OYAEA3/WPHwD3QFflMAiIWfCQDR8A8QDz9v9LcFf5tOPTQTAPnuH/1lgl8Fe/0BLu31G13c608Qv9cvEn7z6B/o4l6/s/DzRn+x8FsCoDH8pgCYSHcA8D//3bfl54FFnygo+tBW9LE77xeAv00nfzR4BP0BYHT75z8UfaDo4+iinwxFH6F5vxD8rX38UfLiTZVsAOTRGgCZJAC2HPq0HIo+Uhd9JkPRR6VFH8F5fwP4W/t0R89tP1lG9TYgd7rPPfN/KPp4bNEnmP6ij/C83wI/8Xtf/KeIDQAjreUfZv4fP3dDHRR91Ff0cXWvH4o+zsDPBYAJ/u5BIQ+4+f/pIgrPA7C9f6b8A0UfKPpIXvTRq7/oY+vTv3XH7ih28sJqFv4Cqvf/dx6/WgZFH/fv9UPRR31FH0H42QBYkv1WOYafBEAOrQHAnPcnx309b68fij6aKPr4u7foYwv+1h39UM7735awAZBCawAw839pLvmQD/5Q4yI0N2Mr6y2MPafoMwGKPioq+tiCv6NfUD0LP7GBRvj1XAB4StFn3Sv70a07vyJbuvRlIZq7cjMUfai91EP6oo8Q/N7YYaNTargAoHX0T+GO/qq96ENG+rt//As5KhIEIePnQ9EHij5NFn2E4Pfu0A1NW/hiJRsAubQGQA4JAHLPn5qLPmTUF6Nbd35Bw5gQgKIPFH16OQU/cfbfLpWyAZBO9QGg5IztNWot+oiF3yoExqXJsNcPRR9PLfoIwe/doSvizf+j4QCQAkWf+KdWodr7dchVWUIAij5Q9LEu+tiCXz9oZB0vALxpDIBo1w4Aub/oc/27W0gqXfr6exwAM9Vb9JFkrx+KPs4WfYTgb/VkVzR+ZmYVC38+rZ//meILQI6u+Isv+pDRX2qdunAN9Yl6Coo+UPQxB4AQ/K2e7IJW/+V4GRsAdB8AWrTprSo17vXvefsUcodOnv8Sij5Q9LGM/gLwE+/LLysmAXDqBoUHgPgFIOcOAMlX9JHy879RCJz7DIo+UPThjf7W8HfTD3nAwk+spxF+g/MFIHlv9HFmz1+Mdr99Goo+Gi/6WI/+JvhbtdehURPnV7Pw030AaP/570vVeqOPHFr76iEo+lBU9BGz1281+mP4iedm7KhgAwAOACl1o4+9uq+UWrNtv3qLPi7v9UPRx2H42QBo2d4XvfpeYQkbANQWgAocPwCkzI0+178rQXIpa/NuKPpIXPQxBYC6iz4N4ecCgIWfmO4DQE2//qPcjT7bdr+L5NSs5ZspLfpEQdHHCfgHhI+t5QKA1tHf6NgBIGVv9ImbsVLWAKj97/+hiWkboOijoqJPezcWfYTgb9nOF01dsLGSDQBqbwDObvoGYPcXfRy50efQsfOyh8CEp1dD0UcDRR8h+Fu264w27r1YygZAJtUHgGzfAKyeG31CEhcwPX45de/+f5Fxzioo+tBS9LGx1y8EP/E7Bf8uYgOAygNA3vYPAKnv6S5ypv/uH/8jewhET16szqLPACj6uAv+3gMi6ngLgFTeABxt+wZgpZ7umt3kXX5JaWslORXo1AnCn35HQxLmQdGHwqKPEPwt2nZC0RNSuQKQFg8AqfvprqS0NcqEQPxs6oo+Oo0XfYTgJ170/BvlbABQewAoV/gAkGc83ZWUKn8IlNz+GQ2OTYGij1qKPi7u9duCv0VbH7T3w7JiEgAnv9XUDcCe9XRXUmqW/CFQSkJghpuKPvFQ9JG56CMEf3vfnvUs/MRaOQCksqe7HHy9Z83WfUhunfz4Cp4GJEHRx8OLPtzoz4e/RRsfFBIztYaFXysHgNT5dJejr/es2bpXoRCYqL6ij8t7/dop+liP/ib4W7TpiGavyKlgA0ALNwCro+hjd97vwNNda7bskT0EjudfgqKPBxd9rEZ/Fv7mrTui5/dcKGUDgO4DQMkr8Q3AFD3dpVgI0Fb0CdBG0afhpz+Bv3nrDoiFn5jKA0DMDcBXfscHgIxL6tVU9JHi6a63j56VPQSyth2Aoo9qij7dRMHPjf7BIfG1vACg8gZgI4H/1Ld/FKux6CPF010nzxXIHwJbD0DRx4OKPkLwk9F/zPTlVSz8dB4AwvBnkwDY/PalcrUWfaR4vefkWflD4Nns7VD08ZCijxD8xKu2HSljAyCT1gDIIwEwd+3eajUXfaR4uuuEEiGwcTsUfTyg6CMEf3PvJ9Ghy/8uYgPASCP83gR+4rg56+vUXvSR4vWektvlsodA4pzVUPRRcdHHFvy+Pfo94M3/dTQGQDSB/0Lp/SK17PW7E35yo48B9/flDgFyl0Di7Geh6KPSoo8Q/M2wo8bPrWbhz6f18z+dBEDuue9LPano4+rTXUPiZzE9frlDYOz0xVD0UWHRRwj+Zt7t0cJ1ueUkAE4UUnoDMIY/lwTAypzDlZ5W9HH19R4lQuBe7X0cAoug6GM1+itf9BGCv1mr9ujlQ9dLMPwkAFJoDQBm/p+4cFOtJxZ9XH26a0jcTOaCD7lDYMCo6VD0UVHRRwj+tj7d6ln4iQ00wq/nAsCTiz6uvt5jnL1S9hAoKbuL+kdPh6KPCoo+QvA3a9UO9R0aW8sFAK2jfwqB/93Py0o8vehjc97v4NNdiQqFQHDkBCj6KFz0IW4I/xPYk+atq2QDIJfWAMghAbBu70cVNO31i326K3HWCvx5Lm8I/PBjGQqOmEBP0cfP84o+5tGfB/8TLduiDbs+KWUDIJ3WAMj/+i4qnLYip4Ze+J17uitx1nLZOwJXv72JpwHxUPRRqOjDH/05+Il58/9o6uDH4OsI/MSRU1c9oKno4+rTXatf3Cl7CJw49xWzKAhFH9PoL1fRp9GnPwt/j6BhdbwA8KYxAIwE/pOFfxTTVvSR4vUeJULg+JkCKPrIXPRpOO83BUAblDBtSRULP50HgDD8mSQAdhy9UqbMXr97iz5SvN6zOlv+EDh6+jwUfWQs+jSG3xQAGVsPl7EBkE1rAOSRAFj44sEqWos+Ujzd9dL2XNlD4M33Tgl/+kPRR/KijxD8T7Rog3aful3MBoCRRvi9ufl/3Ox1dTQXfaR4uut4/kX5TxBu2gdFHzcXfWzB38mvzwPe/F9PYwAYuADQQtFHitd7lAiBzOzXoejjxqKPEPyPt2iNDFETalj4C2j9/E8n8P/tLD4AJMF2nycUfaR4uuvYRxdkD4GMdVug6CPBXr+j8BPPXPpyBQmA499QegAIw59LAmDlXz6o1FLRR4rXe5QIgZVrN0PRxw1FHyH4H2/ujba9fa0Ew08CIJ3WACggATB+wUu10sE/yyOKPoKjvxNPdw2Imsy09+Q+Rjxm+lLVFH2epKToIwQ/MQs/sYFG+PXc/N8wflG9Fos+rj7dpVQIJExf0ujTH4o+4oo+tuAPHDyylgsAWkf/FAL/O5/dKVFb0UeSvX4R8It5uqv/iEmyhwA5RhyXNJuSoo+/okUfIfgfa9YKTZy7ppINgFxaAyCbBMBLBy+Wa73o4+rrPf1HJCkTAhNnQ9HHxaKPEPzE618/X8oGQCatAZD/1W+ocHbW7moaiz69ZYKfu9Fn+NiZDJSyHiO+8xsKDEuEok9b8UUfIfgfa9YSvXWpuogNADoPABH4iSOmrHwARZ9xkrzeMyY5XYEQqECBoeOh6CMWfjYA+PB31w+q4y0A0ncACIMfTeD/+Nb9Iij6OLDo58TrPWOmLZA9BG6WlCK9YRQUfUTCbwmAluixJ1qgiISUahZ+Om8AxvBnkgDYfuTrMij6SAc/d6NPglIhMCQaij6i4W/FwP8o9vysveVsAGTTGgC5JABWvJpXCUWfplf8xTzdNX/FBtmLQp8UXMPrAaGeX/Rxda9fDPzs6P/oE83RrhO3i9kASKE1AJj5//gFL9ZC0ceZRT/nnu5atWGb7CFw7MxnTAhA0UcM/C2Qd7uO9dz8/9h1Cg8AYfANXABA0cf5FX9nX+/JWC9/CBw5dR6KPg7s9TeEn4z+gyPG1bDwF9A6+qcT+Ped+a4Uij7Ob/eJeborY/1W2UPg8PGPoOjjJPyPPt4cpTyzpQLDTwIgl9YAyCEBsHb36QpFiz6RnlP0keLpru17DsoeAjl7Dqmj6OOjvqKPEPyPPt4MrXvtXCkbAOm0BkABCYApy16pgaKPGPjFP9119NQ5+Y8Rb3zNevSHoo9N+IlZ+IkNNMKv5+b/Q8al13t80SdU3qKPFE93KREC85a/4PFFH1MASFP0sQW/fmBELRcAtI7+RgL/8et/FEPRx7W9flee7jpy6qysAXD3nzUoKGIKFH3swP/IY0+g2EnpVWwA5NEaANlfVqDCF9+8UA5FH9f3+l15vef8pc9lDYE1O04iXXC8tos+OABswU+8/KX3y9gAoPMAEIY/nwTAgo0HqqDoIw38Yl/vCRwWj27eui1bAFwrLkcB8ZmoA94V0HrRRwj+Rx59HB28WF3EBoCRRvi9CfzEMU9l1amx6BPgYUUfq9FfxNNdfXAIyKk+455HXQaOVUXRhwkABYo+pgBoDH+Hzv4PeAuAOhoDIJrAf77kfhEUfaQr+rjydNe8Jc/JHgA9Ry7SdNGHG/358BOHxyVXs/Dn0/r5n04CYG9+USkUfaQt+oh5umv/ocOy7wb0GbeBMT1Fn7ai4DcHAAv/w48+hmYs2swVgHJoDYBcEgDLX3m/Eoo+0hd9HH26Ky5pjqxzf6EA0HLRp+HoT+B/+JHH0JY3r5awAZBCawAw8/9xaRtroejj3r1+W/CvWLtJ9mPC/MtEzQGg4aJPw09/EgAtvdvVc/P/o9coPACEwTdwAQBFHzfDbx79LfCTFX+5t/0a6uTFG40DQGNFHyH4yeiv7x9ey8JfSOvon0LgP3T5TgkUfdxf9LGM/uFoypwlqOJuJVJas7PeZODXJ2RptugjBP/DjzyKjDMzKwn82Lm0BkAOCYCsXacqxBZ9AqHo4/Re//bdB5AadK34Z/Po3z18lkOLfjQWfYTgJ16z42wpGwDptAZAAQmAmav/Wq3Foo+/zEWf0NjJ6Mq1G0gt4kZ/4k59Iikv+rRwCv6HHn4EsfATG2iEX8fN/8MnLXsARR/3Fn1Sl6xRbKFPSLvev2yGv2fUQs0WfWzB36VH3zpeAHjTGABGAv+xa5XFUPRxX9EnMGQ0euPQEaQm8Rf++ozlRn9tFn2E4CeOmZBWxcKfR+vnf+YXv6LCv3zwVRkUfdxT9ImfNFexvX1bOnT6igV+7K5DJmu66CME/0MPPYxSM3eVswGQTWUAYPjzSADMf2F/FRR9pC/6vLDtNVWBT/b7l2x63wr+7mGzPLbo4+pevz34iV87VlrMBoCRRvi9CfzEo1JW10HRR7qiT1BIAt7b/0JV8N/6qRLFzMuxgr/bsOmSFH1ae3DRxxb87X26PODN/3U0BoCBCwAo+gh8+oss+kydu1RVC30NF/u4/f7OQTFQ9GFH/4bwez30EOofEl/Dwl9A6+d/OoF/z0dFpVD0kabos333m6oCn9z2w9/mI+41aik+9z8Eij4NP/158Ht5PYSS01+qYAMgh9YAyCUBsGzbu5VQ9HGt6BMWP1V1C32XrpSgYdM2W3/yGyZD0cfOvJ+DH+OBNh+4UkIC4MjfKT0AxH3+T35maw0UfcQXfTLWbVHVJz9Z6Fuz44QV+L3jVuFtvhEauNGnhWj4mQBg4Sdm4Sc20Ai/nguAQQmp9VD0cb7oExQ6RpFbfJ1d6POPTEVP4gs/tXOjT3Nx8PNG/959Q2pZ+AtpHf1TCPxvf3q7RN6izyQqij6jJ89Dv939Q/ULfbr+YxS80cdX9UUfIfiJx6dkVLIBkEtrAOSQAMg+8HE5FH2c2O7D8G/c9lfV7e0LLfR17GkwH+3V+o0+zsBPvDT73TI2ADJpDYB8EgBPZe6shqKPY/AHhY1FV67fUOFC35bGC31Cl3pA0cch+IkPfPKvIjYAommEX0fg//wXVBg28ZkHUPRpGv7UZetUt9C3Nfccc5En/5O/U2CUW270obHoYwt+XffAOm7+j03fASAMfjSB/+zN2iKX4cemvejzxjtHVbbQ9wdKWrrHCv4eZKHPfwDS8tNdzhZ9hOAnDh01pZqFn84bgDH8mSQAXn3/yzJtF33s7/UnTJmH9/bvqPAQz/Nm+Mmo33WwEZ7uElH0EYKfeN6q18vZAMimNQDySAAs3fpOpRqKPkq/3iMEf8b6rar75J+dddAK/l4xy1CngHBRr/coVfRprqKijy3vPPpjMRsARloDgJn/j3l6fS0UfayLPn3DxqGPP/1SpQt9z5vtFzJDo093SVf0EXLzFt71vPm/nkb4DVwAuGWv34OLPtOeXo5++11de/uWhT6T9Qlr8CGekRp/ukuavX4h9x8WV8PCX0Dr6J9O4N99+kYpFH0sn/479ryl4oU+k3tEpuFDPANV9HSX5xZ9bJlXAMqhNQBySQCsfu1EBRR9RqKw0cl4b79IdQt9DT/5uw6eaPfJbqWKPi7v9StU9LHlrO1nStkASKc1AApIACQt2lyj9aJP2nL17e0v2ZRnBX6vmOWok364Xfih6CMN/MS8+b+BRvj13Px/YPzT9eou+ox1W9Gnb/h4dODdY6oa9a8Vlzde6AtNwZ/8gxyD35OLPi7v9UsDP/UHgDD4RgL/0auVxVot+iRMTVPd3r7QQp9vcDwGv58T8EPRxxX4iUcZU6vYAMijNQCySQBs3H++XItFn40v71LdbT0NF/p6jlyMOvYYLAp+KYo+pgCgu+hjy9QfAMLw55MASF2/r0pLRZ9+w8erbm+f3MnfaKFvyETUoXswC38/kfBD0UcM/NQfAMLgexP4PytHhSOTM+q0UvSZNm+l6hf6AuIzUec+Edbw+/X13KKPt3qLPrbcrqPuAW8BUEdjAEQT+M8U1xZppeizY+/bqlvoi5m33Qp+/+Fz8bn9wQLwQ9HHXXv9mjwAhOHPJAGw69S3pbQXfcITZqAfflTXQp/pth7rhT5d8GgGfJvwa7jo4869fiEnL3ixguoDQBj+XBIASzYfqqS56LNqw8uq+uS/W4UX+pbhhb7xvIW+6MXIJyDUcfih6ONW+Ik3vXGlhA2AFFoDgJn/J8xZW0tj0aff8ER09PR5dS30XcILfclbrOD3GzYNQ9/fKfiVL/p0oqboo8kDQBh8AxcAA+Lm1NNW9EmYOl9Vh3iYa7l3njSBP5630BcYKR5+Kfb6NV700WwBCIOfQuA/eLG0hLaiT/Yru1V3iCcmdYcV/MxCXy8D6uDf3xwAssOvcNHH1b1+d8HvpYUbgDH8OSQAnt1xrIKWok+/CCO6+s13KlvoK8DQv2CGnyz0dR2UiMEfYAW/JQCg6CNn0UezB4Aw/AUkAGaszKmmoegzf8UG1S30zVlz0Ar+3uQQT0CYHfih6CN30UeTB4Aw+Dpu/h+SmP7A04s+B947rq7beq7ewgt9W63g9xuWjDoy4NuBnx39oegjT9HHlqm/ARiDbyTwH77ye7Hbiz7D3Ff0GTNtgar29slC31q80BfIgG+CP2B0JtL1i3EYfk8u+jTzsKKPZg8AYfizSQC8/O7nZZ5a9Fm14RVVffKThb5YvNBH4OcCoEfUAuSDF/qcgl+Coo8pAKDoI9a8G4AzaQ2AvIKfUeG8tXurPKPoY9nrD46YgD65/JXKbuu5agafWD9mLb6tJxGf4BsoHn6tFn1k3Ov30uINwBh8bwI/8ejZWbWeVPRJTstQ3d4+Wejjw987dgXqpA83w99RJPxQ9FEGfuoPAGHwo7kA8KSiz859h1S50MeHv3v4LBP4VvAPgKKPCos+Xk3fAEznASAMfjqB//WThaWeUPQZPvYpVe3tM+/v7T9nBX4f/MmvC44Vhl9k0eeZlVnoqyvXkKfr88+/QGkLFqqu6OPAAaAcWgMglwTA4k1vVaq96DN/5QuqW+hLWrbXCv6eUenIp/ewJuF3tOgTNToJ/frbXUSbfvnlF2QICVVN0ceBAlAKrQHAfP5PSM+uUXqv3xb8wZET0ZvvnVD1Qh8Z9f2GTsbQD3ICfvtFn2cy1qA/79UiWlVT8ydKTVugiqKPJgtAGHw9FwD9Y2bWq7HoMyY5He/tl6nuth4+/AGxK5Fv35HOw2+n6ENGfprh54eAYWiIiO0+98NP/QEgDH4Kgf/NT34sUWPRZ0zyQlV98jPXcjdY6PPHC30++LYesfDb2usvvnkLaUU3f/wZtek2SPEVf80dAMLw55AAeH7f2XK1FX3UBr/QQl/XgWMZ+H16DrIEgATwk09/renZbe+g5m11qoHfy/oG4HRaAyCfBMD0Fa9Wq63oo5bPfqGFvt6jluBDPCGN4Zeo6HP244uaC4CLX99EfuFPqwZ+L9pvAMbg67j5/4gpS+vUVPQhq/1qWehr+MnvN3QKC74w/FIUff68d09zAXDv/v+i3vGrUZuuA1QBP/UHgDD4RgJ//ve1RU0u+slc9FG62iu40BdHFvqiHYDf9aKPVkUCwHfQJMXh97K+ATiP1s//TBIAW9/5rExtN/ooOfcXWujrMXw2/uQPdQx+CW700ap6xa1GPaKXKw5/gwNA2bQGQN7ln1DhohcPVqrpRp/gyAmK/QF349t6rBb6xuKFvkHj8Am+IU7D78qNPloOgF5xzyoOv5f1DcBGKgOAwE8cN3N1rZpu9ElOzZD9j2e6lntfo4W+zvpQ1Mkl+MXd6KPVNQAuAJSGn/obgDH4Bi4A1Hajz/AxKbL+8U5eKsKf/Nus9/ZDZzDgM/CbA2CQpEUfe0d7z5y/oLkAuIB3AQj8lgDwUsy8A0AFtI7+6QT+vx4vLFXTjT7cNd7yLfR9gIHfaDm3P3o10vUbJQC/9EUfe+f6F69YrbkAeO7Vwwz8PaKXKTr6NygA5dAaALkkAFblHKlQYq+/qae73H2tF1noi03daQV/z8hU/MkfJgi/1EUfRy71KL5Zohn4S8p+N4/+nQcmKQq/lxZuAMbwF5AAMKa9UKP0jT5CT3e58x5/00LfRjP83EJfp96GpuGX8UafyNjxmlgLIHP/xIU7zAHgrQtWPACoPgCEwddz8/+hY+Y9UO5Gn1ibL/aSJ7yk3gq0LPRZ4O89ainyDRrhFPxy3uizePmz6M8/71ENP/fpT9w1dI7i8FN/AAiDn0Lg/+Cru8VKFX2Enu7i4CfuGjwSP9v9lmR/NOa2nunbePBvRP5hKSbwnYafCwB5bvSJiBmLKn6vog7+u//8j9XIT+b+T3j7KB4AvBuAc2kNgGwSABv2nimXbq/ftae7GsJvchS6cr3I5YW+tTtPocBEC/jMQl9wDAZ/qAvwu1b0cfb1nk6Bo9Bzr+Sha9//7PHg//27n6xGfQ5+NXz6NzgAlElrAOSTAJiT9XqV0k93NRz9+fB37ReF+oaNQzdviVsQNF3LvdMK/l4jF6HOfcIt8LMBIHfRxzz6O3GXX3u/gahXzHKkH7OO9VorBxAnCHmNfY8mzhJ070Z+zuR4W15t19w+P9/dI9NVMfJ7Nb4BOJpG+HXc/D9i0jN1Sj7d1RT8Jo9AQWFj0cHDzj3pvTuvwAQ+C3+fseuQn2ESrvMObQS/EkUfV57u8ukzEvlHpCoH/2hX4LcEgM4wXTWjvpfwDcDeNAZANIH/w6J7RUo+3WVr3t8Q/i7EfSPx79Fo1qpdzFy+qbl+0vJ9VvAHxGUgXd8o2/ArUPTR/NNdChd9HDgAlE/r53/mp2Wo8LVj35QqWfSxN+9vCL/JEfi3kajniFS8mPcyWrL5MDPKc16y+QPTIh8HfiK30PcU6hwwzAH45S36wNNd6gwA3g3AdB4AwvDnkgBYmH2gUsmij7PwdwmKQDrGw5Hf4PF4+26xNewN3Ct6EeoSHIschV+Jog883aU+8w4ApdAaAIXEsSmrauV6vcc5+NkAsAG/LpA43OS+I/C8fgI+qjsT9QififzDZ6JuQ4zINzCCAV8U/Fp9uqulZz/dBQeAHIPfwAVAv6jkeiWLPnbhNweAbfh9ifuEsQ5FvvpQ1FkfYnJAiEvwK/t0V3ePfLqLCQAPhr9BAaiA1tE/ncC///ytEjUUfezDbwoAsfAzASAafnmLPtI+3eWj4NNdj3ks/F5auAEYw59DAiDj1Q8q1FL0sQe/efQXAz9/9PeAok/jT39x8FuN/iLgtwSAtuDXxAEgDH8BCYCpS7ZWq6Xo48iiHxcAouD3oKJP409/peBvJQp+pZ7u8pL+BmADjfDrufn/kNFzHqip6ONu+JUs+ri81y8GfnMAiITfPPo3F73X72nw828ApnX0NxL48768W+xS0cflvX7n4bcOABHwQ9HHhb1+uoo+DhwAyqM1ALJJAGx563KZWos+Dq34i4bfg4s+7aHo4yXfDcCZtAZAPgmA2atfq1K+6BMlDn7+6O8k/FD0gaKPgweAjLQGADP/j5meUespRR/7835lij7toehDHfwNDgDpqA2AS3dQ4fAJC+ug6ANFHy0WfRyY/9N5AIiIwE8cFDmlHoo+Chd9XNzrh6KP2z7/06kPgJjpK2slL/oMgKKPVoo+nr7Xb+f4bwGV5/95AZBPAmDK4s3VUPShoOiDDUUf1+f+vPIPvaM/GwDZJAB2HL1Wqsaijw6KPlD0kfnkH+/obx7Voz8bAAZuGjAqeUUtFH0kLPq4uNcPRR9F4S+g8uivjRDIJQHw3ue/FQdGTKqnrehjCgAo+kDRx37lV5PwswGgu3gbFWAX/u1MSUlYYlodFH2g6KMF+MmoT4778ub82oKfE4Zfz4UA8drXT5dHT1tWK3nRx+W9fij6QNFHmks+yD1/PPCZ8/7UFn4cDAHyJZDLhQDnC6X2/cmPTfvjW7Z9vqRpn/vBvs/etO8z/7Dv/OKm/dH3tv3hd037dJF9n7ph3ye/te8ThU37+De2fex60z56zb55MHmS86mt+ooMAgN2NnY+wK8N+B0JAMrgJyv82VSe8QeBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQCAQCgUAgEAgEAoFAIBAIBAKBQCAQSPP6f1BaHqyk0QnMAAAAAElFTkSuQmCC
"@



$Bitmap_Black = New-Object System.Windows.Media.Imaging.BitMapImage
$Bitmap_Black.BeginInit()
$Bitmap_Black.StreamSource = [System.IO.MemoryStream][System.Convert]::FromBase64String($base64_Black)
$Bitmap_Black.EndInit()
$Bitmap_Black.Freeze()

$Bitmap_White = New-Object System.Windows.Media.Imaging.BitMapImage
$Bitmap_White.BeginInit()
$Bitmap_White.StreamSource = [System.IO.MemoryStream][System.Convert]::FromBase64String($base64_White)
$Bitmap_White.EndInit()
$Bitmap_White.Freeze()

# Set images
$WPF_Logo_Image.Source = $Bitmap_White
$Form.Icon = $Bitmap_Black

$JSONTools = $JSONTools | ConvertFrom-JSON



# Add click event


<# 

$WPF_Tools_Button.Add_Click{

    If($WPF_Tools_Button.Content -eq "Tools") {

        $WPF_Copy_Button.Visibility = "Hidden"
        $WPF_Header_Label.Content = "Tools"
        $WPF_Tools_Button.Content = "Back"
        $WPF_AboutMe_TextBox.Text = ""
        Get-Tools

    }
    Else {

      
        $WPF_Header_Label.Content = "PowerShell Scripts"
        $WPF_Tools_Button.Content = "Tools"
        

    }

}

#>


$WPF_AboutMe_TextBox.Text = "Available Scripts:
"


$WPF_Header_Label.Content = "PowerShell Scripts"
$WPF_Tools_Button.Visibility ="Hidden"
Get-Tools

#===========================================================================
# Shows the form
#===========================================================================

$Form.ShowDialog() | Out-Null