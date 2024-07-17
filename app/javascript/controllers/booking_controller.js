import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  
    static targets = ["checkout","checkin","baseFare","numberOfNights", "serviceFee", "totalAmount"];
    SERVICE_FEE_PERCENTAGE = 0.18;

    connect() {
        flatpickr(this.checkinTarget, {
            minDate: new Date().fp_incr(1),
            onChange: (selectedDates, dateStr, instance) => {
                this.triggerCheckoutDatePickr(selectedDates);
            }
        });
        this.updateDetails();
    }

    triggerCheckoutDatePickr(selectedDates){
        flatpickr(this.checkoutTarget, {
            minDate: new Date(selectedDates).fp_incr(1),
            onChange: (selectedDates, dateStr, instance) => {
                this.updateDetails();
            }
        });
        this.checkoutTarget.click();
    }

    updateDetails(){
        const nightsCount = this.numberOfNights();
        const baseFareValue = this.calculateBaseFare(nightsCount);
        const serviceFeeValue = this.calculateServiceFee(baseFareValue);
        const totalAmount = this.calculateTotalAmount(baseFareValue, serviceFeeValue);
        
        this.numberOfNightsTarget.textContent = nightsCount;
        this.baseFareTarget.textContent = baseFareValue;  
        this.serviceFeeTarget.textContent = serviceFeeValue;
        this.totalAmountTarget.textContent = totalAmount;
    }

    calculateBaseFare(nightsCount){
        return parseFloat(nightsCount * this.element.dataset.perNightPrice).toFixed(2);
    }

    calculateServiceFee(baseFareValue){
        return parseFloat(baseFareValue * this.SERVICE_FEE_PERCENTAGE).toFixed(2);
    }

    calculateTotalAmount(baseFareValue, serviceFeeValue){
        return (parseFloat(baseFareValue) + parseFloat(serviceFeeValue)).toFixed(2);
    }

    numberOfNights(){
        const checkinDate = new Date(this.checkinTarget.value);
        const checkoutDate = new Date(this.checkoutTarget.value);
        return (checkoutDate - checkinDate)/(1000*60*60*24);
    }
}
