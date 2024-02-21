class Language {
  [String]$HexValue
  [String]$DecValue
  [String]$RegionID
  [String]$LanguageCode
  [String]$Name
}

$Lang_English = [Language]@{
  HexValue = "0409"
  DecValue = "1033"
  LanguageCode = "en-US"
  Name = "English (USA)"
}

$Lang_French = [Language]@{
  HexValue = "040C"
  DecValue = "1036"
  LanguageCode = "fr-FR"
  Name = "French (France)"
}

$Lang_Chinese = [Language]@{
  HexValue = "0804"
  DecValue = "2052"
  RegionID = "0x0804"
  LanguageCode = "zh-CN"
  Name = "Chinese (Simplified, China)"
}

$Lang_Czech = [Language]@{
  HexValue = "0405"
  DecValue = "1029"
  LanguageCode = "cs-CZ"
  Name = "Czech (Czech Republic)"
}

$Lang_Danish = [Language]@{
  HexValue = "0406"
  DecValue = "1030"
  LanguageCode = "da-DK"
  Name = "Danish (Denmark)"
}

$Lang_German = [Language]@{
  HexValue = "0407"
  DecValue = "1031"
  LanguageCode = "de-DE"
  Name = "German (Germany)"
}

$Lang_Greek = [Language]@{
  HexValue = "0408"
  DecValue = "1032"
  LanguageCode = "el-GR"
  Name = "Greek (Greece)"
}
