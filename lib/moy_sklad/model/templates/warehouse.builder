xml.warehouse(updated: updated, updatedBy: updatedBy, name: name, agentUuid: agentUuid, archived: archived, parentUuid: parentUuid) {
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
        xml.file(name: f.name, created: f.created, filename: f.filename, miniatureUuid: f.miniatureUuid) {

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

  xml.contact(address: contact.address, phones: contact.phones, faxes: contact.faxes, mobiles: contact.mobiles, email: contact.email)

  to_a(:slots).each do |s|
    xml.slot(updated: s.updated, updatedBy: s.updatedBy, name: s.name, warehouseUuid: s.warehouseUuid) {
      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.deleted_      s.deleted
      xml.code_         s.code
      xml.externalcode_ s.externalcode
      xml.description_  s.description
    }
  end
}