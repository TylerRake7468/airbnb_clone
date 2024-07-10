import { Controller } from "@hotwired/stimulus"
import {toggle} from 'el-transition'


export default class extends Controller {

  connect() {
  }

  toggleReviewsModal(){
    document.getElementById("reviews").click();
  }
}
