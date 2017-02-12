window.onload = function() {
  const sample = function(arr) {
    return arr[Math.floor(Math.random() * arr.length)];
  };
  const capitalize = function(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
  }
  const adjective = capitalize(sample(COMMON_ADJECTIVES));
  const noun = capitalize(sample(COMMON_NOUNS));
  document.write(adjective + ' ' + noun);
}
