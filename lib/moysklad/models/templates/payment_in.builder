xml.paymentIn(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name, stateUuid: stateUuid,
              targetAgentUuid: targetAgentUuid, sourceAgentUuid: sourceAgentUuid, targetStoreUuid: targetStoreUuid,
              sourceStoreUuid: sourceStoreUuid, applicable: applicable, projectUuid: projectUuid, contractUuid: contractUuid,
              moment: moment, targetAccountUuid: targetAccountUuid, sourceAccountUuid: sourceAccountUuid, payerVat: payerVat,
              retailStoreUuid: retailStoreUuid, currencyUuid: currencyUuid, rate: rate, vatIncluded: vatIncluded,
              created: created, createdBy: createdBy, employeeUuid: employeeUuid, expenseItemUuid: expenseItemUuid,
              incomingDate: incomingDate, incomingNumber: incomingNumber, paymentPurpose: paymentPurpose, vatSum: vatSum,
              commissionReportUuid: commissionReportUuid, customerOrderUuid: customerOrderUuid, factureOutUuid: factureOutUuid,
              invoiceOutUuid: invoiceOutUuid, purchaseReturnUuid: purchaseReturnUuid) {

  xml.accountUuid_  accountUuid
  xml.accountId_    accountId
  xml.uuid_         uuid
  xml.groupUuid_    groupUuid
  xml.deleted_      deleted
  xml.code_         code
  xml.externalcode_ externalcode
  xml.description_  description

  getArray(:attribute).each do |a|
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

      a.getArray(:file).each do |f|
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
      end
    }
  end

  document.each do |d|
    xml.document(readMode: d.readMode, changeMode: d.changeMode, updated: d.updated, updatedBy: d.updatedBy, name: d.name,
                 created: d.created, filename: d.filename, miniatureUuid: d.miniatureUuid, emailedDate: d.emailedDate,
                 publicId: d.publicId, operationUuid: d.operationUuid) {
      xml.accountUuid_  d.accountUuid
      xml.accountId_    d.accountId
      xml.uuid_         d.uuid
      xml.groupUuid_    d.groupUuid
      xml.deleted_      d.deleted
      xml.code_         d.code
      xml.externalcode_ d.externalcode
      xml.description_  d.description
      xml.contents_     d.contents
    }
  end if !document.is_a?(Moysklad::Client::Attribute::MissingAttr)

  xml.sum(sum: sum.sum, sumInCurrency: sum.sumInCurrency)

  xml.demandsUuid {
    getArray(:demandsUuid).each do |r|
      xml.demandRef_ r
    end
  }
}
