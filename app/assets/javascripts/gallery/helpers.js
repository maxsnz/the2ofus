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

export function hasClass(element, cls) {
  return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
}

export function share(provider) {
  let w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    browser_width = w.innerWidth || e.clientWidth || g.clientWidth,
    browser_height= w.innerHeight|| e.clientHeight|| g.clientHeight;
  let window_width = 555;
  let window_height = 590;
  let t = (browser_height - window_height) / 2;
  let l = (browser_width - window_width) / 2;
  let txt = window.location.href;
  let provider_url = '';
  if (provider=='tw') txt = encodeURIComponent('#the2ofus ' + txt)
  if (provider=='fb') provider_url = 'https://www.facebook.com/sharer/sharer.php?u=';
  if (provider=='vk') provider_url = 'https://vk.com/share.php?url=';
  if (provider=='tw') provider_url = 'https://twitter.com/intent/tweet?text=';
  var newWin = window.open(provider_url + txt, 'share', 'width=' + window_width + ',height=' + window_height + ', top=' + t + ', left=' + l + ', resizable=yes,scrollbars=yes,status=yes');
  newWin.focus();
}

