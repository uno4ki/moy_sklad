xml.supply(name: name, stateUuid: stateUuid, targetAgentUuid: targetAgentUuid, sourceAgentUuid: sourceAgentUuid,
           targetStoreUuid: targetStoreUuid, sourceStoreUuid: sourceStoreUuid, applicable: applicable, projectUuid: projectUuid,
           contractUuid: contractUuid, moment: moment, targetAccountUuid: targetAccountUuid, sourceAccountUuid: sourceAccountUuid,
           payerVat: payerVat, retailStoreUuid: retailStoreUuid, currencyUuid: currencyUuid, rate: rate, vatIncluded: vatIncluded,
           employeeUuid: employeeUuid, factureInUuid: factureInUuid, incomingDate: incomingDate, incomingNumber: incomingNumber,
           overheadDistribution: overheadDistribution, purchaseOrderUuid: purchaseOrderUuid) {

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

  to_a(:document).each do |d|
    xml.document(name: d.name, created: d.created, filename: d.filename, miniatureUuid: d.miniatureUuid,
                 emailedDate: d.emailedDate, publicId: d.publicId, operationUuid: d.operationUuid) {
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
    xml.shipmentIn(discount: s.discount, quantity: s.quantity, goodPackUuid: s.goodPackUuid, consignmentUuid: s.consignmentUuid,
                   goodUuid: s.goodUuid, slotUuid: s.slotUuid, vat: s.vat, countryUuid: s.countryUuid, gtdUuid: s.gtdUuid,
                   overhead: s.overhead) {

      xml.accountUuid_  s.accountUuid
      xml.accountId_    s.accountId
      xml.uuid_         s.uuid
      xml.groupUuid_    s.groupUuid

      xml.basePrice(sum: s.basePrice.sum, sumInCurrency: s.basePrice.sumInCurrency)
      xml.price(sum: s.price.sum, sumInCurrency: s.price.sumInCurrency)

      xml.things {
        s.to_a(:thingsRef).each do |t|

          xml.thingRef(name: t.name, goodUuid: t.goodUuid) {
            xml.accountUuid_  t.accountUuid
            xml.accountId_    t.accountId
            xml.uuid_         t.uuid
            xml.groupUuid_    t.groupUuid
            xml.deleted_      t.deleted
            xml.code_         t.code
            xml.externalcode_ t.externalcode
            xml.description_  t.description

            t.to_a(:attribute).each do |a|
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
