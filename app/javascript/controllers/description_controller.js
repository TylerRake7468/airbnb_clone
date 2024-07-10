import { Controller } from "@hotwired/stimulus"
import {toggle} from 'el-transition'


export default class extends Controller {

  connect() {
  }

  toggleDescriptionModal(){
    document.getElementById("description").click();
  }
}
