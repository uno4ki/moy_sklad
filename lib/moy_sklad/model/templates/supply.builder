xml.supply(readMode: readMode, changeMode: changeMode, updated: updated, updatedBy: updatedBy, name: name, stateUuid: stateUuid,
           targetAgentUuid: targetAgentUuid, sourceAgentUuid: sourceAgentUuid, targetStoreUuid: targetStoreUuid, sourceStoreUuid: sourceStoreUuid,
           applicable: applicable, projectUuid: projectUuid, contractUuid: contractUuid, moment: moment, targetAccountUuid: targetAccountUuid,
           sourceAccountUuid: sourceAccountUuid, payerVat: payerVat, retailStoreUuid: retailStoreUuid, currencyUuid: currencyUuid, rate: rate,
           vatIncluded: vatIncluded, created: created, createdBy: createdBy, factureInUuid: factureInUuid, incomingDate: incomingDate,
           incomingNumber: incomingNumber, overheadDistribution: overheadDistribution, purchaseOrderUuid: purchaseOrderUuid) {

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

  to_a(:document) do |d|
    xml.document(readMode: d.readMode, changeMode: d.changeMode, updated: d.updated, updatedBy: d.updatedBy, name: d.name,
                 created: d.created, filename: d.filename, miniatureUuid: d.miniatureUuid, emailedDate: d.emailedDate,
                 publicId: d.publicId, operationUuid: d.operationUuid) {
      xml.accountUuid_  d.accountUuid
      xml.accountId_    d.accountId
      xml.uuid_         d.uuid
      xml.groupUuid_    d.groupUuid
      xml.ownerUid_     d.ownerUid
      xml.shared_       d.shared
      xml.deleted_      d.deleted
      xml.code_         d.code
      xml.externalcode_ d.externalcode
      xml.description_  d.description
      xml.contents_     d.contents
    }
  end

  xml.sum(sum: sum.sum, sumInCurrency: sum.sumInCurrency)

  xml.invoicesInUuid {
    invoicesInUuid.to_a(:invoiceInRef).each do |r|
      xml.invoiceInRef_ r
    end
  } if invoicesInUuid.present?

  xml.overhead(sum: overhead.sum, sumInCurrency: overhead.sumInCurrency)

  xml.paymentsUuid {
    paymentsUuid.to_a(:financeInRef).each do |r|
      xml.financeInRef_ r
    end
  } if paymentsUuid.present?

  to_a(:shipmentIn).each do |s|
    xml.shipmentIn(readMode: s.readMode, changeMode: s.changeMode, discount: s.discount, quantity: s.quantity, goodPackUuid: s.goodPackUuid,
                   consignmentUuid: s.consignmentUuid, goodUuid: s.goodUuid, slotUuid: s.slotUuid, vat: s.vat, countryUuid: s.countryUuid,
                   gtdUuid: s.gtdUuid, overhead: s.overhead) {

      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid
      xml.ownerUid_     s.ownerUid
      xml.shared_       s.shared

      xml.basePrice(sum: s.basePrice.sum, sumInCurrency: s.basePrice.sumInCurrency)
      xml.price(sum: s.price.sum, sumInCurrency: s.price.sumInCurrency)

      xml.things {
        s.to_a(:thingRef).each do |t|
          xml.thingRef(readMode: t.readMode, changeMode: t.changeMode, updated: t.updated, updatedBy: t.updatedBy, name: t.name, goodUuid: t.goodUuid) {

            xml.accountUuid_  t.accountUuid
            xml.accountId_    t.accountId
            xml.uuid_         t.uuid
            xml.groupUuid_    t.groupUuid
            xml.ownerUid_     t.ownerUid
            xml.shared_       t.shared
            xml.deleted_      t.deleted
            xml.code_         t.code
            xml.externalcode_ t.externalcode
            xml.description_  t.description

            t.to_a(:attribute).each do |a|
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
          }
        end
      }
    }
  end

  xml.purchaseReturnsUuid {
    purchaseReturnsUuid.to_a(:purchaseReturnRef).each do |r|
      xml.purchaseReturnRef_ r
    end
  } if purchaseReturnsUuid.present?
}
