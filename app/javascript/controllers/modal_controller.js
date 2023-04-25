import { Controller } from "@hotwired/stimulus"
import { Modal } from 'flowbite';

// Connects to data-controller="modal"
export default class extends Controller {
  static values = { 
    options: {
      type: Object,
      default: {
        placement: 'center-center', // {top|center|bottom}-{left|center|right}
        backdrop: 'dynamic', // Choose between 'static' or 'dynamic' to prevent closing the modal when clicking outside.
        backdropClasses: 'bg-black bg-opacity-50 fixed inset-0 z-40',
        closable: true, // Whether the modal can be closed by clicking outside (only works when backdrop is set to 'dynamic').
      }
    },
    hidden: {
      type: Boolean,
      default: true
    }
  }

  connect() {
    this.modal = new Modal(this.element, this.optionsValue);
    if (!this.hiddenValue) {
      this.modal.show();
    }
  }

  disconnect() {
    this.hide()
  }

  show() {
    this.modal.show();
  }

  hide() {
    this.modal.hide();
  }

  toggle() {
    this.modal.toggle();
  }
}
