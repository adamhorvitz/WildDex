//
//  SettingsView.swift
//  WildDex
//
//  Created by Lexline Johnson on 12/3/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var locationManager: LocationManager
//    @EnvironmentObject var speciesData: SpeciesData
    @Binding var useCurrentLocation: Bool
    @Binding var country: String
    @State var countrySelection: Country
    
    init(useCurrentLocation: Binding<Bool>, country: Binding<String>) {
        self._useCurrentLocation = useCurrentLocation
        self._country = country
        self.countrySelection = Country(rawValue: country.wrappedValue) ?? .unitedStatesOfAmerica
//        if let loadedCountry = speciesData.country {
//            self.country = loadedCountry
//            self.countrySelection = Country(rawValue: loadedCountry) ?? self.countrySelection
//        }
        print("COUNTRY SELECTION:", countrySelection.rawValue, country.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $useCurrentLocation) {
                    Text("Use Current Location")
                }
                .onReceive([self.useCurrentLocation].publisher.first()) { useCurrentLocation in
                    UserDefaults.standard.set(useCurrentLocation, forKey: "useCurrentLocation")
                    if useCurrentLocation {
                        if let currentLocation = locationManager.location?.isoCountryCode {
                            self.country = currentLocation
                            self.countrySelection = Country(rawValue: currentLocation) ?? self.countrySelection
                        }
                    }
                }
                Picker("Country", selection: $countrySelection) {
                    ForEach(Country.allCases) { countrySelection in
                        Text(Locale.current.localizedString(forRegionCode: countrySelection.rawValue) ?? "US")
                    }
                }
                .disabled(useCurrentLocation)
                .onReceive([self.countrySelection].publisher.first()) { countrySelection in
                    country = countrySelection.rawValue
                    UserDefaults.standard.set(countrySelection.rawValue, forKey: "country")
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    enum Country: String, CaseIterable, Identifiable {
        var id: Self { self }
        case afghanistan = "AF"
        case albania = "AL"
        case algeria = "DZ"
        case americanSamoa = "AS"
        case andorra = "AD"
        case angola = "AO"
        case anguilla = "AI"
        case antarctica = "AQ"
        case antiguaAndBarbuda = "AG"
        case argentina = "AR"
        case armenia = "AM"
        case aruba = "AW"
        case australia = "AU"
        case austria = "AT"
        case azerbaijan = "AZ"
        case bahamas = "BS"
        case bahrain = "BH"
        case bangladesh = "BD"
        case barbados = "BB"
        case belarus = "BY"
        case belgium = "BE"
        case belize = "BZ"
        case benin = "BJ"
        case bermuda = "BM"
        case bhutan = "BT"
        case bolivia = "BO"
        case bonaireSintEustatiusAndSaba = "BQ"
        case bosniaAndHerzegovina = "BA"
        case botswana = "BW"
        case bouvetIsland = "BV"
        case brazil = "BR"
        case britishIndianOceanTerritory = "IO"
        case bruneiDarussalam = "BN"
        case bulgaria = "BG"
        case burkinaFaso = "BF"
        case burundi = "BI"
        case caboVerde = "CV"
        case cambodia = "KH"
        case cameroon = "CM"
        case canada = "CA"
        case caymanIslands = "KY"
        case centralAfricanRepublic = "CF"
        case chad = "TD"
        case chile = "CL"
        case china = "CN"
        case christmasIsland = "CX"
        case cocosIslands = "CC"
        case colombia = "CO"
        case comoros = "KM"
        case democraticRepublicOfTheCongo = "CD"
        case congo = "CG"
        case cookIslands = "CK"
        case costaRica = "CR"
        case croatia = "HR"
        case cuba = "CU"
        case curacao = "CW"
        case cyprus = "CY"
        case czechia = "CZ"
        case cotedIvoire = "CI"
        case denmark = "DK"
        case djibouti = "DJ"
        case dominica = "DM"
        case dominicanRepublic = "DO"
        case ecuador = "EC"
        case egypt = "EG"
        case elSalvador = "SV"
        case equatorialGuinea = "GQ"
        case eritrea = "ER"
        case estonia = "EE"
        case eswatini = "SZ"
        case ethiopia = "ET"
        case falklandIslands = "FK"
        case faroeIslands = "FO"
        case fiji = "FJ"
        case finland = "FI"
        case france = "FR"
        case frenchGuiana = "GF"
        case frenchPolynesia = "PF"
        case frenchSouthernTerritories = "TF"
        case gabon = "GA"
        case gambia = "GM"
        case georgia = "GE"
        case germany = "DE"
        case ghana = "GH"
        case gibraltar = "GI"
        case greece = "GR"
        case greenland = "GL"
        case grenada = "GD"
        case guadeloupe = "GP"
        case guam = "GU"
        case guatemala = "GT"
        case guernsey = "GG"
        case guinea = "GN"
        case guineaBissau = "GW"
        case guyana = "GY"
        case haiti = "HT"
        case heardIslandAndMcDonaldIslands = "HM"
        case holySee = "VA"
        case honduras = "HN"
        case hongKong = "HK"
        case hungary = "HU"
        case iceland = "IS"
        case india = "IN"
        case indonesia = "ID"
        case iran = "IR"
        case iraq = "IQ"
        case ireland = "IE"
        case isleOfMan = "IM"
        case israel = "IL"
        case italy = "IT"
        case jamaica = "JM"
        case japan = "JP"
        case jersey = "JE"
        case jordan = "JO"
        case kazakhstan = "KZ"
        case kenya = "KE"
        case kiribati = "KI"
        case democraticPeoplesRepublicOfKorea = "KP"
        case republicOfKorea = "KR"
        case kuwait = "KW"
        case kyrgyzstan = "KG"
        case laoPeoplesDemocraticRepublic = "LA"
        case latvia = "LV"
        case lebanon = "LB"
        case lesotho = "LS"
        case liberia = "LR"
        case libya = "LY"
        case liechtenstein = "LI"
        case lithuania = "LT"
        case luxembourg = "LU"
        case macao = "MO"
        case madagascar = "MG"
        case malawi = "MW"
        case malaysia = "MY"
        case maldives = "MV"
        case mali = "ML"
        case malta = "MT"
        case marshallIslands = "MH"
        case martinique = "MQ"
        case mauritania = "MR"
        case mauritius = "MU"
        case mayotte = "YT"
        case mexico = "MX"
        case micronesia = "FM"
        case moldova = "MD"
        case monaco = "MC"
        case mongolia = "MN"
        case montenegro = "ME"
        case montserrat = "MS"
        case morocco = "MA"
        case mozambique = "MZ"
        case myanmar = "MM"
        case Namibia = "NA"
        case nauru = "NR"
        case nepal = "NP"
        case netherlands = "NL"
        case newCaledonia = "NC"
        case newZealand = "NZ"
        case nicaragua = "NI"
        case niger = "NE"
        case nigeria = "NG"
        case niue = "NU"
        case norfolkIsland = "NF"
        case northernMarianaIslands = "MP"
        case norway = "NO"
        case oman = "OM"
        case pakistan = "PK"
        case palau = "PW"
        case stateOfPalestine = "PS"
        case panama = "PA"
        case papuaNewGuinea = "PG"
        case paraguay = "PY"
        case peru = "PE"
        case philippines = "PH"
        case pitcairn = "PN"
        case poland = "PL"
        case portugal = "PT"
        case puertoRico = "PR"
        case qatar = "QA"
        case republicOfNorthMacedonia = "MK"
        case romania = "RO"
        case russianFederation = "RU"
        case rwanda = "RW"
        case reunion = "RE"
        case saintBarthelemy = "BL"
        case saintHelenaAscensionAndTristanDaCunha = "SH"
        case saintKittsAndNevis = "KN"
        case saintLucia = "LC"
        case saintMartin = "MF"
        case saintPierreAndMiquelon = "PM"
        case saintVincentAndTheGrenadines = "VC"
        case samoa = "WS"
        case sanMarino = "SM"
        case saoTomeAndPrincipe = "ST"
        case saudiArabia = "SA"
        case senegal = "SN"
        case serbia = "RS"
        case seychelles = "SC"
        case sierraLeone = "SL"
        case singapore = "SG"
        case sintMaarten = "SX"
        case slovakia = "SK"
        case slovenia = "SI"
        case solomonIslands = "SB"
        case somalia = "SO"
        case southAfrica = "ZA"
        case southGeorgiaAndTheSouthSandwichIslands = "GS"
        case southSudan = "SS"
        case spain = "ES"
        case sriLanka = "LK"
        case sudan = "SD"
        case suriname = "SR"
        case svalbardAndJanMayen = "SJ"
        case sweden = "SE"
        case switzerland = "CH"
        case syrianArabRepublic = "SY"
        case taiwan = "TW"
        case tajikistan = "TJ"
        case unitedRepublicOfTanzania = "TZ"
        case thailand = "TH"
        case timorLeste = "TL"
        case togo = "TG"
        case tokelau = "TK"
        case tonga = "TO"
        case trinidadAndTobago = "TT"
        case tunisia = "TN"
        case turkey = "TR"
        case turkmenistan = "TM"
        case turksAndCaicosIslands = "TC"
        case tuvalu = "TV"
        case uganda = "UG"
        case ukraine = "UA"
        case unitedArabEmirates = "AE"
        case unitedKingdomOfGreatBritainAndNorthernIreland = "GB"
        case unitedStatesMinorOutlyingIslands = "UM"
        case unitedStatesOfAmerica = "US"
        case uruguay = "UY"
        case uzbekistan = "UZ"
        case vanuatu = "VU"
        case venezuela = "VE"
        case vietnam = "VN"
        case virginIslandsBritish = "VG"
        case virginIslandsUS = "VI"
        case wallisAndFutuna = "WF"
        case westernSahara = "EH"
        case yemen = "YE"
        case zambia = "ZM"
        case zimbabwe = "ZW"
        case alandIslands = "AX"
    }
}

#Preview {
    SettingsView(useCurrentLocation: .constant(false), country: .constant("US"))
}
