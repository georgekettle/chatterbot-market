import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Import and register external Stimulus controllers
import PasswordVisibility from 'stimulus-password-visibility'
application.register('password-visibility', PasswordVisibility)

import TextareaAutogrow from 'stimulus-textarea-autogrow'
application.register('textarea-autogrow', TextareaAutogrow)

import Reveal from 'stimulus-reveal-controller'
application.register('reveal', Reveal)

export { application }

