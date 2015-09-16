var cache = {};
function factors(num, arr) {
  if(!cache[num]) {
    cache[num] = [];
    for(var x=0;x<arr.length;x++) {
      if(arr[x] != num && num % arr[x] == 0) {
        if(cache[num].indexOf(arr[x]) == -1) {
          cache[num].push(arr[x]);
        }
        subFactorsArr = factors(arr[x], arr);
        for(var a=0;a<subFactorsArr.length;a++) {
          if(cache[num].indexOf(subFactorsArr[a]) == -1) {
            cache[num].push(subFactorsArr[a]);
          }
        }
      }
    }
  }
  return cache[num];
}

intArr = [12, 4, 6, 10, 5, 2, 20];
for(var i=0;i<intArr.length;i++) {
  factors(intArr[i], intArr);
}
alert(JSON.stringify(cache));