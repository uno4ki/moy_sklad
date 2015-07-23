xml.warehouse(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name, archived: archived, parentUuid: parentUuid) {

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

  xml.contact(address: contact.address, phones: contact.phones, faxes: contact.faxes, mobiles: contact.mobiles, email: contact.email) if contact.present?

  xml.slots {
    slots.to_a(:slot).each do |s|
      xml.slot(readMode: s.readMode, changeMode: s.changeMode, updated: s.updated, updatedBy: s.updatedBy, name: s.name, warehouseUuid: s.warehouseUuid) {
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
      }
    end
  } if slots.present?
}
