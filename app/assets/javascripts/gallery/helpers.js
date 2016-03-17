export function getObjById(arr, id) {
  for (let obj of arr) {
    if (obj.id == id) return obj;
  }
  return null;
}

export function formatArrayAsObject(arr) {
  let newObj = {};
  for (let item of arr) {
    newObj[item.id] = item;
  }
  return newObj;
}

export function getIds(arr, id) {
  let newArr = [];
  for (let item of arr) {
    newArr.push(item[id]);
  }
  return newArr;
}