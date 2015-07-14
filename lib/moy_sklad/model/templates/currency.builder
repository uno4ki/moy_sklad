xml.currency(name: name, enteredRate: enteredRate, invertRate: invertRate, rate: rate) {
  xml.accountUuid_  accountUuid
  xml.accountId_    accountId
  xml.uuid_         uuid
  xml.groupUuid_    groupUuid
  xml.deleted_      deleted
  xml.code_         code
  xml.externalcode_ externalcode
  xml.description_  description
  xml.major(s1: major.s1, s24: major.s24, s5: major.s5, sex: major.sex)
  xml.minor(s1: minor.s1, s24: minor.s24, s5: minor.s5, sex: minor.sex)
}
