const formatDate = (d) => {
  const d1 = new Date(d)
  return `${d1.getDate()}/${d1.getMonth()}/${d1.getFullYear()} - ${d1.getHours()}:${d1.getMinutes()}`
}

const dateDiff = (d1, d2 = new Date().getTime()) => {
  const time = d2 - d1
  const years = 31557600000
  if (time >= years) {
    return `${(time / years).toFixed(0)} năm trước`
  }
  const months = 2629800000
  if (time >= months) {
    return `${(time / months).toFixed(0)} tháng trước`
  }
  const weeks = 604800016
  if (time >= weeks) {
    return `${(time / weeks).toFixed(0)} tuần trước`
  }
  const days = 86400000
  if (time >= days) {
    return `${(time / days).toFixed(0)} ngày trước`
  }
  const hours = 3600000
  if (time >= hours) {
    return `${(time / hours).toFixed(0)} giờ trước`
  }
  const minutes = 60000
  if (time >= minutes) {
    return `${(time / minutes).toFixed(0)} phút trước`
  }
  return `Vừa xong`
}

export { formatDate, dateDiff }
