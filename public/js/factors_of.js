var cache = {};
function factors_of(num, arr) {
  if(!cache[num]) {
    cache[num] = [];
    for(var x=0;x<arr.length;x++) {
      if(arr[x] != num && arr[x] % num == 0) {
        if(cache[num].indexOf(arr[x]) == -1) {
          cache[num].push(arr[x]);
        }
        parentFactorsArr = factors_of(arr[x], arr);
        for(var a=0;a<parentFactorsArr.length;a++) {
          if(cache[num].indexOf(parentFactorsArr[a]) == -1) {
            cache[num].push(parentFactorsArr[a]);
          }
        }
      }
    }
  }
  return cache[num];
}

intArr = [12, 4, 6, 10, 5, 2, 20];
for(var i=0;i<intArr.length;i++) {
  factors_of(intArr[i], intArr);
}
alert(JSON.stringify(cache));
