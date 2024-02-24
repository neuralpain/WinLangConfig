# WinLangConfig

<!-- adksetup /quiet /layout c:\temp\ADKoffline

adksetup.exe /quiet /installpath c:\ADK /features OptionId.DeploymentTools

https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-8.1-and-8/dn621910(v=win.10)

Set-WinUILanguageOverride -Language de-DE -->

A small script to change the windows display language because it can be tedious sometimes and just does not work at other times.

It is currently still in beta but you can [try it out](https://github.com/neuralpain/WinLangConfig/releases/latest) on your system. Just be sure to make a system restore point before you run the script.

## Supported Language Packs and Language Interface Packs

- **Language/region** - The name of the language that will be displayed in the UI. All Windows language packs are available for Windows Server. In Windows Server 2012 and later the user interface (UI) is localized only for the 18 languages listed in bold.
- **Language/region tag** - The language identifier based on the language tagging conventions of RFC 3066. This setting is used with the Deployment Image Servicing and Management (DISM) tool, or in an unattended answer file.
- **Language/region ID** - The hexadecimal representation of the language identifier. This setting is used with the keyboard identifier when specifying an input method using DISM.
- **Language/region decimal identifier** - The decimal representation of the language identifier. This setting is used in Oobe.xml.

[Read article...](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11)

Language/region	| Language/region tag |	Language/region ID | Language/region decimal ID |
| --- | --- | --- | --- |
| Arabic (Saudi Arabia)         | ar-SA	     | 0401 | 1025 |
| Basque (Basque)               | eu-ES	     | 042D | 1069 |
| Bulgarian (Bulgaria)          | bg-BG	     | 0402 | 1026 |
| Catalan	                      | ca-ES	     | 0403 | 1027 |
| Chinese (Simplified, China)   | zh-CN	     | 0804 | 2052 |
| Chinese (Traditional, Taiwan) | zh-TW	     | 0404 | 1028 |
| Croatian (Croatia)            | hr-HR	     | 041A | 1050 |
| Czech (Czech Republic)        | cs-CZ	     | 0405 | 1029 |
| Danish (Denmark)              | da-DK	     | 0406 | 1030 |
| Dutch (Netherlands)           | nl-NL	     | 0413 | 1043 |
| English (United States)       | en-US	     | 0409 | 1033 |
| English (United Kingdom)      | en-GB	     | 0809 | 2057 |
| Estonian (Estonia)            | et-EE	     | 0425 | 1061 |
| Finnish (Finland)             | fi-FI	     | 040B | 1035 |
| French (Canada)               | fr-CA	     | 0C0C | 3084 |
| French (France)               | fr-FR	     | 040C | 1036 |
| Galician	                    | gl-ES	     | 0456 | 1110 |
| German (Germany)              | de-DE	     | 0407 | 1031 |
| Greek (Greece)                | el-GR	     | 0408 | 1032 |
| Hebrew (Israel)               | he-IL	     | 040D | 1037 |
| Hungarian (Hungary)           | hu-HU	     | 040E | 1038 |
| Indonesian (Indonesia)        | id-ID	     | 0421 | 1057 |
| Italian (Italy)               | it-IT	     | 0410 | 1040 |
| Japanese (Japan)              | ja-JP	     | 0411 | 1041 |
| Korean (Korea)                | ko-KR	     | 0412 | 1042 |
| Latvian (Latvia)              | lv-LV	     | 0426 | 1062 |
| Lithuanian (Lithuania)        | lt-LT	     | 0427 | 1063 |
| Norwegian, Bokmål (Norway)    | nb-NO	     | 0414 | 1044 |
| Polish (Poland)               | pl-PL	     | 0415 | 1045 |
| Portuguese (Brazil)           | pt-BR	     | 0416 | 1046 |
| Portuguese (Portugal)         | pt-PT	     | 0816 | 2070 |
| Romanian (Romania)            | ro-RO	     | 0418 | 1048 |
| Russian (Russia)              | ru-RU	     | 0419 | 1049 |
| Serbian (Latin, Serbia)       | sr-Latn-RS | 241A | 9242 |
| Slovak (Slovakia)             | sk-SK	     | 041B | 1051 |
| Slovenian (Slovenia)          | sl-SI	     | 0424 | 1060 |
| Spanish (Mexico)              | es-MX	     | 080A | 2058 |
| Spanish (Spain)               | es-ES	     | 0C0A | 3082 |
| Swedish (Sweden)              | sv-SE	     | 041D | 1053 |
| Thai (Thailand)               | th-TH	     | 041E | 1054 |
| Turkish (Türkiye)             | tr-TR	     | 041F | 1055 |
| Ukrainian (Ukraine)           | uk-UA	     | 0422 | 1058 |
| Vietnamese	                  | vi-VN	     | 042A | 1066 |
