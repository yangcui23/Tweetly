
 function tabs(evt, contentName) {
  
  var i, tabcontent, tablinks;

  
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  
  document.getElementById(contentName).style.display = "block";
  evt.currentTarget.className += " active";
}
 




const messageEle = document.getElementById('input');
const counterEle = document.getElementById('counter');

messageEle.addEventListener('input', function (e) {
    const target = e.target;

    
    const maxLength = target.getAttribute('maxlength');

    
    const currentLength = target.value.length;

    counterEle.innerHTML = `${currentLength}/${maxLength}`;
});

