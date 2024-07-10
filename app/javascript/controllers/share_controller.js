import { Controller } from "@hotwired/stimulus"
import {toggle} from 'el-transition'


export default class extends Controller {

  connect() {
  }

  toggleShareModal(){
    document.getElementById("share").click();
  }
}
