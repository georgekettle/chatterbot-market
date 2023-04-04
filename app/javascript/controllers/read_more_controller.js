import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-more"
export default class extends Controller {
  static targets = [ "content", "toggle" ]

  static values = { 
    moreText: {
      type: String,
      default: "Read more"
    },
    lessText: {
      type: String,
      default: "Read less"
    },
    toggleClass: {
      type: String,
      default: "line-clamp-2"
    }
  }

  connect() {
    console.log('Connected to read-more controller')
    this.contentTarget.classList.add(this.toggleClassValue)
    const maxLines = this.toggleClassValue.match(/\d+/)[0]
    if (this.getNumberOfLines() > maxLines) {
      this.toggleTarget.classList.remove('hidden')
    }
  }

  toggle() {
    this.contentTarget.classList.toggle(this.toggleClassValue)
    this.toggleTarget.innerText = this.contentTarget.classList.contains(this.toggleClassValue) ? this.moreTextValue : this.lessTextValue
  }

 getNumberOfLines() {
    var temp = document.createElement(this.contentTarget.nodeName), ret;
    temp.setAttribute("style", "margin:0; padding:0; "
        + "font-family:" + (this.contentTarget.style.fontFamily || "inherit") + "; "
        + "font-size:" + (this.contentTarget.style.fontSize || "inherit"));
    temp.innerHTML = "A";
    this.contentTarget.parentNode.appendChild(temp);
    const singleLineHeight = temp.clientHeight;
    temp.innerHTML = this.contentTarget.innerHTML;
    const lineCount = temp.clientHeight / singleLineHeight;
    console.log(lineCount)
    temp.remove();
    return lineCount;
  }
}
