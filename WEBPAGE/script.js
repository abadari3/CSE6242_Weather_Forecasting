function onReady() {
    document.getElementById("video").style.margin = "1em auto";
}

document.addEventListener("DOMContentLoaded", onReady);


function toggleVisibility(sectionId, className) {
  var section = document.getElementById(sectionId);
  var elements = section.getElementsByClassName(className);
  for (var i = 0; i < elements.length; i++) {
    if (elements[i].style.display === "none") {
      elements[i].style.display = "block";
      elements[i].nextElementSibling.innerHTML = "Collapse";
    } else {
      elements[i].style.display = "none";
      elements[i].nextElementSibling.innerHTML = "Read more...";
    }
  }
}
