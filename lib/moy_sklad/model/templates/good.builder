xml.good(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name, archived: archived, parentUuid: parentUuid,
         productCode: productCode, vat: vat, uomUuid: uomUuid, countryUuid: countryUuid, supplierUuid: supplierUuid, minPrice: minPrice, salePrice: salePrice,
         saleCurrencyUuid: saleCurrencyUuid, buyCurrencyUuid: buyCurrencyUuid, buyPrice: buyPrice, isSerialTrackable: isSerialTrackable,
         minimumBalance: minimumBalance, weight: weight, volume: volume) {

  xml.accountUuid_  accountUuid
  xml.accountId_    accountId
  xml.uuid_         uuid
  xml.groupUuid_    groupUuid
  xml.ownerUid_     ownerUid
  xml.shared_       shared
  xml.deleted_      deleted
  xml.code_         code
  xml.externalcode_ externalcode
  xml.description_  description

  to_a(:attribute).each do |a|
    xml.attribute(readMode: a.readMode, changeMode: a.changeMode, updated: a.updated, updatedBy: a.updatedBy, metadataUuid: a.metadataUuid,
                  valueText: a.valueText, valueString: a.valueString, doubleValue: a.doubleValue, longValue: a.longValue, booleanValue: a.booleanValue,
                  timeValue: a.timeValue, entityValueUuid: a.entityValueUuid, agentValueUuid: a.agentValueUuid, goodValueUuid: a.goodValueUuid,
                  placeValueUuid: a.placeValueUuid, consignmentValueUuid: a.consignmentValueUuid, contractValueUuid: a.contractValueUuid,
                  projectValueUuid: a.projectValueUuid, employeeValueUuid: a.employeeValueUuid, operationUuid: a.operationUuid) {

      xml.accountUuid_  a.accountUuid
      xml.accountId_    a.accountId
      xml.uuid_         a.uuid
      xml.groupUuid_    a.groupUuid
      xml.ownerUid_     a.ownerUid
      xml.shared_       a.shared
      xml.deleted_      a.deleted

      a.to_a(:file).each do |f|
        xml.file(readMode: f.readMode, changeMode: f.changeMode, updated: f.updated, updatedBy: f.updatedBy, name: f.name, created: f.created,
                 filename: f.filename, miniatureUuid: f.miniatureUuid) {

          xml.accountUuid_  f.accountUuid
          xml.accountId_    f.accountId
          xml.uuid_         f.uuid
          xml.groupUuid_    f.groupUuid
          xml.ownerUid_     f.ownerUid
          xml.shared_       f.shared
          xml.deleted_      f.deleted
          xml.code_         f.code
          xml.externalcode_ f.externalcode
          xml.description_  f.description
          xml.contents_     f.contents
        }
      end
    }
  end

  xml.salePrices {
    salePrices.to_a(:price).each do |p|
      xml.price(readMode: p.readMode, changeMode: p.changeMode, currencyUuid: p.currencyUuid, priceTypeUuid: p.priceTypeUuid, value: p.value) {
        xml.accountUuid_  p.accountUuid
        xml.accountId_    p.accountId
        xml.uuid_         p.uuid
        xml.groupUuid_    p.groupUuid
        xml.ownerUid_     p.ownerUid
        xml.shared_       p.shared
      }
    end
  }

  to_a(:barcode).each do |barcode|
    xml.barcode(readMode: barcode.readMode, changeMode: barcode.changeMode, barcode: barcode.barcode, barcodeType: barcode.barcodeType) {
      xml.accountUuid_  barcode.accountUuid
      xml.accountId_    barcode.accountId
      xml.uuid_         barcode.uuid
      xml.groupUuid_    barcode.groupUuid
      xml.ownerUid_     barcode.ownerUid
      xml.shared_       barcode.shared
    }
  end

  to_a(:pack).each do |p|
    xml.pack(readMode: p.readMode, changeMode: p.changeMode, quantity: p.quantity, uomUuid: p.uomUuid) {
      xml.accountUuid_  p.accountUuid
      xml.accountId_    p.accountId
      xml.uuid_         p.uuid
      xml.groupUuid_    p.groupUuid
      xml.ownerUid_     p.ownerUid
      xml.shared_       p.shared
    }
  end

  xml.preferences {
    to_a(:preference).each do |p|
      xml.preference(readMode: p.readMode, changeMode: p.changeMode, slotUuid: p.slotUuid) {
        xml.accountUuid_  p.accountUuid
        xml.accountId_    p.accountId
        xml.uuid_         p.uuid
        xml.groupUuid_    p.groupUuid
        xml.ownerUid_     p.ownerUid
        xml.shared_       p.shared
      }
    end
  }
}
