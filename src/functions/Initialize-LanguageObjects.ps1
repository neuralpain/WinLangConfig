class Language {
  [String]$Name
  [String]$LanguageCode
  [String]$HexValue
  [String]$DecValue
}

$LanguageObjectList = @(
  $Lang_Arabic = [Language]@{
    Name         = "Arabic (Saudi Arabia)"
    LanguageCode = "ar-SA"
    HexValue     = "0401"
    DecValue     = "1025"
  }
  
  $Lang_Basque = [Language]@{
    Name         = "Basque (Basque)"
    LanguageCode = "eu-ES"
    HexValue     = "042D"
    DecValue     = "1069"
  }
  
  $Lang_Bulgarian = [Language]@{
    Name         = "Bulgarian (Bulgaria)"
    LanguageCode = "bg-BG"
    HexValue     = "0402"
    DecValue     = "1026"
  }
  
  $Lang_Catalan = [Language]@{
    Name         = "Catalan"
    LanguageCode = "ca-ES"
    HexValue     = "0403"
    DecValue     = "1027"
  }
  
  $Lang_Chinese = [Language]@{
    Name         = "Chinese (Simplified, China)"
    LanguageCode = "zh-CN"
    HexValue     = "0804"
    DecValue     = "2052"
  }
  
  $Lang_ChineseTraditional = [Language]@{
    Name         = "Chinese (Traditional, Taiwan)"
    LanguageCode = "zh-TW"
    HexValue     = "0404"
    DecValue     = "1028"
  }
  
  $Lang_Croatian = [Language]@{
    Name         = "Croatian (Croatia)"
    LanguageCode = "hr-HR"
    HexValue     = "041A"
    DecValue     = "1050"
  }
  
  $Lang_Czech = [Language]@{
    Name         = "Czech (Czech Republic)"
    LanguageCode = "cs-CZ"
    HexValue     = "0405"
    DecValue     = "1029"
  }
  
  $Lang_Danish = [Language]@{
    Name         = "Danish (Denmark)"
    LanguageCode = "da-DK"
    HexValue     = "0406"
    DecValue     = "1030"
  }
  
  $Lang_Dutch = [Language]@{
    Name         = "Dutch (Netherlands)"
    LanguageCode = "nl-NL"
    HexValue     = "0413"
    DecValue     = "1043"
  }
  
  $Lang_English = [Language]@{
    Name         = "English (United States)"
    LanguageCode = "en-US"
    HexValue     = "0409"
    DecValue     = "1033"
  }
  
  $Lang_EnglishUK = [Language]@{
    Name         = "English (United Kingdom)"
    LanguageCode = "en-GB"
    HexValue     = "0809"
    DecValue     = "2057"
  }
  
  $Lang_Estonian = [Language]@{
    Name         = "Estonian (Estonia)"
    LanguageCode = "et-EE"
    HexValue     = "0425"
    DecValue     = "1061"
  }
  
  $Lang_Finnish = [Language]@{
    Name         = "Finnish (Finland)"
    LanguageCode = "fi-FI"
    HexValue     = "040B"
    DecValue     = "1035"
  }
  
  $Lang_FrenchCA = [Language]@{
    Name         = "French (Canada)"
    LanguageCode = "fr-CA"
    HexValue     = "0C0C"
    DecValue     = "3084"
  }
  
  $Lang_French = [Language]@{
    Name         = "French (France)"
    LanguageCode = "fr-FR"
    HexValue     = "040C"
    DecValue     = "1036"
  }
  
  $Lang_Galician = [Language]@{
    Name         = "Galician"
    LanguageCode = "gl-ES"
    HexValue     = "0456"
    DecValue     = "1110"
  }
  
  $Lang_German = [Language]@{
    Name         = "German (Germany)"
    LanguageCode = "de-DE"
    HexValue     = "0407"
    DecValue     = "1031"
  }
  
  $Lang_Greek = [Language]@{
    Name         = "Greek (Greece)"
    LanguageCode = "el-GR"
    HexValue     = "0408"
    DecValue     = "1032"
  }
  
  $Lang_Hebrew = [Language]@{
    Name         = "Hebrew (Israel)"
    LanguageCode = "he-IL"
    HexValue     = "040D"
    DecValue     = "1037"
  }
  
  $Lang_Hungarian = [Language]@{
    Name         = "Hungarian (Hungary)"
    LanguageCode = "hu-HU"
    HexValue     = "040E"
    DecValue     = "1038"
  }
  
  $Lang_Indonesian = [Language]@{
    Name         = "Indonesian (Indonesia)"
    LanguageCode = "id-ID"
    HexValue     = "0421"
    DecValue     = "1057"
  }
  
  $Lang_Italian = [Language]@{
    Name         = "Italian (Italy)"
    LanguageCode = "it-IT"
    HexValue     = "0410"
    DecValue     = "1040"
  }
  
  $Lang_Japanese = [Language]@{
    Name         = "Japanese (Japan)"
    LanguageCode = "ja-JP"
    HexValue     = "0411"
    DecValue     = "1041"
  }
  
  $Lang_Korean = [Language]@{
    Name         = "Korean (Korea)"
    LanguageCode = "ko-KR"
    HexValue     = "0412"
    DecValue     = "1042"
  }
  
  $Lang_Latvian = [Language]@{
    Name         = "Latvian (Latvia)"
    LanguageCode = "lv-LV"
    HexValue     = "0426"
    DecValue     = "1062"
  }
  
  $Lang_Lithuanian = [Language]@{
    Name         = "Lithuanian (Lithuania)"
    LanguageCode = "lt-LT"
    HexValue     = "0427"
    DecValue     = "1063"
  }
  
  $Lang_Norwegian = [Language]@{
    Name         = "Norwegian, Bokmål (Norway)"
    LanguageCode = "nb-NO"
    HexValue     = "0414"
    DecValue     = "1044"
  }
  
  $Lang_Polish = [Language]@{
    Name         = "Polish (Poland)"
    LanguageCode = "pl-PL"
    HexValue     = "0415"
    DecValue     = "1045"
  }
  
  $Lang_PortugueseBRA = [Language]@{
    Name         = "Portuguese (Brazil)"
    LanguageCode = "pt-BR"
    HexValue     = "0416"
    DecValue     = "1046"
  }
  
  $Lang_Portuguese = [Language]@{
    Name         = "Portuguese (Portugal)"
    LanguageCode = "pt-PT"
    HexValue     = "0816"
    DecValue     = "2070"
  }
  
  $Lang_Romanian = [Language]@{
    Name         = "Romanian (Romania)"
    LanguageCode = "ro-RO"
    HexValue     = "0418"
    DecValue     = "1048"
  }
  
  $Lang_Russian = [Language]@{
    Name         = "Russian (Russia)"
    LanguageCode = "ru-RU"
    HexValue     = "0419"
    DecValue     = "1049"
  }
  
  $Lang_Serbian = [Language]@{
    Name         = "Serbian (Latin, Serbia)"
    LanguageCode = "sr-Latn-RS"
    HexValue     = "241A"
    DecValue     = "9242"
  }
  
  $Lang_Slovak = [Language]@{
    Name         = "Slovak (Slovakia)"
    LanguageCode = "sk-SK"
    HexValue     = "041B"
    DecValue     = "1051"
  }
  
  $Lang_Slovenian = [Language]@{
    Name         = "Slovenian (Slovenia)"
    LanguageCode = "sl-SI"
    HexValue     = "0424"
    DecValue     = "1060"
  }
  
  $Lang_SpanishMEX = [Language]@{
    Name         = "Spanish (Mexico)"
    LanguageCode = "es-MX"
    HexValue     = "080A"
    DecValue     = "2058"
  }
  
  $Lang_Spanish = [Language]@{
    Name         = "Spanish (Spain)"
    LanguageCode = "es-ES"
    HexValue     = "0C0A"
    DecValue     = "3082"
  }
  
  $Lang_Swedish = [Language]@{
    Name         = "Swedish (Sweden)"
    LanguageCode = "sv-SE"
    HexValue     = "041D"
    DecValue     = "1053"
  }
  
  $Lang_Thai = [Language]@{
    Name         = "Thai (Thailand)"
    LanguageCode = "th-TH"
    HexValue     = "041E"
    DecValue     = "1054"
  }
  
  $Lang_Turkish = [Language]@{
    Name         = "Turkish (Türkiye)"
    LanguageCode = "tr-TR"
    HexValue     = "041F"
    DecValue     = "1055"
  }
  
  $Lang_Ukrainian = [Language]@{
    Name         = "Ukrainian (Ukraine)"
    LanguageCode = "uk-UA"
    HexValue     = "0422"
    DecValue     = "1058"
  }
  
  $Lang_Vietnamese = [Language]@{
    Name         = "Vietnamese"
    LanguageCode = "vi-VN"
    HexValue     = "042A"
    DecValue     = "1066"
  }
)