import { Controller } from "@hotwired/stimulus"
import {toggle} from 'el-transition'


export default class extends Controller {

  connect() {
  }

  toggleSearchModal(){
    document.getElementById("search").click();
  }
}
