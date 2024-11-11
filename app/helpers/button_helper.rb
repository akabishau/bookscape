module ButtonHelper
  def cta_button(text, variant: :primary, disabled: false, leading_icon: nil, trailing_icon: nil)
    classes = [ "cta-button", "cta-button--#{variant}" ]
    classes << "cta-button--disabled" if disabled

    # Add leading and trailing icons if present
    content_tag(:button, class: classes.join(" "), disabled: disabled) do
      concat(content_tag(:span, leading_icon, class: "cta-button__icon cta-button__icon--leading")) if leading_icon
      concat(content_tag(:span, text))
      concat(content_tag(:span, trailing_icon, class: "cta-button__icon cta-button__icon--trailing")) if trailing_icon
    end
  end
end
