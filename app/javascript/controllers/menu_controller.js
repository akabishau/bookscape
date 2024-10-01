import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['icon', 'menu', 'logo'];

  connect() {
    console.log('Menu controller connected!');
  }

  toggle() {
    this.element.classList.toggle('header--menu-open');

    const currentIcon = this.iconTarget;
    // TODO: Refactor this...
    if (currentIcon.src.includes('menu_icon')) {
      currentIcon.src = '/assets/close_icon.svg'; //
    } else {
      currentIcon.src = '/assets/menu_icon.svg'; //
    }

    // Check if the menu is open and switch the logo accordingly
    if (this.element.classList.contains('header--menu-open')) {
      this.logoTarget.src = '/assets/logo_black.svg'; // Change to black logo
    } else {
      this.logoTarget.src = '/assets/logo.svg'; // Change back to default logo
    }

    console.log('Menu button toggled!');
  }
}
