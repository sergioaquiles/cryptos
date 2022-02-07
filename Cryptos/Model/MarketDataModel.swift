//
//  MarketDataModel.swift
//  MarketDataModel
//
//  Created by Sergio Cardoso on 27/08/21.
//

import Foundation
import SwiftUI

/*
 URL: https://api.coingecko.com/api/v3/global
 JSON Rsponse:
 
 {
   "data": {
     "active_cryptocurrencies": 9123,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 639,
     "total_market_cap": {
       "btc": 44692429.32351082,
       "eth": 665257991.6561852,
       "ltc": 12385284156.279758,
       "bch": 3455870575.894907,
       "bnb": 4413344643.16166,
       "eos": 434268313032.6532,
       "xrp": 1891813627658.3772,
       "xlm": 6153018491292.371,
       "link": 83892411300.77534,
       "dot": 83188089519.36812,
       "yfi": 57072344.077254035,
       "usd": 2158627525344.6038,
       "aed": 7928658328238.456,
       "ars": 210588726847085.22,
       "aud": 2950977662052.643,
       "bdt": 184227092609521.44,
       "bhd": 813806894309.966,
       "bmd": 2158627525344.6038,
       "brl": 11224863131791.938,
       "cad": 2721483176695.632,
       "chf": 1965944115177.2952,
       "clp": 1691630046511549.8,
       "cny": 13970205618525.213,
       "czk": 46630237918361.734,
       "dkk": 13603051138621.896,
       "eur": 1829249027134.8477,
       "gbp": 1566738333777.6892,
       "hkd": 16809340471234.676,
       "huf": 638745079455010,
       "idr": 30989573864865110,
       "ils": 6950500010031.326,
       "inr": 158578684016724.12,
       "jpy": 237019460910362.94,
       "krw": 2508456742004962,
       "kwd": 649513753355.987,
       "lkr": 430618856605894.94,
       "mmk": 3552876497958311.5,
       "mxn": 43588615169264.6,
       "myr": 9044649331193.879,
       "ngn": 888275226679303.6,
       "nok": 18815117740137.15,
       "nzd": 3075843471256.2,
       "php": 107540664685143,
       "pkr": 359604559250253.25,
       "pln": 8368027533374.602,
       "rub": 158842174726977.56,
       "sar": 8096441969900.93,
       "sek": 18638602450134.707,
       "sgd": 2904487301039.298,
       "thb": 70215836144409.36,
       "try": 18035332974254.17,
       "twd": 60179293148064.69,
       "uah": 58027687638059.95,
       "vef": 216143374112.75507,
       "vnd": 49020433966451690,
       "zar": 31794316889424.4,
       "xdr": 1521504293984.0945,
       "xag": 89787615432.37816,
       "xau": 1187979072.2981486,
       "bits": 44692429323510.82,
       "sats": 4469242932351082
     },
     "total_volume": {
       "btc": 2626478.9586559036,
       "eth": 39095796.39349524,
       "ltc": 727856791.9853623,
       "bch": 203094159.09622803,
       "bnb": 259362872.37048927,
       "eos": 25521024564.024734,
       "xrp": 111177860813.42728,
       "xlm": 361599802119.02686,
       "link": 4930178475.585364,
       "dot": 4888786983.402235,
       "yfi": 3354020.202281147,
       "usd": 126857945757.50508,
       "aed": 465950376488.8279,
       "ars": 12375851310079.457,
       "aud": 173422677043.14633,
       "bdt": 10826634167740.744,
       "bhd": 47825699266.47092,
       "bmd": 126857945757.50508,
       "brl": 659661317939.0262,
       "cad": 159935774539.9372,
       "chf": 115534351803.29875,
       "clp": 99413497772326.28,
       "cny": 820999253353.4218,
       "czk": 2740359845806.539,
       "dkk": 799422365933.3633,
       "eur": 107501072388.20471,
       "gbp": 92073877604.63445,
       "hkd": 987849166510.9788,
       "huf": 37537688967178.945,
       "idr": 1821191305234406.5,
       "ils": 408466093806.2177,
       "inr": 9319331778685.926,
       "jpy": 13929129302119.822,
       "krw": 147416664327725.12,
       "kwd": 38170541014.867134,
       "lkr": 25306553776455.133,
       "mmk": 208794990691670.4,
       "mxn": 2561610149905.131,
       "myr": 531534792723.9456,
       "ngn": 52202044679213.3,
       "nok": 1105724427987.3403,
       "nzd": 180760774915.4891,
       "php": 6319935999693.156,
       "pkr": 21133194650724.92,
       "pln": 491771169626.255,
       "rub": 9334816566976.857,
       "sar": 475810664038.7223,
       "sek": 1095351000046.8599,
       "sgd": 170690537465.367,
       "thb": 4126435259600.131,
       "try": 1059898136803.9553,
       "twd": 3536608987084.726,
       "uah": 3410163710224.765,
       "vef": 12702286108.698978,
       "vnd": 2880826580830680.5,
       "zar": 1868484340165.0044,
       "xdr": 89415569351.28603,
       "xag": 5276627076.455911,
       "xau": 69815001.86818531,
       "bits": 2626478958655.904,
       "sats": 262647895865590.34
     },
     "market_cap_percentage": {
       "btc": 42.06329189875528,
       "eth": 17.640189764782505,
       "ada": 4.246606881404631,
       "bnb": 3.5050615722040366,
       "usdt": 3.0538539721074924,
       "xrp": 2.467914106263789,
       "doge": 1.728924512454923,
       "usdc": 1.2602031969216645,
       "dot": 1.2314160177866156,
       "sol": 1.1415323477616068
     },
     "market_cap_change_percentage_24h_usd": 3.91559618056678,
     "updated_at": 1630083773
   }
 }
 
*/

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable{
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
            return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentageString()
        }
        return ""
    }
}
