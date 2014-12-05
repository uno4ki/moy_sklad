xml.customerOrder(name: name, stateUuid: stateUuid, targetAgentUuid: targetAgentUuid, sourceAgentUuid: sourceAgentUuid,
                  targetStoreUuid: targetStoreUuid, sourceStoreUuid: sourceStoreUuid, applicable: applicable,
                  projectUuid: projectUuid, contractUuid: contractUuid, moment: moment, targetAccountUuid: targetAccountUuid,
                  sourceAccountUuid: sourceAccountUuid, payerVat: payerVat, retailStoreUuid: retailStoreUuid,
                  currencyUuid: currencyUuid, rate: rate, vatIncluded: vatIncluded, created: created, createdBy: createdBy,
                  employeeUuid: employeeUuid, deliveryPlannedMoment: deliveryPlannedMoment,
                  reservedSum: reservedSum) {
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

  xml.demandsUuid {
    to_a(:demandsUuid).each do |r|
      xml.demandRef_ r
    end
  }

  xml.invoicesOutUuid {
    invoicesOutUuid.to_a(:invoiceOutRef).each do |r|
      xml.invoiceOutRef_ r
    end
  } if invoicesOutUuid.present?

  xml.paymentsUuid {
    paymentsUuid.to_a(:financeInRef).each do |r|
      xml.financeInRef_ r
    end
  } if paymentsUuid.present?

  xml.purchaseOrdersUuid {
    purchaseOrdersUuid.to_a(:purchaseOrderRef).each do |r|
      xml.purchaseOrderRef_ r
    end
  } if purchaseOrdersUuid.present?


  to_a(:customerOrderPosition).each do |o|
    xml.customerOrderPosition(discount: o.discount, quantity: o.quantity,
                              goodPackUuid: o.goodPackUuid, consignmentUuid: o.consignmentUuid, goodUuid: o.goodUuid,
                              slotUuid: o.slotUuid, vat: o.var) {
      xml.accountUuid_  o.accountUuid
      xml.accountId_    o.accountId
      xml.uuid_         o.uuid
      xml.groupUuid_    o.groupUuid
      xml.reserve_ o.reserve

      xml.basePrice(sum: o.basePrice.sum, sumInCurrency: o.basePrice.sumInCurrency)
      xml.price(sum: o.price.sum, sumInCurrency: o.price.sumInCurrency)

      xml.thins {
        o.to_a(:thingRef).each do |t|
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

                a.to_a(:file) do |f|
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
}
