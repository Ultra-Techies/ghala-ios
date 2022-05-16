//
//  extensions.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation
import SwiftUI


struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Color {
    static let buttonColor = Color("buttonColor")
}


//Passing x-www-form-urlencoded Data

extension Dictionary {
  func percentEncoded() -> Data? {
    return map { key, value in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
    }
    .joined(separator: "&")
    .data(using: .utf8)
  }
}

extension CharacterSet {
  static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}






let flags: [String: String] = [
  "AD": "🇦🇩", "AE": "🇦🇪", "AF": "🇦🇫", "AG": "🇦🇬", "AI": "🇦🇮", "AL": "🇦🇱", "AM": "🇦🇲", "AO": "🇦🇴", "AQ": "🇦🇶", "AR": "🇦🇷", "AS": "🇦🇸", "AT": "🇦🇹", "AU": "🇦🇺", "AW": "🇦🇼", "AX": "🇦🇽", "AZ": "🇦🇿", "BA": "🇧🇦", "BB": "🇧🇧", "BD": "🇧🇩", "BE": "🇧🇪", "BF": "🇧🇫", "BG": "🇧🇬", "BH": "🇧🇭", "BI": "🇧🇮", "BJ": "🇧🇯", "BL": "🇧🇱", "BM": "🇧🇲", "BN": "🇧🇳", "BO": "🇧🇴", "BQ": "🇧🇶", "BR": "🇧🇷", "BS": "🇧🇸", "BT": "🇧🇹", "BV": "🇧🇻", "BW": "🇧🇼", "BY": "🇧🇾", "BZ": "🇧🇿", "CA": "🇨🇦", "CC": "🇨🇨", "CD": "🇨🇩", "CF": "🇨🇫", "CG": "🇨🇬", "CH": "🇨🇭", "CI": "🇨🇮", "CK": "🇨🇰", "CL": "🇨🇱", "CM": "🇨🇲", "CN": "🇨🇳", "CO": "🇨🇴", "CR": "🇨🇷", "CU": "🇨🇺", "CV": "🇨🇻", "CW": "🇨🇼", "CX": "🇨🇽", "CY": "🇨🇾", "CZ": "🇨🇿", "DE": "🇩🇪", "DJ": "🇩🇯", "DK": "🇩🇰", "DM": "🇩🇲", "DO": "🇩🇴", "DZ": "🇩🇿", "EC": "🇪🇨", "EE": "🇪🇪", "EG": "🇪🇬", "EH": "🇪🇭", "ER": "🇪🇷", "ES": "🇪🇸", "ET": "🇪🇹", "FI": "🇫🇮", "FJ": "🇫🇯", "FK": "🇫🇰", "FM": "🇫🇲", "FO": "🇫🇴", "FR": "🇫🇷", "GA": "🇬🇦", "GB": "🇬🇧", "GD": "🇬🇩", "GE": "🇬🇪", "GF": "🇬🇫", "GG": "🇬🇬", "GH": "🇬🇭", "GI": "🇬🇮", "GL": "🇬🇱", "GM": "🇬🇲", "GN": "🇬🇳", "GP": "🇬🇵", "GQ": "🇬🇶", "GR": "🇬🇷", "GS": "🇬🇸", "GT": "🇬🇹", "GU": "🇬🇺", "GW": "🇬🇼", "GY": "🇬🇾", "HK": "🇭🇰", "HM": "🇭🇲", "HN": "🇭🇳", "HR": "🇭🇷", "HT": "🇭🇹", "HU": "🇭🇺", "ID": "🇮🇩", "IE": "🇮🇪", "IL": "🇮🇱", "IM": "🇮🇲", "IN": "🇮🇳", "IO": "🇮🇴", "IQ": "🇮🇶", "IR": "🇮🇷", "IS": "🇮🇸", "IT": "🇮🇹", "JE": "🇯🇪", "JM": "🇯🇲", "JO": "🇯🇴", "JP": "🇯🇵", "KE": "🇰🇪", "KG": "🇰🇬", "KH": "🇰🇭", "KI": "🇰🇮", "KM": "🇰🇲", "KN": "🇰🇳", "KP": "🇰🇵", "KR": "🇰🇷", "KW": "🇰🇼", "KY": "🇰🇾", "KZ": "🇰🇿", "LA": "🇱🇦", "LB": "🇱🇧", "LC": "🇱🇨", "LI": "🇱🇮", "LK": "🇱🇰", "LR": "🇱🇷", "LS": "🇱🇸", "LT": "🇱🇹", "LU": "🇱🇺", "LV": "🇱🇻", "LY": "🇱🇾", "MA": "🇲🇦", "MC": "🇲🇨", "MD": "🇲🇩", "ME": "🇲🇪", "MF": "🇲🇫", "MG": "🇲🇬", "MH": "🇲🇭", "MK": "🇲🇰", "ML": "🇲🇱", "MM": "🇲🇲", "MN": "🇲🇳", "MO": "🇲🇴", "MP": "🇲🇵", "MQ": "🇲🇶", "MR": "🇲🇷", "MS": "🇲🇸", "MT": "🇲🇹", "MU": "🇲🇺", "MV": "🇲🇻", "MW": "🇲🇼", "MX": "🇲🇽", "MY": "🇲🇾", "MZ": "🇲🇿", "NA": "🇳🇦", "NC": "🇳🇨", "NE": "🇳🇪", "NF": "🇳🇫", "NG": "🇳🇬", "NI": "🇳🇮", "NL": "🇳🇱", "NO": "🇳🇴", "NP": "🇳🇵", "NR": "🇳🇷", "NU": "🇳🇺", "NZ": "🇳🇿", "OM": "🇴🇲", "PA": "🇵🇦", "PE": "🇵🇪", "PF": "🇵🇫", "PG": "🇵🇬", "PH": "🇵🇭", "PK": "🇵🇰", "PL": "🇵🇱", "PM": "🇵🇲", "PN": "🇵🇳", "PR": "🇵🇷", "PS": "🇵🇸", "PT": "🇵🇹", "PW": "🇵🇼", "PY": "🇵🇾", "QA": "🇶🇦", "RE": "🇷🇪", "RO": "🇷🇴", "RS": "🇷🇸", "RU": "🇷🇺", "RW": "🇷🇼", "SA": "🇸🇦", "SB": "🇸🇧", "SC": "🇸🇨", "SD": "🇸🇩", "SE": "🇸🇪", "SG": "🇸🇬", "SH": "🇸🇭", "SI": "🇸🇮", "SJ": "🇸🇯", "SK": "🇸🇰", "SL": "🇸🇱", "SM": "🇸🇲", "SN": "🇸🇳", "SO": "🇸🇴", "SR": "🇸🇷", "SS": "🇸🇸", "ST": "🇸🇹", "SV": "🇸🇻", "SX": "🇸🇽", "SY": "🇸🇾", "SZ": "🇸🇿", "TC": "🇹🇨", "TD": "🇹🇩", "TF": "🇹🇫", "TG": "🇹🇬", "TH": "🇹🇭", "TJ": "🇹🇯", "TK": "🇹🇰", "TL": "🇹🇱", "TM": "🇹🇲", "TN": "🇹🇳", "TO": "🇹🇴", "TR": "🇹🇷", "TT": "🇹🇹", "TV": "🇹🇻", "TW": "🇹🇼", "TZ": "🇹🇿", "UA": "🇺🇦", "UG": "🇺🇬", "UM": "🇺🇲", "US": "🇺🇸", "UY": "🇺🇾", "UZ": "🇺🇿", "VA": "🇻🇦", "VC": "🇻🇨", "VE": "🇻🇪", "VG": "🇻🇬", "VI": "🇻🇮", "VN": "🇻🇳", "VU": "🇻🇺", "WF": "🇼🇫", "WS": "🇼🇸", "YE": "🇾🇪", "YT": "🇾🇹", "ZA": "🇿🇦", "ZM": "🇿🇲", "ZW": "🇿🇼"
]


