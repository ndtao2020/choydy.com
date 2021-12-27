const formatDate = (d) => {
  const d1 = new Date(d)
  return `${d1.getDate()}/${d1.getMonth()}/${d1.getFullYear()} - ${d1.getHours()}:${d1.getMinutes()}`
}

/**
 * @returns khoảng cách giữa 2 Date kiểu string,
 * Nếu khác năm, trả về "x năm trước"
 * Nếu khác tháng, trả về "x tháng trước"
 * Tương tự với ngày giờ phút
 * Nếu trùng phút, trả về "Vừa xong"
 * @param d1 có kiểu dữ liệu Date
 * @param d2 có kiểu dữ liệu Date và lớn hơn d1
 */
const dateDiff = (d1, d2 = new Date()) => {
  const d1Y = d1.getFullYear()
  const d2Y = d2.getFullYear()
  if (d1Y !== d2Y) return `${d2Y - d1Y} năm trước`
  const d1M = d1.getMonth()
  const d2M = d2.getMonth()
  if (d1M !== d2M) return `${d2M - d1M} tháng trước`
  const d2D = d2.getDate()
  const d1D = d1.getDate()
  if (d1D !== d2D) {
    if (d2D - d1D > 7) {
      return `${Math.ceil((d2D - d1D) / 7)} tuần trước`
    }
    return `${d2D - d1D} ngày trước`
  }
  const d1H = d1.getHours()
  const d2H = d2.getHours()
  if (d2H !== d1H) return `${d2H - d1H} giờ trước`
  const d1Min = d1.getMinutes()
  const d2Min = d2.getMinutes()
  if (d2Min !== d1Min) return `${d2Min - d1Min} phút trước`
  return `Vừa xong`
}

export { formatDate, dateDiff }
