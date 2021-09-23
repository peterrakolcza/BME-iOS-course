import UIKit

extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}

func challenge1(input: String) -> Bool {
    let temp = input.alphanumeric
    let temp1 = temp.replacingOccurrences(of: " ", with: "").lowercased()
    let temp2 = String(temp.replacingOccurrences(of: " ", with: "").lowercased().reversed())
    
    if temp1 == temp2 {
        return true
    } else {
        return false
    }
}

let test = ["A cápa ette apáca.",
            "Adna bele fele banda.",
            "Adósom a mosoda.",
            "A fasori pap papirosa fa.",
            "A fedeled e fa.",
            "Agárd a drága!",
            "Ah, tán nátha?",
            "Aj, ah, én görög Gé-rokka lennék kénnel! Akkor ég Görögné haja.",
            "Aj, rakat almát kész sörös széktámla takarja.",
            "A jogsi is gólya.",
            "A jó csak téved, de vét kacsója",
            "A jós icipici sója.",
            "Aki takarít rám az a mártír, a Katika.",
            "Akit a kanócra ma nyálaz, az a lány a marcona Katika.",
            "Akire rábízna: Zanzibár Erika.",
            "A kólanyalóka.",
            "A kultúra rút luka.",
            "A Kupa apuka.",
            "A kupa éléről lelocsol e lőré lé, Apuka",
            "Alább az a laza kazal a zabbála."]

for sentence in test {
    print(challenge1(input: sentence))
}
