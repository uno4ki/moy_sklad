xml.company(name: name,  discount: discount, autoDiscount: autoDiscount, discountCardNumber: discountCardNumber,
            discountCorrection: discountCorrection, stateUuid: stateUuid, employeeUuid: employeeUuid,
            priceTypeUuid: priceTypeUuid, archived: archived, created: created, director: director,
            chiefAccountant: chiefAccountant, payerVat: payerVat, companyType: companyType) {

  xml.accountUuid_  accountUuid
  xml.accountId_    accountId
  xml.uuid_         uuid
  xml.groupUuid_    groupUuid
  xml.deleted_      deleted
  xml.code_         code
  xml.externalcode_ externalcode
  xml.description_  description

  to_a(:attribute).each do |a|
    xml.attribute(metadataUuid: a.metadataUuid, valueText: a.valueText, valueString: a.valueString,
                  doubleValue: a.doubleValue, longValue: a.longValue, booleanValue: a.booleanValue,
                  timeValue: a.timeValue, entityValueUuid: a.entityValueUuid, agentValueUuid: a.agentValueUuid,
                  goodValueUuid: a.goodValueUuid, placeValueUuid: a.placeValueUuid, consignmentValueUuid: a.consignmentValueUuid,
                  contractValueUuid: a.contractValueUuid, projectValueUuid: a.projectValueUuid, employeeValueUuid: a.employeeValueUuid,
                  goodUuid: a.goodUuid) {

      xml.accountUuid_  a.accountUuid
      xml.accountId_    a.accountId
      xml.uuid_         a.uuid
      xml.groupUuid_    a.groupUuid
      xml.deleted_      a.deleted

      a.to_a(:file).each do |f|
        xml.file(name: f.name,
                 filename: f.filename, miniatureUuid: f.miniatureUuid) {

          xml.accountUuid_  f.accountUuid
          xml.accountId_    f.accountId
          xml.uuid_         f.uuid
          xml.groupUuid_    f.groupUuid
          xml.deleted_      f.deleted
          xml.code_         f.code
          xml.externalcode_ f.externalcode
          xml.description_  f.description
          xml.contents_     f.contents
        }
      end
    }
  end

  xml.requisite(legalTitle: requisite.legalTitle, legalAddress: requisite.legalAddress, actualAddress: requisite.actualAddress,
                inn: requisite.inn, kpp: requisite.kpp, okpo: requisite.okpo, ogrn: requisite.ogrn, ogrnip: requisite.ogrnip,
                nomerSvidetelstva: requisite.nomerSvidetelstva, dataSvidetelstva: requisite.dataSvidetelstva) {

    xml.bankAccount(accountNumber: requisite.bankAccont.accountNumber, bankLocation: requisite.bankAccont.bankLocation,
                    bankName: requisite.bankAccont.bankName, bic: requisite.bankAccont.bic,
                    correspondentAccount: requisite.correspondentAccount, isDefault: requisite.bankAccont.isDefault) {
      xml.accountUuid_  requisite.bankAccount.accountUuid
      xml.accountId_    requisite.bankAccount.accountId
      xml.uuid_         requisite.bankAccount.uuid
      xml.groupUuid_    requisite.bankAccount.groupUuid
      xml.deleted_      requisite.bankAccount.deleted
    } if requisite.bankAccount.present?
  } if requisite.present?

  to_a(:bankAccount).each do |b|
      xml.bankAccount(accountNumber: b.accountNumber, bankLocation: b.bankLocation, bankName: b.bankName, bic: b.bic,
                      correspondentAccount: b.correspondentAccount, isDefault: b.isDefault) {
        xml.accountUuid_  b.accountUuid
        xml.accountId_    b.accountId
        xml.uuid_         b.uuid
        xml.groupUuid_    b.groupUuid
        xml.deleted_      b.deleted
      }
  end

  xml.contact(address: contact.address, phones: contact.phones, faxes: contact.faxes, mobiles: contact.mobiles, email: contact.email)

  to_a(:contactPerson).each do |c|
    xml.contactPerson(name: c.name, email: c.email, phone: c.phone, position: c.position) {
      xml.accountUuid_  c.accountUuid
      xml.accountId_    c.accountId
      xml.uuid_         c.uuid
      xml.groupUuid_    c.groupUuid
      xml.deleted_      c.deleted
      xml.code_         c.code
      xml.externalcode_ c.externalcode
      xml.description_  c.description
    }
  end

  to_a(:agentNewsItem).each do |n|
    xml.agentNewsItem(moment: n.moment) {
      xml.accountUuid_  n.accountUuid
      xml.accountId_    n.accountId
      xml.uuid_         n.uuid
      xml.groupUuid_    n.groupUuid
      xml.deleted_      n.deleted
      xml.text_         n.text
    }
  end

  xml.tags {
    tags.to_a(:tag).each do |t|
      xml.tag_ t
    end
  }

  to_a(:sign).each do |s|
    xml.sign(name: s.name, filename: s.filename, miniatureUuid: s.miniatureUuid) {
      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.deleted_      s.deleted
      xml.code_         s.code
      xml.externalcode_ s.externalcode
      xml.description_  s.description
      xml.contents_     s.contents
    }
  end

  to_a(:stamp).each do |s|
    xml.stamp(name: s.name, filename: s.filename, miniatureUuid: s.miniatureUuid) {
      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.deleted_      s.deleted
      xml.code_         s.code
      xml.externalcode_ s.externalcode
      xml.description_  s.description
      xml.contents_     s.contents
    }
  end
}