let flag  = ["AD 🇦🇩", "AE 🇦🇪", "AF 🇦🇫", "AG 🇦🇬", "AI 🇦🇮", "AL 🇦🇱", "AM 🇦🇲", "AO 🇦🇴", "AQ 🇦🇶", "AR 🇦🇷", "AS 🇦🇸", "AT 🇦🇹", "AU 🇦🇺", "AW 🇦🇼", "AX 🇦🇽", "AZ 🇦🇿", "BA 🇧🇦", "BB 🇧🇧", "BD 🇧🇩", "BE 🇧🇪", "BF 🇧🇫", "BG 🇧🇬", "BH 🇧🇭", "BI 🇧🇮", "BJ 🇧🇯", "BL 🇧🇱", "BM 🇧🇲", "BN 🇧🇳", "BO 🇧🇴", "BQ 🇧🇶", "BR 🇧🇷", "BS 🇧🇸", "BT 🇧🇹", "BV 🇧🇻", "BW 🇧🇼", "BY 🇧🇾", "BZ 🇧🇿", "CA 🇨🇦", "CC 🇨🇨", "CD 🇨🇩", "CF 🇨🇫", "CG 🇨🇬", "CH 🇨🇭", "CI 🇨🇮", "CK 🇨🇰", "CL 🇨🇱", "CM 🇨🇲", "CN 🇨🇳", "CO 🇨🇴", "CR 🇨🇷", "CU 🇨🇺", "CV 🇨🇻", "CW 🇨🇼", "CX 🇨🇽", "CY 🇨🇾", "CZ 🇨🇿", "DE 🇩🇪", "DJ 🇩🇯", "DK 🇩🇰", "DM 🇩🇲", "DO 🇩🇴", "DZ 🇩🇿", "EC 🇪🇨", "EE 🇪🇪", "EG 🇪🇬", "EH 🇪🇭", "ER 🇪🇷", "ES 🇪🇸", "ET 🇪🇹", "FI 🇫🇮", "FJ 🇫🇯", "FK 🇫🇰", "FM 🇫🇲", "FO 🇫🇴", "FR 🇫🇷", "GA 🇬🇦", "GB 🇬🇧", "GD 🇬🇩", "GE 🇬🇪", "GF 🇬🇫", "GG 🇬🇬", "GH 🇬🇭", "GI 🇬🇮", "GL 🇬🇱", "GM 🇬🇲", "GN 🇬🇳", "GP 🇬🇵", "GQ 🇬🇶","GR 🇬🇷", "GS 🇬🇸", "GT 🇬🇹", "GU 🇬🇺", "GW 🇬🇼", "GY 🇬🇾", "HK 🇭🇰", "HM 🇭🇲", "HN 🇭🇳", "HR 🇭🇷", "HT 🇭🇹", "HU 🇭🇺", "ID 🇮🇩", "IE 🇮🇪", "IL 🇮🇱", "IM 🇮🇲", "IN 🇮🇳", "IO 🇮🇴", "IQ 🇮🇶", "IR 🇮🇷", "IS 🇮🇸", "IT 🇮🇹", "JE 🇯🇪", "JM 🇯🇲", "JO 🇯🇴", "JP 🇯🇵", "KE 🇰🇪", "KG 🇰🇬", "KH 🇰🇭", "KI 🇰🇮", "KM 🇰🇲", "KN 🇰🇳", "KP 🇰🇵", "KR 🇰🇷", "KW 🇰🇼", "KY 🇰🇾", "KZ 🇰🇿", "LA 🇱🇦", "LB 🇱🇧", "LC 🇱🇨", "LI 🇱🇮", "LK 🇱🇰", "LR 🇱🇷", "LS 🇱🇸", "LT 🇱🇹", "LU 🇱🇺", "LV 🇱🇻", "LY 🇱🇾", "MA 🇲🇦", "MC 🇲🇨", "MD 🇲🇩", "ME 🇲🇪", "MF 🇲🇫", "MG 🇲🇬", "MH 🇲🇭", "MK 🇲🇰", "ML 🇲🇱", "MM 🇲🇲", "MN 🇲🇳", "MO 🇲🇴", "MP 🇲🇵", "MQ 🇲🇶", "MR 🇲🇷", "MS 🇲🇸", "MT 🇲🇹", "MU 🇲🇺", "MV 🇲🇻", "MW 🇲🇼", "MX 🇲🇽", "MY 🇲🇾", "MZ 🇲🇿", "NA 🇳🇦", "NC 🇳🇨", "NE 🇳🇪", "NF 🇳🇫", "NG 🇳🇬", "NI 🇳🇮", "NL 🇳🇱", "NO 🇳🇴", "NP 🇳🇵", "NR 🇳🇷", "NU 🇳🇺", "NZ 🇳🇿", "OM 🇴🇲", "PA 🇵🇦", "PE 🇵🇪", "PF 🇵🇫", "PG 🇵🇬", "PH 🇵🇭", "PK 🇵🇰", "PL 🇵🇱", "PM 🇵🇲", "PN 🇵🇳", "PR 🇵🇷", "PS 🇵🇸", "PT 🇵🇹", "PW 🇵🇼", "PY 🇵🇾", "QA 🇶🇦", "RE 🇷🇪", "RO 🇷🇴", "RS 🇷🇸", "RU 🇷🇺", "RW 🇷🇼", "SA 🇸🇦", "SB 🇸🇧", "SC 🇸🇨", "SD 🇸🇩", "SE 🇸🇪", "SG 🇸🇬", "SH 🇸🇭", "SI 🇸🇮", "SJ 🇸🇯", "SK 🇸🇰", "SL 🇸🇱", "SM 🇸🇲", "SN 🇸🇳", "SO 🇸🇴", "SR 🇸🇷", "SS 🇸🇸", "ST 🇸🇹", "SV 🇸🇻", "SX 🇸🇽", "SY 🇸🇾", "SZ 🇸🇿", "TC 🇹🇨", "TD 🇹🇩", "TF 🇹🇫", "TG 🇹🇬", "TH 🇹🇭", "TJ 🇹🇯", "TK 🇹🇰", "TL 🇹🇱", "TM 🇹🇲", "TN 🇹🇳", "TO 🇹🇴", "TR 🇹🇷", "TT 🇹🇹", "TV 🇹🇻", "TW 🇹🇼", "TZ 🇹🇿", "UA 🇺🇦", "UG 🇺🇬", "UM 🇺🇲", "US 🇺🇸", "UY 🇺🇾", "UZ 🇺🇿", "VA 🇻🇦", "VC 🇻🇨", "VE 🇻🇪", "VG 🇻🇬", "VI 🇻🇮", "VN 🇻🇳", "VU 🇻🇺", "WF 🇼🇫", "WS 🇼🇸", "YE 🇾🇪", "YT 🇾🇹", "ZA 🇿🇦", "ZM 🇿🇲", "ZW 🇿🇼"
]

