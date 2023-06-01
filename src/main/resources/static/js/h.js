 
const button = document.getElementById("button");
const input = document.getElementById("input");

button.addEventListener("click", () => input.style.display = "block");


document.getElementById("content").addEventListener("input", countCharacters);

  function countCharacters() {
    var content = document.getElementById("content").value;
    var maxLength = 280; // Change this to your desired maximum length

    var count = content.length;
    var counterElement = document.getElementById("counter");
    counterElement.textContent = count + "/" + maxLength;
  }
  
  // Initial character count
  countCharacters();