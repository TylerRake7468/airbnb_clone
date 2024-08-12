import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


    setRating(e){
        const rating = e.currentTarget.dataset.rating;
        console.log("rating is:", rating);
    }
}
