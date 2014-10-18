xml.company(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name,  discount: discount,
            autoDiscount: autoDiscount, discountCardNumber: discountCardNumber, discountCorrection: discountCorrection,
            stateUuid: stateUuid, employeeUuid: employeeUuid, priceTypeUuid: priceTypeUuid, archived: archived, created: created,
            director: director, chiefAccountant: chiefAccountant, payerVat: payerVat, companyType: companyType) {

  xml.accountUuid_  accountUuid
  xml.accountId_    accountId
  xml.uuid_         uuid
  xml.groupUuid_    groupUuid
  xml.deleted_      deleted
  xml.code_         code
  xml.externalcode_ externalcode
  xml.description_  description

  attribute.each do |a|
    xml.attribute(readMode: a.readMode, changeMode: a.changeMode, updated: a.updated, updatedBy: a.updatedBy,
                  metadataUuid: a.metadataUuid, valueText: a.valueText, valueString: a.valueString,
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

      a.file.each_value do |f|
        xml.file(readMode: f.readMode, changeMode: f.changeMode, updated: f.updated, updatedBy: f.updatedBy, name: f.name,
                 created: f.created, filename: f.filename, miniatureUuid: f.miniatureUuid) {

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
      end if !a.file.is_a?(::MoySklad::Client::Attribute::MissingAttr)
    }
  end if !attribute.is_a?(::MoySklad::Client::Attribute::MissingAttr)

  requisite.each do |r|
    xml.requisite(legalTitle: r.legalTitle, legalAddress: r.legalAddress, actualAddress: r.actualAddress, inn: r.inn, kpp: r.kpp,
                  okpo: r.okpo, ogrn: r.ogrn, ogrnip: r.ogrnip, nomerSvidetelstva: r.nomerSvidetelstva,
                  dataSvidetelstva: r.dataSvidetelstva) {

      xml.bankAccount(readMode: r.readMode, changeMode: r.changeMode, updated: r.updatedBy, updatedBy: r.updatedBy,
                      accountNumber: r.accountNumber, bankLocation: r.bankLocation, bankName: r.bankName, bic: r.bic,
                      correspondentAccount: r.correspondentAccount, isDefault: r.isDefault) {
        xml.accountUuid_  r.accountUuid
        xml.accountId_    r.accountId
        xml.uuid_         r.uuid
        xml.groupUuid_    r.groupUuid
        xml.deleted_      r.deleted
      }
    }
  end if !requisite.is_a?(::MoySklad::Client::Attribute::MissingAttr)

  bankAccount.each do |b|
      xml.bankAccount(readMode: b.readMode, changeMode: b.changeMode, updated: b.updatedBy, updatedBy: b.updatedBy,
                      accountNumber: b.accountNumber, bankLocation: b.bankLocation, bankName: b.bankName, bic: b.bic,
                      correspondentAccount: b.correspondentAccount, isDefault: b.isDefault) {
        xml.accountUuid_  b.accountUuid
        xml.accountId_    b.accountId
        xml.uuid_         b.uuid
        xml.groupUuid_    b.groupUuid
        xml.deleted_      b.deleted
      }
  end if !bankAccount.is_a?(MoySklad::Client::Attribute::MissingAttr)

  xml.contact(address: contact.address, phones: contact.phones, faxes: contact.faxes, mobiles: contact.mobiles, email: contact.email)

  contactPerson.each do |c|
    xml.contactPerson(readMode: c.readMode, changeMode: c.changeMode, updated: c.updated, updatedBy: c.updatedBy, name: c.name,
                      email: c.email, phone: c.phone, position: c.position) {
      xml.accountUuid_  c.accountUuid
      xml.accountId_    c.accountId
      xml.uuid_         c.uuid
      xml.groupUuid_    c.groupUuid
      xml.deleted_      c.deleted
      xml.code_         c.code
      xml.externalcode_ c.externalcode
      xml.description_  c.description
    }
  end if !contactPerson.is_a?(MoySklad::Client::Attribute::MissingAttr)

  agentNewsItem.each do |n|
    xml.agentNewsItem(readMode: n.readMode, changeMode: n.changeMode, updated: n.updated, updatedBy: n.updatedBy, moment: n.moment) {
      xml.accountUuid_  n.accountUuid
      xml.accountId_    n.accountId
      xml.uuid_         n.uuid
      xml.groupUuid_    n.groupUuid
      xml.deleted_      n.deleted
      xml.text_         n.text
    }
  end if !agentNewsItem.is_a?(MoySklad::Client::Attribute::MissingAttr)

  xml.tags {
    tags.tag.each do |t|
      xml.tag_ t
    end if !tags.tag.is_a?(MoySklad::Client::Attribute::MissingAttr)
  }

  sign.each do |s|
    xml.sign(readMode: s.readMode, changeMode: s.changeMode, updated: s.updated, updatedBy: s.updatedBy, name: s.name,
             created: s.created, filename: s.filename, miniatureUuid: s.miniatureUuid) {
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
  end if !sign.is_a?(MoySklad::Client::Attribute::MissingAttr)

  stamp.each do |s|
    xml.stamp(readMode: s.readMode, changeMode: s.changeMode, updated: s.updated, updatedBy: s.updatedBy, name: s.name,
              created: s.created, filename: s.filename, miniatureUuid: s.miniatureUuid) {
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
  end if !stamp.is_a?(MoySklad::Client::Attribute::MissingAttr)
}
