import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    updateWishlistOnClick(){
        const isUserLoggedIn = this.element.dataset.userLoggedIn;
        if(isUserLoggedIn === "false"){
            document.querySelector(".js-login").click();
            return;
        }
        const userId = this.element.dataset.userId;
        const propertyId = this.element.dataset.propertyId;
        
        if(this.element.dataset.status == "false"){
            this.updateWishlistStatus(propertyId, userId);
        }else{
            console.log("destroy action")
            const wishlistId = this.element.dataset.wishlistId;
            this.removePropertyFromWishlist(wishlistId);
        }
    }

    updateWishlistStatus(propertyId, userId){
        const params = {
            user_id: userId,
            property_id: propertyId
        };
        const options = {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(params),
        };
        fetch('/api/wishlists', options)
            .then(response => {
              if (!response.ok) {
                console.log('Network response was not ok', response.status);
              }
              return response.json();
            })
            .then(data => {
                console.log("success", data)
                this.element.dataset.wishlistId = data.id
                this.element.classList.remove("fill-none")
                this.element.classList.add("fill-primary")
                this.element.dataset.status = "true"
            })
            .catch(error => {
              console.error('Error:', error);
            });
        }
    removePropertyFromWishlist(wishlistId){
        const options = {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
        };
        fetch('/api/wishlists/'+wishlistId, options)
            .then(response => {
                this.element.dataset.wishlistId = ''
                this.element.classList.remove("fill-primary")
                this.element.classList.add("fill-none")
                this.element.dataset.status = "false"
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
}
