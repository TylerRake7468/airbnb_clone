import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


    setRating(e){
        const rating = e.currentTarget.dataset.rating;
        const category = e.currentTarget.dataset.category;
        const rootElement = e.currentTarget.parentNode;
        console.log("root ele:", rootElement);
        const ratingInput = rootElement.querySelector(`input[data-rating-target="${category}"]`);

        const stars = rootElement.querySelectorAll('[data-rating-target="star"]');
        console.log("stars::", stars);
        stars.forEach(star => {
            console.log("star:::::", star);
            if( star.dataset.rating <= rating){
                star.classList.remove("fill-gray-300");
                star.classList.add("fill-amber-300");
            }else{
                star.classList.remove("fill-amber-300");
                star.classList.add("fill-gray-300");
            }
            
        });

        if(ratingInput){
            ratingInput.value = rating;
        }
    }
}
