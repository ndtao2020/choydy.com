export function formatNumber(value) {
  return Number(value).toLocaleString()
}

// Get All List Tree
const getAllListTree = (roots, list, propertyId, propertyParent) => {
  return roots.map((x) => {
    x.children = list.filter((k) => x[propertyId] === k[propertyParent])
    if (x.children != null) {
      getAllListTree(x.children, list, propertyId, propertyParent)
    }
    return x
  })
}

export const abbreviateNumber = (num) => {
  if (num < 1000) {
    return num
  }
  let newValue = num
  const suffixes = ['', 'K', 'M', 'B', 'T']
  let suffixNum = 0
  while (newValue >= 1000) {
    newValue /= 1000
    suffixNum++
  }
  return `${newValue.toPrecision(3)}${suffixes[suffixNum]}`
}

// Generate Tree
export function generateTree(list, propertyId, propertyParent) {
  if (list != null) {
    return getAllListTree(
      list.filter((x) => x[propertyParent] === null),
      list,
      propertyId,
      propertyParent
    )
  }
  return null
}

const getAllListTreeFromArray = (roots, list, propertyId, propertyParent) => {
  return roots.map((x) => {
    const u = {}
    for (let index = 0; index < x.length; index++) {
      u['a' + index] = x[index]
    }
    u.children = list
      .filter((k) => x[propertyId] === k[propertyParent])
      .map((l) => {
        const m = {}
        for (let index = 0; index < x.length; index++) {
          m['a' + index] = l[index]
        }
        return m
      })
    if (u.children != null) {
      getAllListTreeFromArray(u.children, list, propertyId, propertyParent)
    }
    return u
  })
}

// Generate Tree
export function generateTreeFromArray(list, propertyId, propertyParent) {
  if (list != null) {
    return getAllListTreeFromArray(
      list.filter((x) => x[propertyParent] === null),
      list,
      propertyId,
      propertyParent
    )
  }
  return null
}
