xml.company(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name, discount: discount,
            autoDiscount: autoDiscount, discountCardNumber: discountCardNumber, discountCorrection: discountCorrection, stateUuid: stateUuid,
            priceTypeUuid: priceTypeUuid, archived: archived, created: created, director: director, chiefAccountant: chiefAccountant,
            payerVat: payerVat, companyType: companyType) {

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


  xml.requisite(legalTitle: requisite.legalTitle, legalAddress: requisite.legalAddress, actualAddress: requisite.actualAddress,
                inn: requisite.inn, kpp: requisite.kpp, okpo: requisite.okpo, ogrn: requisite.ogrn, ogrnip: requisite.ogrnip,
                nomerSvidetelstva: requisite.nomerSvidetelstva, dataSvidetelstva: requisite.dataSvidetelstva) {

    xml.bankAccount(readMode: requisite.bankAccount.readMode, changeMode: requisite.bankAccount.changeMode,
                    updated: requisite.bankAccount.updated, updatedBy: requisite.bankAccount.updatedBy,
                    accountNumber: requisite.bankAccount.accountNumber, bankLocation: requisite.bankAccount.bankLocation,
                    bankName: requisite.bankAccount.bankName, bic: requisite.bankAccount.bic,
                    correspondentAccount: requisite.bankAccount.correspondentAccount, isDefault: requisite.bankAccount.isDefault) {

      xml.accountUuid_  requisite.bankAccount.accountUuid
      xml.accountId_    requisite.bankAccount.accountId
      xml.uuid_         requisite.bankAccount.uuid
      xml.groupUuid_    requisite.bankAccount.groupUuid
      xml.ownerUid_     requisite.bankAccount.ownerUid
      xml.shared_       requisite.bankAccount.shared
      xml.deleted_      requisite.bankAccount.deleted
    } if requisite.bankAccount.present?
  } if requisite.present?

  to_a(:bankAccount).each do |b|
      xml.bankAccount(readMode: b.readMode, changeMode: b.changeMode, updated: b.updated, updatedBy: b.updatedBy, accountNumber: b.accountNumber,
                      bankLocation: b.bankLocation, bankName: b.bankName, bic: b.bic, correspondentAccount: b.correspondentAccount,
                      isDefault: b.isDefault) {
        xml.accountUuid_  b.accountUuid
        xml.accountId_    b.accountId
        xml.uuid_         b.uuid
        xml.groupUuid_    b.groupUuid
        xml.ownerUid_     b.ownerUid
        xml.shared_       b.shared
        xml.deleted_      b.deleted
      }
  end

  xml.contact(address: contact.address, phones: contact.phones, faxes: contact.faxes, mobiles: contact.mobiles, email: contact.email)

  to_a(:contactPerson).each do |c|
    xml.contactPerson(readMode: c.readMode, changeMode: c.changeMode, updated: c.updated, updatedBy: c.updatedBy, name: c.name,
                      email: c.email, phone: c.phone, position: c.position) {

      xml.accountUuid_  c.accountUuid
      xml.accountId_    c.accountId
      xml.uuid_         c.uuid
      xml.groupUuid_    c.groupUuid
      xml.ownerUid_     c.ownerUid
      xml.shared_       c.shared
      xml.deleted_      c.deleted
      xml.code_         c.code
      xml.externalcode_ c.externalcode
      xml.description_  c.description
    }
  end

  to_a(:agentNewsItem).each do |n|
    xml.agentNewsItem(readMode: n.readMode, changeMode: n.changeMode, updated: n.updated, updatedBy: n.updatedBy, moment: n.moment) {
      xml.accountUuid_  n.accountUuid
      xml.accountId_    n.accountId
      xml.uuid_         n.uuid
      xml.groupUuid_    n.groupUuid
      xml.ownerUid_     n.ownerUid
      xml.shared_       n.shared
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
    xml.sign(readMode: s.readMode, changeMode: s.changeMode, updated: s.updated, updatedBy: s.updatedBy, name: s.name, created: s.created,
             filename: s.filename, miniatureUuid: s.miniatureUuid) {
      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.ownerUid_     s.ownerUid
      xml.shared_       s.shared
      xml.deleted_      s.deleted
      xml.code_         s.code
      xml.externalcode_ s.externalcode
      xml.description_  s.description
      xml.contents_     s.contents
    }
  end

  to_a(:stamp).each do |s|
    xml.stamp(readMode: s.readMode, changeMode: s.changeMode, updated: s.updated, updatedBy: s.updatedBy, name: s.name, created: s.created,
              filename: s.filename, miniatureUuid: s.miniatureUuid) {
      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.ownerUid_     s.ownerUid
      xml.shared_       s.shared
      xml.deleted_      s.deleted
      xml.code_         s.code
      xml.externalcode_ s.externalcode
      xml.description_  s.description
      xml.contents_     s.contents
    }
  end
}
