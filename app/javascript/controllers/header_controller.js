import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'


export default class extends Controller {
  static targets = ['openUserMenu', 'dropdown']

  connect() {
    this.openUserMenuTarget.addEventListener("click", (e)=>{
        openDropDown(this.dropdownTarget)
    })
  }
}

function openDropDown(element) {
    toggle(element).then(() => {
        console.log("Enter transition complete")
    })
}
 
// remove element when close
function closeDropDown(element) {
    leave(element).then(() => {
        element.destroy();
    })
}