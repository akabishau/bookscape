import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['icon', 'dropdown', 'logo'];

  connect() {
    console.log('Menu controller connected!');
  }

  toggle() {
    // Toggle the menu open/close class
    this.element.classList.toggle('header--menu--open');

    // Toggle the dropdown's visibility with a separate class
    this._toggleDropdown();

    // Toggle menu icon
    this._toggleIcon();

    // Toggle logo (black/white)
    this._toggleLogo();
  }

  _toggleDropdown() {
    this.dropdownTarget.classList.toggle('header__dropdown--open');
  }

  _toggleIcon() {
    const currentIcon = this.iconTarget;
    if (currentIcon.src.includes('menu_icon')) {
      currentIcon.src = '/assets/close_icon.svg'; // Show close icon
    } else {
      currentIcon.src = '/assets/menu_icon.svg'; // Show menu icon
    }
  }

  _toggleLogo() {
    if (this.element.classList.contains('header--menu--open')) {
      this.logoTarget.src = '/assets/logo_black.svg'; // Switch to black logo
    } else {
      this.logoTarget.src = '/assets/logo.svg'; // Switch back to default logo
    }
  }
}