/*

"AD 🇦🇩", "AE 🇦🇪", "AF 🇦🇫", "AG 🇦🇬", "AI 🇦🇮", "AL 🇦🇱", "AM 🇦🇲", "AO 🇦🇴", "AQ 🇦🇶", "AR 🇦🇷", "AS 🇦🇸", "AT 🇦🇹", "AU 🇦🇺", "AW 🇦🇼", "AX 🇦🇽", "AZ 🇦🇿", "BA 🇧🇦", "BB 🇧🇧", "BD 🇧🇩", "BE 🇧🇪", "BF 🇧🇫", "BG 🇧🇬", "BH 🇧🇭", "BI 🇧🇮", "BJ 🇧🇯", "BL 🇧🇱", "BM 🇧🇲", "BN 🇧🇳", "BO 🇧🇴", "BQ 🇧🇶", "BR 🇧🇷", "BS 🇧🇸", "BT 🇧🇹", "BV 🇧🇻", "BW 🇧🇼", "BY 🇧🇾", "BZ 🇧🇿", "CA 🇨🇦", "CC 🇨🇨", "CD 🇨🇩", "CF 🇨🇫", "CG 🇨🇬", "CH 🇨🇭", "CI 🇨🇮", "CK 🇨🇰", "CL 🇨🇱", "CM 🇨🇲", "CN 🇨🇳", "CO 🇨🇴", "CR 🇨🇷", "CU 🇨🇺", "CV 🇨🇻", "CW 🇨🇼", "CX 🇨🇽", "CY 🇨🇾", "CZ 🇨🇿", "DE 🇩🇪", "DJ 🇩🇯", "DK 🇩🇰", "DM 🇩🇲", "DO 🇩🇴", "DZ 🇩🇿", "EC 🇪🇨", "EE 🇪🇪", "EG 🇪🇬", "EH 🇪🇭", "ER 🇪🇷", "ES 🇪🇸", "ET 🇪🇹", "FI 🇫🇮", "FJ 🇫🇯", "FK 🇫🇰", "FM 🇫🇲", "FO 🇫🇴", "FR 🇫🇷", "GA 🇬🇦", "GB 🇬🇧", "GD 🇬🇩", "GE 🇬🇪", "GF 🇬🇫", "GG 🇬🇬", "GH 🇬🇭", "GI 🇬🇮", "GL 🇬🇱", "GM 🇬🇲", "GN 🇬🇳", "GP 🇬🇵", "GQ 🇬🇶","GR 🇬🇷", "GS 🇬🇸", "GT 🇬🇹", "GU 🇬🇺", "GW 🇬🇼", "GY 🇬🇾", "HK 🇭🇰", "HM 🇭🇲", "HN 🇭🇳", "HR 🇭🇷", "HT 🇭🇹", "HU 🇭🇺", "ID 🇮🇩", "IE 🇮🇪", "IL 🇮🇱", "IM 🇮🇲", "IN 🇮🇳", "IO 🇮🇴", "IQ 🇮🇶", "IR 🇮🇷", "IS 🇮🇸", "IT 🇮🇹", "JE 🇯🇪", "JM 🇯🇲", "JO 🇯🇴", "JP 🇯🇵", "KE 🇰🇪", "KG 🇰🇬", "KH 🇰🇭", "KI 🇰🇮", "KM 🇰🇲", "KN 🇰🇳", "KP 🇰🇵", "KR 🇰🇷", "KW 🇰🇼", "KY 🇰🇾", "KZ 🇰🇿", "LA 🇱🇦", "LB 🇱🇧", "LC 🇱🇨", "LI 🇱🇮", "LK 🇱🇰", "LR 🇱🇷", "LS 🇱🇸", "LT 🇱🇹", "LU 🇱🇺", "LV 🇱🇻", "LY 🇱🇾", "MA 🇲🇦", "MC 🇲🇨", "MD 🇲🇩", "ME 🇲🇪", "MF 🇲🇫", "MG 🇲🇬", "MH 🇲🇭", "MK 🇲🇰", "ML 🇲🇱", "MM 🇲🇲", "MN 🇲🇳", "MO 🇲🇴", "MP 🇲🇵", "MQ 🇲🇶", "MR 🇲🇷", "MS 🇲🇸", "MT 🇲🇹", "MU 🇲🇺", "MV 🇲🇻", "MW 🇲🇼", "MX 🇲🇽", "MY 🇲🇾", "MZ 🇲🇿", "NA 🇳🇦", "NC 🇳🇨", "NE 🇳🇪", "NF 🇳🇫", "NG 🇳🇬", "NI 🇳🇮", "NL 🇳🇱", "NO 🇳🇴", "NP 🇳🇵", "NR 🇳🇷", "NU 🇳🇺", "NZ 🇳🇿", "OM 🇴🇲", "PA 🇵🇦", "PE 🇵🇪", "PF 🇵🇫", "PG 🇵🇬", "PH 🇵🇭", "PK 🇵🇰", "PL 🇵🇱", "PM 🇵🇲", "PN 🇵🇳", "PR 🇵🇷", "PS 🇵🇸", "PT 🇵🇹", "PW 🇵🇼", "PY 🇵🇾", "QA 🇶🇦", "RE 🇷🇪", "RO 🇷🇴", "RS 🇷🇸", "RU 🇷🇺", "RW 🇷🇼", "SA 🇸🇦", "SB 🇸🇧", "SC 🇸🇨", "SD 🇸🇩", "SE 🇸🇪", "SG 🇸🇬", "SH 🇸🇭", "SI 🇸🇮", "SJ 🇸🇯", "SK 🇸🇰", "SL 🇸🇱", "SM 🇸🇲", "SN 🇸🇳", "SO 🇸🇴", "SR 🇸🇷", "SS 🇸🇸", "ST 🇸🇹", "SV 🇸🇻", "SX 🇸🇽", "SY 🇸🇾", "SZ 🇸🇿", "TC 🇹🇨", "TD 🇹🇩", "TF 🇹🇫", "TG 🇹🇬", "TH 🇹🇭", "TJ 🇹🇯", "TK 🇹🇰", "TL 🇹🇱", "TM 🇹🇲", "TN 🇹🇳", "TO 🇹🇴", "TR 🇹🇷", "TT 🇹🇹", "TV 🇹🇻", "TW 🇹🇼", "TZ 🇹🇿", "UA 🇺🇦", "UG 🇺🇬", "UM 🇺🇲", "US 🇺🇸", "UY 🇺🇾", "UZ 🇺🇿", "VA 🇻🇦", "VC 🇻🇨", "VE 🇻🇪", "VG 🇻🇬", "VI 🇻🇮", "VN 🇻🇳", "VU 🇻🇺", "WF 🇼🇫", "WS 🇼🇸", "YE 🇾🇪", "YT 🇾🇹", "ZA 🇿🇦", "ZM 🇿🇲", "ZW 🇿🇼"
*/
